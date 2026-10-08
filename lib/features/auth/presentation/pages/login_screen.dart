import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'beranda_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeField1;
  late Animation<double> _fadeField2;
  late Animation<double> _fadeFigure;

  late AnimationController _loadingController;
  late Animation<double> _scaleAnimation;

  bool _isGoItPressed = false;
  bool _isAdminPressed = false;
  bool _isLoading = false;
  bool _isUnlockedVariant = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 15000),
    );

    _fadeField1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _fadeField2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.75, curve: Curves.easeIn),
      ),
    );

    _fadeFigure = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _loadingController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  void _onGoItPressed() async {
    setState(() {
      _isLoading = true;
      _isUnlockedVariant = false;
    });

    _loadingController.forward(from: 0.0);

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _isUnlockedVariant = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;

    await _loadingController.reverse();
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BerandaScreen()),
    );
  }

  void _onAdminPressed() {
    debugPrint("Teks ADMIN ditekan");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A99FF),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _isLoading ? 0.4 : 1.0,
              duration: const Duration(milliseconds: 2500),
              child: Stack(
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
                  Positioned(
                    top: 107,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        width: 79,
                        height: 99,
                        child: Image.asset("assets/images/prov.png"),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 59,
                    top: 274,
                    child: const Text(
                      "NIS \\ Username",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 46,
                    right: 46,
                    top: 296,
                    child: FadeTransition(
                      opacity: _fadeField1,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: TextField(
                          decoration: _inputDecoration(
                            hint: "Masukkan NIS atau username",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 59,
                    top: 426,
                    child: const Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 46,
                    right: 46,
                    top: 449,
                    child: FadeTransition(
                      opacity: _fadeField2,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: TextField(
                          obscureText: true,
                          decoration:
                              _inputDecoration(hint: "Masukkan password"),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 56,
                    top: 507,
                    child: const Text(
                      "Lupa Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 567,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Login sebagai ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          GestureDetector(
                            onTapDown: (_) =>
                                setState(() => _isAdminPressed = true),
                            onTapUp: (_) {
                              setState(() => _isAdminPressed = false);
                              _onAdminPressed();
                            },
                            onTapCancel: () =>
                                setState(() => _isAdminPressed = false),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 1000),
                              style: TextStyle(
                                color: _isAdminPressed
                                    ? const Color(0xFF1B7A00)
                                    : const Color(0xFF32D800),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              child: const Text("ADMIN"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 618,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTapDown: (_) =>
                            setState(() => _isGoItPressed = true),
                        onTapUp: (_) {
                          setState(() => _isGoItPressed = false);
                          _onGoItPressed();
                        },
                        onTapCancel: () =>
                            setState(() => _isGoItPressed = false),
                        child: AnimatedScale(
                          scale: _isGoItPressed ? 0.94 : 1.0,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOut,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 3000),
                            width: 173,
                            height: 30,
                            decoration: BoxDecoration(
                              color: _isGoItPressed
                                  ? const Color(0xFFE8E8E8)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: _isGoItPressed
                                  ? []
                                  : [
                                      BoxShadow(
                                        color:
                                            Colors.black.withOpacity(0.08),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                            ),
                            child: const Center(
                              child: Text(
                                "Go It",
                                style: TextStyle(
                                  color: Color(0xFF32D800),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -20,
                    bottom: -40,
                    child: FadeTransition(
                      opacity: _fadeFigure,
                      child: SizedBox(
                        width: 220,
                        child: Image.asset(
                          "assets/images/figur.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.15),
                child: Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        color: const Color(0xFF123B5D),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 3000),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: SvgPicture.asset(
                            _isUnlockedVariant
                                ? 'assets/svg/lock2.svg'
                                : 'assets/svg/lock1.svg',
                            key: ValueKey<bool>(_isUnlockedVariant),
                            width: 130,
                            height: 130,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}