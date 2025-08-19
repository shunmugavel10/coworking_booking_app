import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'app_router.dart';

void main() {
  runApp(const ProviderScope(child: AppRoot()));
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (_, __) {
        return MaterialApp.router(
          title: 'Coworking Booking',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          routerConfig: appRouter,
        );
      },
    );
  }
}
