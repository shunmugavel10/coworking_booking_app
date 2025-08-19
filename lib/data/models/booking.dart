class Booking {
  final String id;
  final String branchId;
  final DateTime date;
  final String timeSlot; // e.g., "10:00 - 12:00"
  final bool completed;

  Booking({required this.id, required this.branchId, required this.date, required this.timeSlot, this.completed = false});

  Booking copyWith({bool? completed}) => Booking(
    id: id, branchId: branchId, date: date, timeSlot: timeSlot, completed: completed ?? this.completed);
}
