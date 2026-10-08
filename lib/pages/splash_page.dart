import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_page.dart';

const Color ecoGreen = Color(0xFF1A6556);
const Color ecoGreenTop = Color(0xFF36786B);

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final widthScale = (size.width / 412).clamp(0.90, 1.10).toDouble();

    final heightScale = (size.height / 915).clamp(0.90, 1.10).toDouble();

    final topAreaHeight = size.height * 0.085;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: ecoGreenTop,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: ecoGreen,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: ecoGreen,
      ),
      child: Scaffold(
        backgroundColor: ecoGreen,
        body: SizedBox.expand(
          child: Stack(
            children: [
              const Positioned.fill(child: ColoredBox(color: ecoGreen)),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: topAreaHeight,
                child: const ColoredBox(color: ecoGreenTop),
              ),
              Align(
                alignment: const Alignment(0, 0.04),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/ecowalk_logo.png',
                      width: size.width * 0.60,
                      fit: BoxFit.contain,
                      color: Colors.white,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                    SizedBox(height: 8 * heightScale),
                    Text(
                      '"Bandingkan, pilih, liburan tanpa ragu !"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.2 * widthScale,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
