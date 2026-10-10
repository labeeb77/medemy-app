import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/session.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/failures.dart';
import '../../core/widgets/states.dart';
import '../academic/academic_repository.dart';
import '../academic/models.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});
  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  late final _name = TextEditingController(text: ref.read(studentProvider)?.profile?.displayName ?? '');
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final name = _name.text.trim();
    if (name.isEmpty) return setState(() => _error = 'Enter the name you would like to be called.');
    setState(() { _busy = true; _error = null; });
    try {
      await ref.read(sessionProvider.notifier).saveDisplayName(name);
      if (mounted) context.go('/setup/semester');
    } catch (error) {
      if (mounted) setState(() => _error = describeFailure(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step 1 of 2')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Space.xl),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('What should we call you?', style: context.text.headlineSmall),
            const SizedBox(height: Space.sm),
            Text('Your name is only used to personalise your learning experience.', style: context.text.bodyMedium),
            const SizedBox(height: Space.xl),
            TextField(controller: _name, textCapitalization: TextCapitalization.words, autofillHints: const [AutofillHints.name],
                decoration: InputDecoration(labelText: 'Display name', errorText: _error), onSubmitted: (_) => _continue()),
            const SizedBox(height: Space.xl),
            FilledButton(onPressed: _busy ? null : _continue, child: Text(_busy ? 'Saving…' : 'Continue')),
          ]),
        ),
      ),
    );
  }
}

/// First-run step 2, and also "Change semester" from Profile.
class SemesterSelectionScreen extends ConsumerStatefulWidget {
  const SemesterSelectionScreen({super.key, this.firstRun = true});
  final bool firstRun;
  @override
  ConsumerState<SemesterSelectionScreen> createState() => _SemesterSelectionScreenState();
}

class _SemesterSelectionScreenState extends ConsumerState<SemesterSelectionScreen> {
  String? _selected;
  bool _busy = false;
  String? _error;

  Future<void> _save() async {
    setState(() { _busy = true; _error = null; });
    try {
      await ref.read(sessionProvider.notifier).chooseSemester(_selected!);
      // On first run the router moves on by itself once a semester exists; from Profile we go back.
      if (mounted && !widget.firstRun) context.pop();
    } catch (error) {
      if (mounted) setState(() => _error = describeFailure(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final semesters = ref.watch(semestersProvider);
    final current = ref.watch(studentProvider)?.profile?.currentSemesterId;
    final selected = _selected ?? current;
    return Scaffold(
      appBar: AppBar(title: Text(widget.firstRun ? 'Step 2 of 2' : 'Change semester')),
      body: SafeArea(
        child: AsyncView<List<Semester>>(
          value: semesters,
          onRetry: () => ref.invalidate(semestersProvider),
          data: (items) => items.isEmpty
              ? const StatePanel(icon: Icons.event_busy_outlined, title: 'No semesters yet', message: 'The curriculum is still being prepared. Please check back soon.')
              : Column(children: [
                  Expanded(child: ListView(padding: const EdgeInsets.all(Space.xl), children: [
                    Text('Which semester are you studying?', style: context.text.headlineSmall),
                    const SizedBox(height: Space.sm),
                    Text('This sets the curriculum on your home screen. You can change it later.', style: context.text.bodyMedium),
                    const SizedBox(height: Space.lg),
                    if (_error != null) Padding(padding: const EdgeInsets.only(bottom: Space.md), child: Text(_error!, style: TextStyle(color: context.scheme.error))),
                    Wrap(spacing: Space.md, runSpacing: Space.md, children: [
                      for (final semester in items)
                        ChoiceChip(
                          label: ConstrainedBox(constraints: const BoxConstraints(minWidth: 120, minHeight: 32),
                              child: Center(child: Text('Semester ${semester.semesterNumber}'))),
                          selected: selected == semester.id, showCheckmark: true,
                          onSelected: _busy ? null : (_) => setState(() => _selected = semester.id),
                        ),
                    ]),
                  ])),
                  Padding(padding: const EdgeInsets.all(Space.xl), child: SizedBox(width: double.infinity,
                      child: FilledButton(onPressed: _busy || selected == null || (!widget.firstRun && selected == current) ? null : () { _selected = selected; _save(); },
                          child: Text(_busy ? 'Saving…' : widget.firstRun ? 'Start learning' : 'Save semester')))),
                ]),
        ),
      ),
    );
  }
}
