import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/api/api_failure.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/failures.dart';
import '../../core/widgets/states.dart';
import 'models.dart';
import 'practice_repository.dart';

String _questions(int count) => '$count ${count == 1 ? 'question' : 'questions'}';
String _when(DateTime? time) {
  if (time == null) return '';
  final local = time.toLocal();
  return '${local.day}/${local.month}/${local.year}';
}

String describeSession(PracticeSession session) => session.isCompleted
    ? '${_questions(session.totalQuestions)} · ${session.scorePercentage == null ? 'not scored' : '${session.scorePercentage!.round()}%'} · ${_when(session.completedAt)}'
    : '${_questions(session.totalQuestions)} · in progress';

void openSession(BuildContext context, PracticeSession session) =>
    context.push(session.isCompleted ? '/practice/sessions/${session.id}/results' : '/practice/sessions/${session.id}');

class SessionTile extends StatelessWidget {
  const SessionTile({super.key, required this.session});
  final PracticeSession session;

  @override
  Widget build(BuildContext context) {
    final category = PracticeCategory.fromApi(session.category);
    return ListTile(
      leading: Icon(category.icon),
      title: Text(category.label, style: context.text.bodyLarge),
      subtitle: Text(describeSession(session), style: context.text.bodyMedium),
      trailing: session.isCompleted ? const Icon(Icons.chevron_right) : StatusChip(icon: Icons.play_arrow_rounded, label: 'Resume', color: context.scheme.primary),
      onTap: () => openSession(context, session),
    );
  }
}

class PracticeHubScreen extends ConsumerWidget {
  const PracticeHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recent = ref.watch(recentSessionsProvider);
    final sessions = recent.value ?? const <PracticeSession>[];
    final active = sessions.where((session) => !session.isCompleted).firstOrNull;
    return Scaffold(
      appBar: AppBar(title: const Text('Practice')),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(recentSessionsProvider.future),
        child: ListView(padding: const EdgeInsets.all(Space.lg), children: [
          if (active != null) ...[
            Card(color: context.colors.primaryTint, child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.sm),
              title: Text('Continue your session', style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              subtitle: Text('${PracticeCategory.fromApi(active.category).label} · ${_questions(active.totalQuestions)}', style: context.text.bodyMedium),
              trailing: FilledButton(onPressed: () => openSession(context, active), child: const Text('Resume')),
            )),
            const SizedBox(height: Space.lg),
          ],
          Text('Choose what to practise', style: context.text.titleMedium),
          const SizedBox(height: Space.md),
          for (final category in PracticeCategory.values) Padding(padding: const EdgeInsets.only(bottom: Space.sm), child: Card(child: ListTile(
            leading: Icon(category.icon, color: category == PracticeCategory.highYield ? context.colors.highYield : context.scheme.primary),
            title: Text(category.label, style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            subtitle: Text(category.needsContext ? '${category.description} Start from a ${category.name} in Learn.' : category.description, style: context.text.bodyMedium),
            trailing: const Icon(Icons.chevron_right),
            // Topic and unit practice need a topic or unit, so they begin in the Learn tab.
            onTap: () => category.needsContext ? context.go('/learn') : context.push('/practice/setup', extra: PracticeSetup(category: category)),
          ))),
          const SizedBox(height: Space.lg),
          Row(children: [
            Expanded(child: Text('Recent sessions', style: context.text.titleMedium)),
            if (sessions.isNotEmpty) TextButton(onPressed: () => context.push('/practice/history'), child: const Text('See all')),
          ]),
          if (recent.isLoading && sessions.isEmpty) const Padding(padding: EdgeInsets.all(Space.lg), child: LinearProgressIndicator(semanticsLabel: 'Loading sessions'))
          else if (recent.hasError && sessions.isEmpty) ListTile(leading: const Icon(Icons.error_outline), title: const Text('Could not load your sessions'),
              trailing: TextButton(onPressed: () => ref.invalidate(recentSessionsProvider), child: const Text('Retry')))
          else if (sessions.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: Space.md), child: Text('You have not practised yet.', style: context.text.bodyMedium))
          else Card(child: Column(children: [for (final session in sessions.take(3)) SessionTile(session: session)])),
        ]),
      ),
    );
  }
}

