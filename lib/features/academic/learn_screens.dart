import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/session.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/states.dart';
import 'academic_repository.dart';
import 'models.dart';

class SubjectTile extends StatelessWidget {
  const SubjectTile({super.key, required this.subject});
  final CurriculumNode subject;

  @override
  Widget build(BuildContext context) {
    final units = subject.unitCount ?? 0;
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.sm),
        title: Text(subject.title, style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Padding(padding: const EdgeInsets.only(top: Space.xs), child: subject.comingSoon
            ? Align(alignment: Alignment.centerLeft, child: StatusChip(icon: Icons.schedule, label: 'Coming soon', color: context.colors.warning))
            : Text('$units ${units == 1 ? 'unit' : 'units'}', style: context.text.bodyMedium)),
        trailing: subject.comingSoon ? null : const Icon(Icons.chevron_right),
        // A coming-soon subject is announced but cannot be opened.
        onTap: subject.comingSoon ? null : () => context.push('/learn/subjects/${subject.id}', extra: subject.title),
      ),
    );
  }
}

class _SubjectList extends ConsumerWidget {
  const _SubjectList({required this.header});
  final Widget header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncView<List<CurriculumNode>>(
      value: ref.watch(currentSubjectsProvider),
      onRetry: () => ref.invalidate(currentSubjectsProvider),
      data: (subjects) => RefreshIndicator(
        onRefresh: () => ref.refresh(currentSubjectsProvider.future),
        child: ListView(padding: const EdgeInsets.all(Space.lg), children: [
          header,
          const SizedBox(height: Space.lg),
          if (subjects.isEmpty)
            const Padding(padding: EdgeInsets.only(top: Space.xxl), child: StatePanel(icon: Icons.menu_book_outlined, title: 'Nothing here yet',
                message: 'Subjects for this semester have not been published yet.'))
          else
            for (final subject in subjects) Padding(padding: const EdgeInsets.only(bottom: Space.md), child: SubjectTile(subject: subject)),
        ]),
      ),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(studentProvider)?.profile?.displayName ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text('Medemy')),
      body: _SubjectList(header: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name.isEmpty ? 'Welcome' : 'Welcome, ${name.split(' ').first}', style: context.text.headlineSmall),
        const SizedBox(height: Space.xs),
        Text('Pick up a subject from your current semester.', style: context.text.bodyMedium),
      ])),
    );
  }
}

class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn')),
      body: _SubjectList(header: Row(children: [
        Expanded(child: Text('Your subjects', style: context.text.titleMedium)),
        TextButton(onPressed: () => context.push('/profile/semester'), child: const Text('Change semester')),
      ])),
    );
  }
}

class SubjectScreen extends ConsumerWidget {
  const SubjectScreen({super.key, required this.subjectId, this.title});
  final String subjectId;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'Subject')),
      body: AsyncView<List<CurriculumNode>>(
        value: ref.watch(unitsProvider(subjectId)),
        onRetry: () => ref.invalidate(unitsProvider(subjectId)),
        onBack: () => context.pop(),
        data: (units) => units.isEmpty
            ? const StatePanel(icon: Icons.folder_open_outlined, title: 'No units yet', message: 'Units for this subject have not been published yet.')
            : ListView(padding: const EdgeInsets.all(Space.lg), children: [
                for (final unit in units) Padding(padding: const EdgeInsets.only(bottom: Space.md), child: _UnitSection(unit: unit)),
              ]),
      ),
    );
  }
}

class _UnitSection extends ConsumerWidget {
  const _UnitSection({required this.unit});
  final CurriculumNode unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (unit.comingSoon) {
      return Card(child: ListTile(title: Text(unit.title, style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
          subtitle: Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.only(top: Space.xs),
              child: StatusChip(icon: Icons.schedule, label: 'Coming soon', color: context.colors.warning)))));
    }
    final topics = unit.topicCount ?? 0;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        shape: const Border(), collapsedShape: const Border(),
        title: Text(unit.title, style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text('$topics ${topics == 1 ? 'topic' : 'topics'}', style: context.text.bodyMedium),
        // Topics load only when the unit is opened.
        children: [Consumer(builder: (context, ref, _) => ref.watch(topicsProvider(unit.id)).when(
              skipLoadingOnRefresh: true,
              loading: () => const Padding(padding: EdgeInsets.all(Space.lg), child: LinearProgressIndicator(semanticsLabel: 'Loading topics')),
              error: (_, _) => ListTile(leading: const Icon(Icons.error_outline), title: const Text('Could not load topics'),
                  trailing: TextButton(onPressed: () => ref.invalidate(topicsProvider(unit.id)), child: const Text('Retry'))),
              data: (items) => items.isEmpty
                  ? const ListTile(title: Text('No topics published yet'))
                  : Column(children: [for (final topic in items) TopicRow(topic: topic)]),
            ))],
      ),
    );
  }
}

class TopicRow extends StatelessWidget {
  const TopicRow({super.key, required this.topic, this.depth = 0});
  final TopicNode topic;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        contentPadding: EdgeInsets.only(left: Space.lg + depth * Space.lg, right: Space.lg),
        title: Text(topic.title, style: context.text.bodyLarge),
        subtitle: topic.comingSoon ? Align(alignment: Alignment.centerLeft, child: StatusChip(icon: Icons.schedule, label: 'Coming soon', color: context.colors.warning)) : null,
        trailing: topic.hasContent ? const Icon(Icons.chevron_right) : null,
        // A heading or an unpublished topic has nothing to open.
        onTap: topic.hasContent ? () => context.push('/topics/${topic.id}', extra: topic.title) : null,
      ),
      for (final child in topic.children) TopicRow(topic: child, depth: depth + 1),
    ]);
  }
}
