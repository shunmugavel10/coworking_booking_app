import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () => context.go('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 🌈 Gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 254, 254, 255), // purple
              Color.fromARGB(255, 178, 178, 179), // violet
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🖼️ Logo
              Image.asset(
                "assets/coworking_space.png",
                width: 120,
                height: 120,
              )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .scale(delay: 200.ms),

              const SizedBox(height: 20),

              // 📝 Title
              Text(
                'Coworking Booking',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: const Color.fromARGB(255, 1, 10, 74),
                      fontWeight: FontWeight.w600,
                      fontSize: 24
                    ),
              )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 400.ms)
                  .slideY(begin: 0.5, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
