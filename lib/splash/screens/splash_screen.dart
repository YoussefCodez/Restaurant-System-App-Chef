import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_chef/auth/presentation/screens/log_in_screen.dart';
import 'package:food_chef/home/presentation/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png", width: 150.w)
            .animate(
              onComplete: (_) {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LogInScreen()),
                  );
                }
              },
            )
            .fadeIn(
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 1500),
            ),
      ),
    );
  }
}
