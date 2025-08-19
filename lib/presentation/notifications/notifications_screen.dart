import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/widgets/app_scaffold.dart';
import '../providers/notification_providers.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(notificationsProvider);
    return AppScaffold(
      title: 'Notifications',
      currentIndex: 3,
      body: items.isEmpty
          ? const Center(child: Text('No notifications'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, i) {
                final n = items[i];
                return ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(n.title),
                  subtitle: Text(n.body),
                  trailing: Text(DateFormat('HH:mm').format(n.timestamp)),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: items.length,
            ),
    );
  }
}
