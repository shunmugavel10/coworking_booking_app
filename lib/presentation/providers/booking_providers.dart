import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/booking.dart';

class BookingNotifier extends StateNotifier<List<Booking>> {
  BookingNotifier(): super(const []);

  void add(Booking b) => state = [...state, b];
  void markCompleted(String id) => state = [
    for (final b in state) if (b.id == id) b.copyWith(completed: true) else b
  ];
}

final bookingsProvider = StateNotifierProvider<BookingNotifier, List<Booking>>((_) => BookingNotifier());
