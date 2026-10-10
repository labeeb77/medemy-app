import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_failure.dart';
import '../theme/app_theme.dart';

/// A centred icon, title, message and optional action: the common shape of empty, error and unavailable states.
class StatePanel extends StatelessWidget {
  const StatePanel({super.key, required this.icon, required this.title, this.message, this.actionLabel, this.onAction});

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Space.xl),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 40, color: context.colors.secondaryText),
          const SizedBox(height: Space.md),
          Text(title, style: context.text.titleMedium, textAlign: TextAlign.center),
          if (message != null) ...[const SizedBox(height: Space.sm), Text(message!, style: context.text.bodyMedium, textAlign: TextAlign.center)],
          if (actionLabel != null && onAction != null) ...[const SizedBox(height: Space.lg), OutlinedButton(onPressed: onAction, child: Text(actionLabel!))],
        ]),
      ),
    );
  }
}

/// Content the student cannot open. A 404 never says whether it is hidden, unpublished, or outside their plan.
class UnavailablePanel extends StatelessWidget {
  const UnavailablePanel({super.key, this.onBack});
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) => StatePanel(icon: Icons.lock_clock_outlined, title: 'Not available yet',
      message: 'This content is not available to you right now. Explore the topics that are ready.', actionLabel: onBack == null ? null : 'Go back', onAction: onBack);
}

/// Placeholder blocks shaped like the content that is loading.
class LoadingList extends StatelessWidget {
  const LoadingList({super.key, this.rows = 4});
  final int rows;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Loading',
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(Space.lg),
        itemCount: rows,
        separatorBuilder: (_, _) => const SizedBox(height: Space.md),
        itemBuilder: (context, _) => Container(height: 72,
            decoration: BoxDecoration(color: context.colors.border.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(Radii.card))),
      ),
    );
  }
}

/// Renders an [AsyncValue] with the app's loading, unavailable, offline and error states, so no screen improvises them.
class AsyncView<T> extends StatelessWidget {
  const AsyncView({super.key, required this.value, required this.onRetry, required this.data, this.onBack});

  final AsyncValue<T> value;
  final VoidCallback onRetry;
  final Widget Function(T data) data;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnRefresh: true,
      data: data,
      loading: () => const LoadingList(),
      error: (error, _) {
        if (error is ApiFailure && error.isNotFound) return UnavailablePanel(onBack: onBack);
        final offline = error is ApiFailure && error.isOffline;
        return StatePanel(icon: offline ? Icons.wifi_off_outlined : Icons.error_outline,
            title: offline ? 'You are offline' : 'Something went wrong',
            message: error is ApiFailure ? error.message : 'Please try again.', actionLabel: 'Try again', onAction: onRetry);
      },
    );
  }
}

/// A coloured chip that always pairs its colour with an icon and words.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Space.sm, vertical: Space.xs),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(99)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: Space.xs),
        Flexible(child: Text(label, style: context.text.labelMedium?.copyWith(color: color))),
      ]),
    );
  }
}