/// What a new session is for: a category and, for topic and unit practice, which one.
class PracticeSetup {
  const PracticeSetup({required this.category, this.contextId, this.contextTitle});
  final PracticeCategory category;
  final String? contextId;
  final String? contextTitle;
}

class PracticeSetupScreen extends ConsumerStatefulWidget {
  const PracticeSetupScreen({super.key, required this.setup});
  final PracticeSetup setup;
  @override
  ConsumerState<PracticeSetupScreen> createState() => _PracticeSetupScreenState();
}

class _PracticeSetupScreenState extends ConsumerState<PracticeSetupScreen> {
  int _count = 10;
  bool _busy = false;
  bool _nothing = false;
  String? _error;

  Future<void> _start() async {
    setState(() { _busy = true; _error = null; });
    try {
      final session = await ref.read(practiceRepositoryProvider).start(category: widget.setup.category, contextId: widget.setup.contextId, questionCount: _count);
      ref.invalidate(recentSessionsProvider);
      if (!mounted) return;
      // A shorter session than asked for is normal; the session screen says so, where it cannot cover the Submit button.
      context.pushReplacement('/practice/sessions/${session.id}',
          extra: session.totalQuestions < _count ? 'Only ${_questions(session.totalQuestions)} available, so this session is shorter.' : null);
    } on ApiFailure catch (failure) {
      if (!mounted) return;
      setState(() { if (failure.code == 'NO_ELIGIBLE_QUESTIONS') { _nothing = true; } else { _error = describeFailure(failure); } });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final setup = widget.setup;
    return Scaffold(
      appBar: AppBar(title: Text('${setup.category.label} practice')),
      body: SafeArea(
        child: _nothing
            ? StatePanel(icon: Icons.inbox_outlined, title: 'Nothing to practise here yet',
                message: 'There are no questions in ${setup.category.label} for you right now. Try another category.', actionLabel: 'Back to Practice', onAction: () => context.pop())
            : ListView(padding: const EdgeInsets.all(Space.xl), children: [
                Icon(setup.category.icon, size: 40, color: context.scheme.primary),
                const SizedBox(height: Space.md),
                Text(setup.contextTitle ?? setup.category.label, style: context.text.headlineSmall),
                const SizedBox(height: Space.xs),
                Text(setup.category.description, style: context.text.bodyMedium),
                const SizedBox(height: Space.xl),
                Text('Number of questions', style: context.text.labelMedium),
                const SizedBox(height: Space.sm),
                Row(children: [
                  IconButton.outlined(tooltip: 'Fewer questions', onPressed: _busy || _count <= 1 ? null : () => setState(() => _count = (_count - 5).clamp(1, 100)), icon: const Icon(Icons.remove)),
                  Expanded(child: Semantics(liveRegion: true, child: Text(_questions(_count), style: context.text.titleMedium, textAlign: TextAlign.center))),
                  IconButton.outlined(tooltip: 'More questions', onPressed: _busy || _count >= 100 ? null : () => setState(() => _count = _count == 1 ? 5 : (_count + 5).clamp(1, 100)), icon: const Icon(Icons.add)),
                ]),
                const SizedBox(height: Space.lg),
                Text('You will see why each answer is right or wrong straight after you submit it. Your first answer is final.', style: context.text.bodyMedium),
                if (_error != null) Padding(padding: const EdgeInsets.only(top: Space.lg), child: Text(_error!, style: TextStyle(color: context.scheme.error))),
                const SizedBox(height: Space.xl),
                FilledButton(onPressed: _busy ? null : _start, child: Text(_busy ? 'Starting…' : 'Start practice')),
              ]),
      ),
    );
  }
}

/// One question at a time: choose, submit, read the feedback, move on.
class PracticeSessionScreen extends ConsumerStatefulWidget {
  const PracticeSessionScreen({super.key, required this.sessionId, this.notice});
  final String sessionId;
  /// Shown once, above the first question.
  final String? notice;
  @override
  ConsumerState<PracticeSessionScreen> createState() => _PracticeSessionScreenState();
}

class _PracticeSessionScreenState extends ConsumerState<PracticeSessionScreen> {
  int? _index;
  String? _selected;
  bool _busy = false;
  String? _error;
  final _shownAt = Stopwatch();

