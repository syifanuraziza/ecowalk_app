import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'register_page.dart';

const Color ecoGreen = Color(0xFF1A6556);
const Color ecoBlue = Color(0xFF35C5E5);
const Color fieldFill = Color(0xFFF8F8F8);
const Color fieldBorder = Color(0xFFC2C2C2);
const Color iconGrey = Color(0xFF818181);
const Color textDark = Color(0xFF222222);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordTersembunyi = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration({
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: fieldFill,
      prefixIcon: Icon(icon, size: 21, color: iconGrey),
      prefixIconConstraints: const BoxConstraints(minWidth: 46, minHeight: 48),
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(minWidth: 46, minHeight: 48),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: fieldBorder, width: 1.15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ecoGreen, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final scale = (width / 412).clamp(0.90, 1.05).toDouble();

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(horizontal: 15 * scale),
                child: Column(
                  children: [
                    SizedBox(height: 84 * scale),

                    Text(
                      'MASUK',
                      style: TextStyle(
                        color: ecoGreen,
                        fontSize: 20 * scale,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),

                    SizedBox(height: 9 * scale),

                    Image.asset(
                      'assets/images/ecowalk_logo.png',
                      width: width * 0.60,
                      height: 65 * scale,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 57 * scale),

                    label('Nama Pengguna', scale),

                    SizedBox(height: 8 * scale),

                    SizedBox(
                      height: 49 * scale,
                      child: TextField(
                        controller: usernameController,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: 12 * scale, color: textDark),
                        decoration: inputDecoration(icon: Icons.person),
                      ),
                    ),

                    SizedBox(height: 20 * scale),

                    label('Kata Sandi', scale),

                    SizedBox(height: 8 * scale),

                    SizedBox(
                      height: 49 * scale,
                      child: TextField(
                        controller: passwordController,
                        obscureText: passwordTersembunyi,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => login(),
                        style: TextStyle(fontSize: 12 * scale, color: textDark),
                        decoration: inputDecoration(
                          icon: Icons.lock,
                          suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                passwordTersembunyi = !passwordTersembunyi;
                              });
                            },
                            icon: Icon(
                              passwordTersembunyi
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: iconGrey,
                              size: 20 * scale,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 53 * scale),

                    SizedBox(
                      width: double.infinity,
                      height: 47 * scale,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ecoGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4 * scale),
                          ),
                        ),
                        onPressed: login,
                        child: Text(
                          'MASUK',
                          style: TextStyle(
                            fontSize: 11 * scale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15 * scale),

                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8 * scale,
                          vertical: 4 * scale,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Lupa Kata Sandi?',
                        style: TextStyle(
                          color: ecoBlue,
                          fontSize: 10.5 * scale,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                    SizedBox(height: 32 * scale),

                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFDFDFDF),
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25 * scale),
                          child: Text(
                            'Atau',
                            style: TextStyle(
                              color: const Color(0xFF555555),
                              fontSize: 9 * scale,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFDFDFDF),
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 47 * scale),

                    Material(
                      color: const Color(0xFFFAFAFA),
                      elevation: 3,
                      shadowColor: Colors.black26,
                      borderRadius: BorderRadius.circular(4 * scale),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4 * scale),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Login Google belum dihubungkan ke Firebase.',
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 48 * scale,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google_logo.png',
                                width: 22 * scale,
                                height: 22 * scale,
                              ),
                              SizedBox(width: 13 * scale),
                              Text(
                                'Lanjutkan dengan Google',
                                style: TextStyle(
                                  fontSize: 11 * scale,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 43 * scale),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tidak punya akun? ',
                          style: TextStyle(
                            fontSize: 10 * scale,
                            color: const Color(0xFF555555),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Daftar disini',
                            style: TextStyle(
                              fontSize: 10 * scale,
                              color: ecoBlue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 28 * scale),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget label(String text, double scale) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12 * scale,
          color: textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void login() {
    const usernameBenar = 'syifa';
    const passwordBenar = 'syifa123';

    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama pengguna dan kata sandi harus diisi.'),
        ),
      );
      return;
    }

    if (username == usernameBenar && password == passwordBenar) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama pengguna atau kata sandi salah.')),
      );
    }
  }
}
