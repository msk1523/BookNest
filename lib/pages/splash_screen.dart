import 'package:boookie/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.fadeIn(
        backgroundColor: const Color(0xFF2E251A),
        childWidget: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              Image.asset(
                'images/bookworm_logo.png',
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 20),
              CircularProgressIndicator(
                color: Colors.white,
              ),
              const SizedBox(height: 100),
              const Text(
                'Made by BookWorms',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Version 1.0 [beta]',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        nextScreen: const LoginScreen(),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