  PracticeSessionController get _controller => ref.read(practiceSessionProvider(widget.sessionId).notifier);

  Future<void> _submit(PracticeItem item) async {
    setState(() { _busy = true; _error = null; });
    try {
      final answered = await _controller.answer(item.id, _selected!, responseTimeMs: _shownAt.elapsedMilliseconds);
      if (!mounted) return;
      SemanticsService.sendAnnouncement(View.of(context), answered.attempt!.isCorrect ? 'Correct' : 'Incorrect', TextDirection.ltr);
    } catch (error) {
      // The selection is kept: sending the same answer again is safe.
      if (mounted) setState(() => _error = describeFailure(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _finish() async {
    setState(() { _busy = true; _error = null; });
    try {
      await _controller.complete();
      if (mounted) context.pushReplacement('/practice/sessions/${widget.sessionId}/results');
    } catch (error) {
      if (mounted) setState(() { _error = describeFailure(error); _busy = false; });
    }
  }

  Future<void> _menu(String choice, PracticeSession session) async {
    final finish = choice == 'finish';
    final confirmed = await showDialog<bool>(context: context, builder: (context) => AlertDialog(
        title: Text(finish ? 'Finish now?' : 'Leave this session?'),
        content: Text(finish ? 'You have answered ${session.answered} of ${session.totalQuestions}. Your score is based on the questions you answered.'
            : 'Your answers so far are saved. You can resume this session from Practice.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Keep going')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(finish ? 'Finish' : 'Leave'))]));
    if (confirmed != true || !mounted) return;
    if (finish) return _finish();
    ref.invalidate(recentSessionsProvider);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(practiceSessionProvider(widget.sessionId));
    final session = value.value;
    return Scaffold(
      appBar: AppBar(title: Text(session == null ? 'Practice' : PracticeCategory.fromApi(session.category).label), actions: [
        if (session != null && !session.isCompleted) PopupMenuButton<String>(tooltip: 'Session options', onSelected: (choice) => _menu(choice, session), itemBuilder: (_) => const [
          PopupMenuItem(value: 'finish', child: Text('Finish and see results')),
          PopupMenuItem(value: 'leave', child: Text('Leave and resume later')),
        ]),
      ]),
      body: SafeArea(child: AsyncView<PracticeSession>(
        value: value,
        onRetry: () => ref.invalidate(practiceSessionProvider(widget.sessionId)),
        onBack: () => context.pop(),
        data: (session) {
          if (session.isCompleted) {
            return StatePanel(icon: Icons.check_circle_outline, title: 'This session is finished', actionLabel: 'See results',
                onAction: () => context.pushReplacement('/practice/sessions/${session.id}/results'));
          }
          if (session.items.isEmpty) return const StatePanel(icon: Icons.inbox_outlined, title: 'This session has no questions');
          // Resume at the first unanswered question.
          final index = (_index ??= session.nextUnanswered ?? session.items.length - 1).clamp(0, session.items.length - 1);
          final item = session.items[index];
          if (item.attempt == null && !_shownAt.isRunning) _shownAt..reset()..start();
          final last = index == session.items.length - 1;
          return Column(children: [
            Padding(padding: const EdgeInsets.fromLTRB(Space.lg, Space.md, Space.lg, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Question ${index + 1} of ${session.items.length}', style: context.text.labelMedium),
              const SizedBox(height: Space.sm),
              LinearProgressIndicator(value: session.answered / session.items.length, semanticsLabel: 'Answered ${session.answered} of ${session.items.length}'),
              if (widget.notice != null && index == 0) Padding(padding: const EdgeInsets.only(top: Space.sm), child: Text(widget.notice!, style: context.text.bodyMedium)),
            ])),
            Expanded(child: QuestionView(item: item, selected: _selected, onSelect: _busy || item.attempt != null ? null : (key) => setState(() => _selected = key))),
            Padding(padding: const EdgeInsets.all(Space.lg), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              if (_error != null) Padding(padding: const EdgeInsets.only(bottom: Space.sm), child: Semantics(liveRegion: true, child: Text(_error!, style: TextStyle(color: context.scheme.error)))),
              if (item.attempt == null)
                FilledButton(onPressed: _busy || _selected == null ? null : () => _submit(item), child: Text(_busy ? 'Submitting…' : _error != null ? 'Try again' : 'Submit answer'))
              else
                FilledButton(onPressed: _busy ? null : last ? _finish : () => setState(() { _index = index + 1; _selected = null; _error = null; _shownAt.stop(); }),
                    child: Text(_busy ? 'Finishing…' : last ? 'Finish and see results' : 'Next question')),
            ])),
          ]);
        },
      )),
    );
  }
}

