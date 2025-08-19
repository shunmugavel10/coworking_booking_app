# Coworking Booking App

A Flutter mobile application for booking coworking spaces.
This project was built as a machine test to demonstrate clean architecture, responsive UI, state management, and real-time features.

A Flutter mobile app that provides an end-to-end coworking space booking flow.

Starts with a splash screen that transitions into the home screen with coworking branches.

Home screen supports search by name, branch, or city and filters by city or maximum price, with a responsive grid/list layout.

Map view displays coworking branches as markers and shows the user’s current location with permission handling.

Details screen includes an image carousel, description, amenities, operating hours, and a “Book Now” button.

Booking screen allows users to select a date and time slot, confirm the booking, and receive a notification.

My Bookings screen lists all upcoming and completed bookings.

Notifications screen displays booking-related alerts generated during the flow.

Built with Flutter, Riverpod for state management, GoRouter for navigation, and ScreenUtil for responsive design.

Uses FlutterMap with MapTiler and Geolocator for maps and location services.

Mock API implemented using local JSON data for coworking branches.

Follows clean architecture with separation of core, data, and presentation layers.

Includes reusable widgets like AppScaffold, AppButton, AppLoading, and AppError for consistent UI.

Supports both light and dark themes with dynamic theme toggle in the app bar.
