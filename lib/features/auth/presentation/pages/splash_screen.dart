import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _moveProgress;
  late Animation<double> _size;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50000),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
      ),
    );

    _moveProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.7, curve: Curves.easeInOut),
      ),
    );

    _size = Tween<double>(begin: 159, end: 79).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.addStatusListener(_onAnimationStatus);
    _controller.forward();
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onAnimationStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A99FF),
      body: Stack(
        children: [
          Positioned(
            right: -50,
            top: -32,
            child: Container(
              width: 205,
              height: 205,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: -50,
            bottom: -32,
            child: Transform.rotate(
              angle: math.pi,
              child: Container(
                width: 205,
                height: 205,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final screenHeight = MediaQuery.of(context).size.height;
              final currentWidth = _size.value;
              final currentHeight = currentWidth * (199 / 159);
              final startTop = (screenHeight - 199) / 2;
              final currentTop =
                  startTop + (_moveProgress.value * (107 - startTop));

              return Positioned(
                top: currentTop,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: _fade.value.clamp(0.0, 1.0),
                  child: Center(
                    child: SizedBox(
                      width: currentWidth,
                      height: currentHeight,
                      child: Image.asset("assets/images/prov.png"),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}