/// A question and its options. Once answered, each option says in words whether it was right, and why.
class QuestionView extends StatelessWidget {
  const QuestionView({super.key, required this.item, this.selected, this.onSelect, this.embedded = false});
  final PracticeItem item;
  /// Inside another scrolling list: lay out at full height instead of scrolling on its own.
  final bool embedded;
  final String? selected;
  final ValueChanged<String>? onSelect;

  @override
  Widget build(BuildContext context) {
    final attempt = item.attempt;
    final chosen = attempt?.selectedOptionKey ?? selected;
    return ListView(padding: const EdgeInsets.all(Space.lg), shrinkWrap: embedded, physics: embedded ? const NeverScrollableScrollPhysics() : null, children: [
      Semantics(header: true, child: Text(item.stem, style: context.text.titleMedium)),
      const SizedBox(height: Space.lg),
      // The verdict sits above the options so it is on screen the moment the answer comes back.
      if (attempt != null) Padding(padding: const EdgeInsets.only(bottom: Space.lg), child: Row(children: [
        Icon(attempt.isCorrect ? Icons.check_circle : Icons.cancel, color: attempt.isCorrect ? context.colors.success : context.scheme.error),
        const SizedBox(width: Space.sm),
        Expanded(child: Text(attempt.isCorrect ? 'Correct' : 'Incorrect. The correct answer is ${attempt.correctOptionKey ?? 'marked below'}.', style: context.text.titleMedium)),
      ])),
      for (final option in item.options) Padding(padding: const EdgeInsets.only(bottom: Space.md), child: _OptionTile(option: option,
          isChosen: option.optionKey == chosen, answered: attempt != null, onTap: onSelect == null ? null : () => onSelect!(option.optionKey))),
      if (attempt != null) ...[
        if ((attempt.rationale ?? '').isNotEmpty) ...[const SizedBox(height: Space.sm), Text('Why', style: context.text.labelMedium), Text(attempt.rationale!, style: context.text.bodyLarge)],
        if ((attempt.keyConcept ?? '').isNotEmpty) ...[const SizedBox(height: Space.md), Text('Key concept', style: context.text.labelMedium), Text(attempt.keyConcept!, style: context.text.bodyLarge)],
      ],
    ]);
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.option, required this.isChosen, required this.answered, this.onTap});
  final PracticeOption option;
  final bool isChosen;
  final bool answered;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final correct = answered && option.isCorrect == true;
    final wrongChoice = answered && isChosen && option.isCorrect != true;
    final color = correct ? context.colors.success : wrongChoice ? context.scheme.error : isChosen ? context.scheme.primary : context.colors.border;
    final status = correct ? (isChosen ? 'Your answer, correct' : 'Correct answer') : wrongChoice ? 'Your answer, incorrect' : null;
    return Semantics(
      button: !answered, selected: isChosen, label: 'Option ${option.optionKey}',
      child: InkWell(
        onTap: onTap, borderRadius: BorderRadius.circular(Radii.card),
        child: Container(
          constraints: const BoxConstraints(minHeight: 56), padding: const EdgeInsets.all(Space.md),
          decoration: BoxDecoration(color: isChosen || correct ? color.withValues(alpha: 0.08) : context.scheme.surface,
              border: Border.all(color: color, width: isChosen || correct ? 2 : 1), borderRadius: BorderRadius.circular(Radii.card)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(width: 28, child: Text(option.optionKey, style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w700))),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(option.text, style: context.text.bodyLarge),
              if (status != null) Padding(padding: const EdgeInsets.only(top: Space.xs), child: Row(children: [
                Icon(correct ? Icons.check_circle_outline : Icons.highlight_off, size: 16, color: color),
                const SizedBox(width: Space.xs),
                Flexible(child: Text(status, style: context.text.labelMedium?.copyWith(color: color))),
              ])),
              if (answered && (option.rationale ?? '').isNotEmpty) Padding(padding: const EdgeInsets.only(top: Space.xs), child: Text(option.rationale!, style: context.text.bodyMedium)),
            ])),
            if (!answered) Icon(isChosen ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: color),
          ]),
        ),
      ),
    );
  }
}

