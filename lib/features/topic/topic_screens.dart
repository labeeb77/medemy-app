import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/states.dart';
import '../practice/models.dart';
import '../practice/practice_screens.dart';
import 'block_renderers.dart';
import 'models.dart';
import 'topic_repository.dart';

class TopicOverviewScreen extends ConsumerWidget {
  const TopicOverviewScreen({super.key, required this.topicPlacementId, this.title});
  final String topicPlacementId;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = (topicPlacementId: topicPlacementId, mode: null);
    final content = ref.watch(topicContentProvider(request));
    return Scaffold(
      appBar: AppBar(title: Text(content.value?.title ?? title ?? 'Topic')),
      body: AsyncView<TopicContent>(
        value: content,
        onRetry: () => ref.invalidate(topicContentProvider(request)),
        onBack: () => context.pop(),
        data: (topic) => ListView(padding: const EdgeInsets.all(Space.lg), children: [
          Text(topic.title, style: context.text.headlineSmall),
          const SizedBox(height: Space.xs),
          Text('Choose how you want to study this topic.', style: context.text.bodyMedium),
          const SizedBox(height: Space.lg),
          for (final mode in ContentMode.values) _ModeCard(topic: topic, mode: mode),
          Card(child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.sm),
            leading: Icon(Icons.quiz_outlined, color: context.scheme.primary),
            title: Text('Practice', style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            subtitle: Text('Questions on this topic, with the reasoning for each answer.', style: context.text.bodyMedium),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/practice/setup', extra: PracticeSetup(category: PracticeCategory.topic, contextId: topic.topicPlacementId, contextTitle: topic.title)),
          )),
        ]),
      ),
    );
  }
}

const _modeDetails = {
  ContentMode.learn: (Icons.menu_book_outlined, 'Read the topic in full, step by step.'),
  ContentMode.revise: (Icons.replay_outlined, 'Concise recall of the essentials.'),
  ContentMode.highYield: (Icons.star_outline_rounded, 'An exam revision layer built from the same approved topic.'),
};

class _ModeCard extends StatelessWidget {
  const _ModeCard({required this.topic, required this.mode});
  final TopicContent topic;
  final ContentMode mode;

  @override
  Widget build(BuildContext context) {
    final count = topic.blocks.where((block) => block.mode == mode.apiValue).length;
    final (icon, description) = _modeDetails[mode]!;
    final accent = mode == ContentMode.highYield ? context.colors.highYield : context.scheme.primary;
    return Padding(
      padding: const EdgeInsets.only(bottom: Space.md),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.sm),
          leading: Icon(icon, color: count == 0 ? context.colors.secondaryText : accent),
          title: Text(mode.label, style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
          subtitle: Text(count == 0 ? 'Not available for this topic yet.' : description, style: context.text.bodyMedium),
          trailing: count == 0 ? null : const Icon(Icons.chevron_right),
          onTap: count == 0 ? null : () => context.push('/topics/${topic.topicPlacementId}/${mode.name}', extra: topic.title),
        ),
      ),
    );
  }
}

class TopicContentScreen extends ConsumerWidget {
  const TopicContentScreen({super.key, required this.topicPlacementId, required this.mode, this.title});
  final String topicPlacementId;
  final ContentMode mode;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = (topicPlacementId: topicPlacementId, mode: mode);
    final content = ref.watch(topicContentProvider(request));
    final accent = mode == ContentMode.highYield ? context.colors.highYield : context.scheme.primary;
    return Scaffold(
      appBar: AppBar(title: Text(content.value?.title ?? title ?? 'Topic'),
          bottom: PreferredSize(preferredSize: const Size.fromHeight(32), child: Container(
              width: double.infinity, padding: const EdgeInsets.fromLTRB(Space.lg, 0, Space.lg, Space.sm),
              child: Text(mode.label, style: context.text.labelMedium?.copyWith(color: accent, fontWeight: FontWeight.w700))))),
      body: AsyncView<TopicContent>(
        value: content,
        onRetry: () => ref.invalidate(topicContentProvider(request)),
        onBack: () => context.pop(),
        data: (topic) => topic.blocks.isEmpty
            ? const StatePanel(icon: Icons.article_outlined, title: 'Nothing here yet', message: 'This view has no content for the topic yet.')
            // Reading width is capped on tablets; on phones the padding gives the 16 px gutter.
            : Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 680), child: ListView.separated(
                padding: const EdgeInsets.all(Space.lg), itemCount: topic.blocks.length,
                separatorBuilder: (_, _) => const SizedBox(height: Space.md),
                itemBuilder: (context, index) => BlockCard(block: topic.blocks[index], accent: accent)))),
      ),
    );
  }
}

