import 'package:go_router/go_router.dart';
import 'presentation/splash/splash_screen.dart';
import 'presentation/home/home_screen.dart';
import 'presentation/details/details_screen.dart';
import 'presentation/booking/booking_screen.dart';
import 'presentation/my_bookings/my_bookings_screen.dart';
import 'presentation/notifications/notifications_screen.dart';
import 'presentation/map/map_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'details',
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            return DetailsScreen(id: id);
          },
        ),
        GoRoute(
          path: 'booking',
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            return BookingScreen(branchId: id);
          },
        ),
      ],
    ),
    GoRoute(path: '/my-bookings', builder: (_, __) => const MyBookingsScreen()),
    GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),
    GoRoute(path: '/map', builder: (_, __) => const MapScreen()),
  ],
);