class PracticeResultsScreen extends ConsumerWidget {
  const PracticeResultsScreen({super.key, required this.sessionId});
  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(practiceSessionProvider(sessionId));
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: SafeArea(child: AsyncView<PracticeSession>(
        value: value,
        onRetry: () => ref.invalidate(practiceSessionProvider(sessionId)),
        onBack: () => context.pop(),
        data: (session) {
          final score = session.answered == 0 ? null : (session.correct / session.answered * 100).round();
          return ListView(padding: const EdgeInsets.all(Space.xl), children: [
            Text(PracticeCategory.fromApi(session.category).label, style: context.text.labelMedium),
            const SizedBox(height: Space.xs),
            Text(score == null ? 'No questions answered' : '${session.correct} of ${session.answered} correct', style: context.text.headlineSmall),
            if (score != null) Text('$score% of the questions you answered', style: context.text.bodyMedium),
            const SizedBox(height: Space.xl),
            Card(child: Column(children: [
              _CountRow(icon: Icons.check_circle_outline, color: context.colors.success, label: 'Correct', count: session.correct),
              const Divider(),
              _CountRow(icon: Icons.highlight_off, color: context.scheme.error, label: 'Incorrect', count: session.incorrect),
              const Divider(),
              _CountRow(icon: Icons.remove_circle_outline, color: context.colors.secondaryText, label: 'Unanswered', count: session.unanswered),
            ])),
            const SizedBox(height: Space.xl),
            if (session.answered > 0) FilledButton(onPressed: () => context.push('/practice/sessions/$sessionId/review'), child: const Text('Review answers')),
            const SizedBox(height: Space.sm),
            OutlinedButton(onPressed: () => context.go('/practice'), child: const Text('Back to Practice')),
          ]);
        },
      )),
    );
  }
}

class _CountRow extends StatelessWidget {
  const _CountRow({required this.icon, required this.color, required this.label, required this.count});
  final IconData icon;
  final Color color;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) => ListTile(leading: Icon(icon, color: color), title: Text(label, style: context.text.bodyLarge),
      trailing: Text('$count', style: context.text.titleMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()])));
}

enum _ReviewFilter { all('All'), incorrect('Incorrect'), correct('Correct');
  const _ReviewFilter(this.label);
  final String label;
}

class PracticeReviewScreen extends ConsumerStatefulWidget {
  const PracticeReviewScreen({super.key, required this.sessionId});
  final String sessionId;
  @override
  ConsumerState<PracticeReviewScreen> createState() => _PracticeReviewScreenState();
}