class BlockCard extends StatelessWidget {
  const BlockCard({super.key, required this.block, required this.accent});
  final ContentBlock block;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Space.lg),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if ((block.title ?? '').isNotEmpty) Padding(padding: const EdgeInsets.only(bottom: Space.sm),
              child: Semantics(header: true, child: Text(block.title!, style: context.text.titleMedium))),
          if (canRender(block)) ...renderBlockBody(context, block) else const _UnsupportedBlock(),
          for (final asset in block.assets) Padding(padding: const EdgeInsets.only(top: Space.md), child: _AssetThumbnail(asset: asset)),
          if (block.citations.isNotEmpty) Align(alignment: Alignment.centerLeft, child: TextButton.icon(
              onPressed: () => showSources(context, block.citations), icon: const Icon(Icons.source_outlined, size: 18),
              label: Text('Sources (${block.citations.length})'), style: TextButton.styleFrom(foregroundColor: accent))),
        ]),
      ),
    );
  }
}

/// Shown for a block type or schema version this build of the app does not know.
class _UnsupportedBlock extends StatelessWidget {
  const _UnsupportedBlock();
  @override
  Widget build(BuildContext context) => Row(children: [
        Icon(Icons.system_update_outlined, color: context.colors.secondaryText),
        const SizedBox(width: Space.sm),
        Expanded(child: Text('Update the app to view this part of the topic.', style: context.text.bodyMedium)),
      ]);
}

class _AssetThumbnail extends StatelessWidget {
  const _AssetThumbnail({required this.asset});
  final BlockAsset asset;

  @override
  Widget build(BuildContext context) {
    final label = asset.altText ?? 'Educational visual';
    return Semantics(
      label: '$label. Double tap to enlarge.', button: true,
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(fullscreenDialog: true, builder: (_) => VisualViewer(asset: asset))),
        child: ClipRRect(borderRadius: BorderRadius.circular(Radii.control), child: ExcludeSemantics(child: Image.network(asset.url, fit: BoxFit.contain,
            errorBuilder: (context, _, _) => Container(height: 120, alignment: Alignment.center, color: context.colors.primaryTint,
                child: Text('This visual could not be loaded.', style: context.text.bodyMedium))))),
      ),
    );
  }
}

/// Full-screen visual with pinch zoom and pan, and its alt text as the caption.
class VisualViewer extends StatelessWidget {
  const VisualViewer({super.key, required this.asset});
  final BlockAsset asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visual')),
      body: SafeArea(child: Column(children: [
        Expanded(child: InteractiveViewer(maxScale: 5, child: Center(child: Image.network(asset.url, semanticLabel: asset.altText ?? 'Educational visual',
            errorBuilder: (context, _, _) => const StatePanel(icon: Icons.broken_image_outlined, title: 'This visual could not be loaded'))))),
        if ((asset.altText ?? '').isNotEmpty) Padding(padding: const EdgeInsets.all(Space.lg), child: Text(asset.altText!, style: context.text.bodyMedium, textAlign: TextAlign.center)),
      ])),
    );
  }
}

String describeCitation(Citation citation) {
  final pages = citation.pageFrom == null ? '' : citation.pageTo != null && citation.pageTo != citation.pageFrom
      ? ', pages ${citation.pageFrom}–${citation.pageTo}' : ', page ${citation.pageFrom}';
  final version = citation.resourceVersion == null ? '' : ' (version ${citation.resourceVersion})';
  return '${citation.resourceTitle}$version$pages${(citation.section ?? '').isEmpty ? '' : ', ${citation.section}'}';
}

void showSources(BuildContext context, List<Citation> citations) {
  showModalBottomSheet<void>(
    context: context, showDragHandle: true,
    builder: (context) => SafeArea(child: ListView(shrinkWrap: true, padding: const EdgeInsets.fromLTRB(Space.lg, 0, Space.lg, Space.lg), children: [
      Text('Sources', style: context.text.titleMedium),
      const SizedBox(height: Space.sm),
      for (final citation in citations) Padding(padding: const EdgeInsets.symmetric(vertical: Space.xs), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.menu_book_outlined, size: 18, color: context.colors.secondaryText),
        const SizedBox(width: Space.sm),
        Expanded(child: Text(describeCitation(citation), style: context.text.bodyLarge)),
      ])),
    ])),
  );
}
