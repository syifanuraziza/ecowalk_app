import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'verification_page.dart';

const Color ecoGreen = Color(0xFF1A6556);
const Color ecoBlue = Color(0xFF35C5E5);
const Color fieldFill = Color(0xFFF8F8F8);
const Color fieldBorder = Color(0xFFC9C9C9);
const Color iconGrey = Color(0xFF707070);
const Color textGrey = Color(0xFF707070);

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool agree = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration fieldDecoration({
    required String hint,
    required IconData icon,
    required double sx,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      hintStyle: TextStyle(
        color: const Color(0xFF7E7E7E),
        fontSize: 11 * sx,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: fieldFill,
      prefixIcon: Icon(icon, size: 21 * sx, color: iconGrey),
      prefixIconConstraints: BoxConstraints(minWidth: 48 * sx),
      suffixIcon: suffixIcon,
      suffixIconConstraints: BoxConstraints(minWidth: 46 * sx),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12 * sx,
        vertical: 14 * sx,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9 * sx),
        borderSide: const BorderSide(color: fieldBorder, width: 1.15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9 * sx),
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
              final sx = (constraints.maxWidth / 412)
                  .clamp(0.88, 1.08)
                  .toDouble();

              final sy = (constraints.maxHeight / 843)
                  .clamp(0.88, 1.08)
                  .toDouble();

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(horizontal: 17 * sx),
                child: Column(
                  children: [
                    SizedBox(height: 82 * sy),

                    Text(
                      'BUAT AKUN',
                      style: TextStyle(
                        color: ecoGreen,
                        fontSize: 20 * sx,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),

                    SizedBox(height: 7 * sy),

                    Image.asset(
                      'assets/images/ecowalk_logo.png',
                      width: constraints.maxWidth * 0.59,
                      height: 48 * sy,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 60 * sy),

                    field(
                      controller: usernameController,
                      hint: 'Nama Pengguna',
                      icon: Icons.person,
                      sx: sx,
                      sy: sy,
                      action: TextInputAction.next,
                    ),

                    SizedBox(height: 24 * sy),

                    field(
                      controller: emailController,
                      hint: 'Email',
                      icon: Icons.email,
                      sx: sx,
                      sy: sy,
                      action: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 24 * sy),

                    field(
                      controller: phoneController,
                      hint: 'Nomor Hp',
                      icon: Icons.phone,
                      sx: sx,
                      sy: sy,
                      action: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 24 * sy),

                    SizedBox(
                      height: 49 * sy,
                      child: TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          fontSize: 11.5 * sx,
                          color: const Color(0xFF333333),
                        ),
                        decoration: fieldDecoration(
                          hint: 'Kata Sandi',
                          icon: Icons.lock,
                          sx: sx,
                          suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: iconGrey,
                              size: 20 * sx,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24 * sy),

                    SizedBox(
                      height: 49 * sy,
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: hideConfirmPassword,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                          fontSize: 11.5 * sx,
                          color: const Color(0xFF333333),
                        ),
                        decoration: fieldDecoration(
                          hint: 'Konfirmasi Kata Sandi',
                          icon: Icons.lock,
                          sx: sx,
                          suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                hideConfirmPassword = !hideConfirmPassword;
                              });
                            },
                            icon: Icon(
                              hideConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: iconGrey,
                              size: 20 * sx,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 36 * sy),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24 * sx,
                          height: 24 * sx,
                          child: Checkbox(
                            value: agree,
                            activeColor: ecoGreen,
                            checkColor: Colors.white,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            side: const BorderSide(
                              color: Color(0xFF707070),
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            onChanged: (value) {
                              setState(() {
                                agree = value ?? false;
                              });
                            },
                          ),
                        ),

                        SizedBox(width: 8 * sx),

                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 1 * sy),
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 9.3 * sx,
                                  height: 1.32,
                                  color: textGrey,
                                ),
                                children: const [
                                  TextSpan(
                                    text: 'Saya telah membaca dan menyetujui ',
                                  ),
                                  TextSpan(
                                    text: 'persyaratan dan\nprivasi pengguna',
                                    style: TextStyle(color: ecoBlue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 33 * sy),

                    SizedBox(
                      width: double.infinity,
                      height: 49 * sy,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ecoGreen,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4 * sx),
                          ),
                        ),
                        onPressed: buatAkun,
                        child: Text(
                          'BUAT AKUN',
                          style: TextStyle(
                            fontSize: 11 * sx,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 31 * sy),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun? ',
                          style: TextStyle(
                            fontSize: 10 * sx,
                            color: const Color(0xFF555555),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Masuk',
                            style: TextStyle(fontSize: 10 * sx, color: ecoBlue),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 65 * sy),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required double sx,
    required double sy,
    required TextInputAction action,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      height: 49 * sy,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: action,
        style: TextStyle(fontSize: 11.5 * sx, color: const Color(0xFF333333)),
        decoration: fieldDecoration(hint: hint, icon: icon, sx: sx),
      ),
    );
  }

  void buatAkun() {
    if (usernameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua data harus diisi.')));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi kata sandi tidak sama.')),
      );
      return;
    }

    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan setujui persyaratan terlebih dahulu.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationPage(
          phoneNumber: phoneController.text.trim(),
          emailAddress: emailController.text.trim(),
        ),
      ),
    );
  }
}
