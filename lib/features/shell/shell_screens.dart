import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/session.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/states.dart';
import '../academic/academic_repository.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  static const _tabs = [
    (Icons.home_outlined, Icons.home, 'Home'),
    (Icons.menu_book_outlined, Icons.menu_book, 'Learn'),
    (Icons.quiz_outlined, Icons.quiz, 'Practice'),
    (Icons.insights_outlined, Icons.insights, 'Progress'),
    (Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        // Reselecting the open tab returns it to its root; each tab otherwise keeps its own stack.
        onDestinationSelected: (index) => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        destinations: [for (final (icon, selected, label) in _tabs) NavigationDestination(icon: Icon(icon), selectedIcon: Icon(selected), label: label)],
      ),
    );
  }
}

/// A tab whose feature is planned but not built. It says so plainly instead of showing invented data.
class ComingTab extends StatelessWidget {
  const ComingTab({super.key, required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title)),
      body: StatePanel(icon: Icons.construction_outlined, title: 'Coming in the next update', message: message));
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = ref.watch(studentProvider);
    final semesters = ref.watch(semestersProvider).value ?? const [];
    final current = semesters.where((semester) => semester.id == student?.profile?.currentSemesterId).firstOrNull;
    final name = student?.profile?.displayName ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(padding: const EdgeInsets.all(Space.lg), children: [
        Row(children: [
          CircleAvatar(radius: 28, backgroundColor: context.colors.primaryTint,
              child: ExcludeSemantics(child: Text(name.isEmpty ? '?' : name.trim()[0].toUpperCase(), style: context.text.titleMedium?.copyWith(color: context.scheme.primary)))),
          const SizedBox(width: Space.lg),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: context.text.titleMedium),
            Text(student?.email ?? '', style: context.text.bodyMedium),
          ])),
        ]),
        const SizedBox(height: Space.xl),
        Card(child: Column(children: [
          ListTile(leading: const Icon(Icons.school_outlined), title: const Text('Current semester'),
              subtitle: Text(current == null ? 'Not set' : 'Semester ${current.semesterNumber}'), trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/profile/semester')),
          const Divider(),
          ListTile(leading: Icon(Icons.logout, color: context.scheme.error), title: const Text('Sign out'), onTap: () => _confirmSignOut(context, ref)),
        ])),
      ]),
    );
  }

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(context: context, builder: (context) => AlertDialog(
        title: const Text('Sign out?'), content: const Text('You will need your email and password to sign in again.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sign out'))]));
    if (confirmed == true) await ref.read(sessionProvider.notifier).signOut();
  }
}
