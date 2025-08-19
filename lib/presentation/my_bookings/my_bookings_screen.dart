import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/widgets/app_scaffold.dart';
import '../providers/booking_providers.dart';
import '../providers/branch_providers.dart';

class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingsProvider);
    final branches = ref.watch(branchesProvider).maybeWhen(data: (d) => d, orElse: () => const []);

    return AppScaffold(
      title: 'My Bookings',
      currentIndex: 2,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: bookings.isEmpty
            ? const Center(child: Text('No bookings yet'))
            : ListView.separated(
                itemBuilder: (_, i) {
                  final b = bookings[i];
                  final br = branches.where((e) => e.id == b.branchId).firstOrNull;
                  return ListTile(
                    leading: CircleAvatar(child: Text(DateFormat('d').format(b.date))),
                    title: Text(br?.name ?? b.branchId),
                    subtitle: Text('${DateFormat('EEE, d MMM').format(b.date)} • ${b.timeSlot}'),
                    trailing: Chip(
                      label: Text(b.completed ? 'Completed' : 'Upcoming'),
                      color: WidgetStatePropertyAll(b.completed ? Colors.green.withOpacity(.15) : Colors.orange.withOpacity(.15)),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: bookings.length,
              ),
      ),
    );
  }
}
