import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/app_notification.dart';

class NotificationNotifier extends StateNotifier<List<AppNotification>> {
  NotificationNotifier(): super(const []);

  void push(String title, String body) {
    final n = AppNotification(id: DateTime.now().microsecondsSinceEpoch.toString(), title: title, body: body, timestamp: DateTime.now());
    state = [n, ...state];
  }
}

final notificationsProvider = StateNotifierProvider<NotificationNotifier, List<AppNotification>>((_) => NotificationNotifier());