class _PracticeReviewScreenState extends ConsumerState<PracticeReviewScreen> {
  _ReviewFilter _filter = _ReviewFilter.all;

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(practiceSessionProvider(widget.sessionId));
    return Scaffold(
      appBar: AppBar(title: const Text('Review answers')),
      body: SafeArea(child: AsyncView<PracticeSession>(
        value: value,
        onRetry: () => ref.invalidate(practiceSessionProvider(widget.sessionId)),
        onBack: () => context.pop(),
        data: (session) {
          final answered = session.items.where((item) => item.attempt != null);
          final shown = answered.where((item) => switch (_filter) {
                _ReviewFilter.all => true, _ReviewFilter.incorrect => !item.attempt!.isCorrect, _ReviewFilter.correct => item.attempt!.isCorrect }).toList();
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsets.fromLTRB(Space.lg, Space.md, Space.lg, 0), child: Wrap(spacing: Space.sm, children: [
              for (final filter in _ReviewFilter.values) ChoiceChip(label: Text(filter.label), selected: _filter == filter, onSelected: (_) => setState(() => _filter = filter)),
            ])),
            Padding(padding: const EdgeInsets.fromLTRB(Space.lg, Space.sm, Space.lg, 0),
                child: Text('These are the questions exactly as you saw them, even if they have since been revised.', style: context.text.bodyMedium)),
            Expanded(child: shown.isEmpty
                ? const StatePanel(icon: Icons.filter_alt_off_outlined, title: 'No questions match this filter')
                : ListView(padding: const EdgeInsets.all(Space.lg), children: [
                    for (final item in shown) Padding(padding: const EdgeInsets.only(bottom: Space.md), child: Card(clipBehavior: Clip.antiAlias, child: ExpansionTile(
                      shape: const Border(), collapsedShape: const Border(),
                      leading: Icon(item.attempt!.isCorrect ? Icons.check_circle_outline : Icons.highlight_off,
                          color: item.attempt!.isCorrect ? context.colors.success : context.scheme.error),
                      title: Text('${item.displayOrder}. ${item.stem}', style: context.text.bodyLarge),
                      subtitle: Text(item.attempt!.isCorrect ? 'Correct' : 'Incorrect', style: context.text.bodyMedium),
                      children: [QuestionView(item: item, embedded: true)],
                    ))),
                  ])),
          ]);
        },
      )),
    );
  }
}

class PracticeHistoryScreen extends ConsumerStatefulWidget {
  const PracticeHistoryScreen({super.key});
  @override
  ConsumerState<PracticeHistoryScreen> createState() => _PracticeHistoryScreenState();
}

class _PracticeHistoryScreenState extends ConsumerState<PracticeHistoryScreen> {
  final _sessions = <PracticeSession>[];
  String? _cursor;
  bool _loading = true;
  bool _done = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final page = await ref.read(practiceRepositoryProvider).history(cursor: _cursor);
      if (!mounted) return;
      setState(() { _sessions.addAll(page.sessions); _cursor = page.nextCursor; _done = page.nextCursor == null; });
    } catch (error) {
      if (mounted) setState(() => _error = describeFailure(error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Practice history')),
      body: SafeArea(child: _sessions.isEmpty && _loading ? const LoadingList()
          : _sessions.isEmpty && _error != null ? StatePanel(icon: Icons.error_outline, title: 'Something went wrong', message: _error, actionLabel: 'Try again', onAction: _load)
          : _sessions.isEmpty ? const StatePanel(icon: Icons.history, title: 'No sessions yet', message: 'Your practice sessions will appear here.')
          : ListView(padding: const EdgeInsets.all(Space.lg), children: [
              Card(child: Column(children: [for (final session in _sessions) SessionTile(session: session)])),
              if (_error != null) Padding(padding: const EdgeInsets.all(Space.md), child: Text(_error!, style: TextStyle(color: context.scheme.error))),
              if (!_done) Padding(padding: const EdgeInsets.only(top: Space.md), child: OutlinedButton(onPressed: _loading ? null : _load, child: Text(_loading ? 'Loading…' : 'Load more'))),
            ])),
    );
  }
}
