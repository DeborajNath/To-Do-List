import 'package:flutter/material.dart';
import 'package:task_management/Data/Constants/colors.dart';
import 'package:task_management/Data/Constants/routes.dart';
import 'package:task_management/Screens/loginModule/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Future.microtask(() {
        RoutingService.gotoWithoutBack(
          context,
          const RegistrationScreen(),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "appscrip",
          style: TextStyle(
            color: blue,
            fontSize: 80,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
