import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../providers/branch_providers.dart';
import '../providers/booking_providers.dart';
import '../providers/notification_providers.dart';
import '../../data/models/booking.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final String branchId;
  const BookingScreen({super.key, required this.branchId});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  DateTime _date = DateTime.now();
  String _slot = '10:00 - 12:00';

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(branchesProvider);
    return async.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text(e.toString()))),
      data: (list) {
        final branch = list.firstWhere((b) => b.id == widget.branchId);
        return Scaffold(
          appBar: AppBar(title: Text('Book • ${branch.branch}')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Select date', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              CalendarDatePicker(
                initialDate: _date, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 90)),
                onDateChanged: (d) => setState(() => _date = d),
              ),
              const SizedBox(height: 12),
              Text('Select time slot', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(spacing: 8, children: [
                for (final s in const ['8:00 - 10:00','10:00 - 12:00','12:00 - 14:00','14:00 - 16:00','16:00 - 18:00'])
                  ChoiceChip(label: Text(s), selected: _slot == s, onSelected: (_) => setState(() => _slot = s))
              ]),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    final id = DateTime.now().millisecondsSinceEpoch.toString();
                    ref.read(bookingsProvider.notifier).add(Booking(id: id, branchId: widget.branchId, date: _date, timeSlot: _slot));
                    ref.read(notificationsProvider.notifier).push(
                      'Booking Confirmed',
                      'Your booking at ${branch.name} on ${DateFormat('d MMM, y').format(_date)} ($_slot) is confirmed.'
                    );
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking confirmed')));
                    context.go('/my-bookings');
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text('Confirm • ₹${branch.pricePerHour * 2}'),
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
