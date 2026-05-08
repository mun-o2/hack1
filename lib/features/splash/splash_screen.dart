import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack1/app/user_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUser();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(const Duration(milliseconds: 1800), () {
        if (mounted) {
          context.go('/onboarding');
        }
      });
    });
  }

  Future<void> _checkUser() async {
    final userId = await UserService.getUserId();

    if (!mounted) return;

    if (userId == null) {
      context.go('/role');
      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (!mounted) return;

    if (!userDoc.exists) {
      context.go('/role');
      return;
    }

    final role = userDoc.data()?['role'];

    if (role == 'senior') {
      context.go('/senior');
    } else {
      context.go('/student');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF2EA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Image.asset(
              'assets/images/Splash 1.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
