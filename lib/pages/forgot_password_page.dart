import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_page.dart';

const Color ecoGreen = Color(0xFF1A6556);
const Color ecoBlue = Color(0xFF02B8E0);
const Color headerMint = Color(0xFFDAE6E4);
const Color fieldFill = Color(0xFFF9F9F9);
const Color fieldBorder = Color(0xFFD3D3D3);
const Color iconGrey = Color(0xFF707070);
const Color lineGrey = Color(0xFF8D8D8D);

enum ForgotStep { input, otp, reset }

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ForgotStep step = ForgotStep.input;

  bool pakaiEmail = true;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final tujuanController = TextEditingController();
  final passwordBaruController = TextEditingController();
  final konfirmasiController = TextEditingController();

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    tujuanController.dispose();
    passwordBaruController.dispose();
    konfirmasiController.dispose();

    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final node in otpFocusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  String formatNomorHp(String nomor) {
    String value = nomor.trim().replaceAll(' ', '').replaceAll('-', '');

    if (value.startsWith('+62')) {
      return value;
    }

    if (value.startsWith('62')) {
      return '+$value';
    }

    if (value.startsWith('0')) {
      return '+62${value.substring(1)}';
    }

    return '+62$value';
  }

  String tujuanVerifikasi() {
    if (pakaiEmail) {
      return tujuanController.text.trim();
    }

    return formatNomorHp(tujuanController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: headerMint,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final sx = (constraints.maxWidth / 412)
                .clamp(0.90, 1.08)
                .toDouble();

            final sy = (constraints.maxHeight / 915)
                .clamp(0.90, 1.08)
                .toDouble();

            return Stack(
              children: [
                ClipPath(
                  clipper: ForgotHeaderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 282 * sy,
                    color: headerMint,
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                      18 * sx,
                      105 * sy,
                      18 * sx,
                      35 * sy,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/ecowalk_logo.png',
                                width: constraints.maxWidth * 0.68,
                                height: 62 * sy,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 3 * sy),
                              Text(
                                'LUPA KATA SANDI',
                                style: TextStyle(
                                  color: ecoGreen,
                                  fontSize: 19 * sx,
                                  fontWeight: FontWeight.w800,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 82 * sy),

                        if (step == ForgotStep.input) halamanInput(sx, sy),

                        if (step == ForgotStep.otp) halamanOtp(sx, sy),

                        if (step == ForgotStep.reset) halamanReset(sx, sy),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget halamanInput(double sx, double sy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.notifications_none_outlined,
              size: 28 * sx,
              color: Colors.black,
            ),
            SizedBox(width: 12 * sx),
            Expanded(
              child: Text(
                pakaiEmail
                    ? 'Periksa dan masukan alamat Email untuk mendapatkan\nkode verifikasi'
                    : 'Periksa dan masukan Nomor Hp untuk mendapatkan\nkode verifikasi',
                style: TextStyle(
                  fontSize: 10.5 * sx,
                  height: 1.35,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 52 * sy),

        Text(
          pakaiEmail ? 'Alamat Email' : 'Nomor Hp',
          style: TextStyle(fontSize: 10.5 * sx, color: const Color(0xFF6F6F6F)),
        ),

        SizedBox(height: 5 * sy),

        SizedBox(
          height: 58 * sy,
          child: TextField(
            controller: tujuanController,
            keyboardType: pakaiEmail
                ? TextInputType.emailAddress
                : TextInputType.phone,
            inputFormatters: pakaiEmail
                ? null
                : [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))],
            style: TextStyle(fontSize: 12 * sx, color: Colors.black),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 15 * sy),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: lineGrey, width: 1.1),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: ecoGreen, width: 1.5),
              ),
            ),
          ),
        ),

        SizedBox(height: 27 * sy),

        GestureDetector(
          onTap: () {
            setState(() {
              pakaiEmail = !pakaiEmail;
              tujuanController.clear();

              for (final controller in otpControllers) {
                controller.clear();
              }
            });
          },
          child: Text(
            pakaiEmail ? 'Gunakan Nomor Hp' : 'Gunakan Email',
            style: TextStyle(
              color: ecoBlue,
              fontSize: 10.5 * sx,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        SizedBox(height: 39 * sy),

        tombolHijau(
          text: 'KIRIM',
          sx: sx,
          sy: sy,
          onPressed: () {
            final tujuan = tujuanController.text.trim();

            if (tujuan.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    pakaiEmail
                        ? 'Alamat Email harus diisi.'
                        : 'Nomor Hp harus diisi.',
                  ),
                ),
              );

              return;
            }

            setState(() {
              step = ForgotStep.otp;
            });
          },
        ),
      ],
    );
  }

  Widget halamanOtp(double sx, double sy) {
    final horizontalPadding = 18 * sx;
    final gap = 14 * sx;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final otpSize = (screenWidth - (horizontalPadding * 2) - (gap * 3)) / 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check, size: 22 * sx, color: Colors.black),
            SizedBox(width: 12 * sx),
            Text(
              'VERIFIKASI',
              style: TextStyle(
                fontSize: 14 * sx,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),

        SizedBox(height: 18 * sy),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              pakaiEmail
                  ? Icons.mark_email_read_outlined
                  : Icons.phonelink_lock_outlined,
              size: 30 * sx,
              color: Colors.black,
            ),

            SizedBox(width: 11 * sx),

            Expanded(
              child: Text(
                'Periksa dan ketik kode verifikasi yang telah dikirimkan\n'
                'ke ${tujuanVerifikasi()}',
                style: TextStyle(
                  fontSize: 10.5 * sx,
                  height: 1.35,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 42 * sy),

        Row(
          children: List.generate(4, (index) {
            return Padding(
              padding: EdgeInsets.only(right: index == 3 ? 0 : gap),
              child: AnimatedBuilder(
                animation: otpFocusNodes[index],
                builder: (context, child) {
                  return Container(
                    width: otpSize,
                    height: otpSize,
                    decoration: BoxDecoration(
                      color: fieldFill,
                      borderRadius: BorderRadius.circular(8 * sx),
                      border: Border.all(
                        color: otpFocusNodes[index].hasFocus
                            ? ecoGreen
                            : fieldBorder,
                        width: otpFocusNodes[index].hasFocus ? 1.5 : 1,
                      ),
                    ),
                    child: TextField(
                      controller: otpControllers[index],
                      focusNode: otpFocusNodes[index],
                      keyboardType: TextInputType.number,
                      textInputAction: index == 3
                          ? TextInputAction.done
                          : TextInputAction.next,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontSize: 24 * sx,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          otpFocusNodes[index + 1].requestFocus();
                        }

                        if (value.isEmpty && index > 0) {
                          otpFocusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                },
              ),
            );
          }),
        ),

        SizedBox(height: 35 * sy),

        GestureDetector(
          onTap: () {
            setState(() {
              pakaiEmail = !pakaiEmail;
              tujuanController.clear();

              for (final controller in otpControllers) {
                controller.clear();
              }

              step = ForgotStep.input;
            });
          },
          child: Text(
            pakaiEmail
                ? 'Verifikasi menggunakan No. Hp'
                : 'Verifikasi menggunakan Email',
            style: TextStyle(
              color: ecoBlue,
              fontSize: 10.5 * sx,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        SizedBox(height: 38 * sy),

        tombolHijau(
          text: 'KIRIM',
          sx: sx,
          sy: sy,
          onPressed: () {
            final kode = otpControllers
                .map((controller) => controller.text)
                .join();

            if (kode.length != 4) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Masukkan 4 digit kode verifikasi.'),
                ),
              );

              return;
            }

            FocusScope.of(context).unfocus();

            setState(() {
              step = ForgotStep.reset;
            });
          },
        ),

        SizedBox(height: 18 * sy),

        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.symmetric(
                horizontal: 12 * sx,
                vertical: 7 * sy,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              for (final controller in otpControllers) {
                controller.clear();
              }

              otpFocusNodes.first.requestFocus();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Kode verifikasi berhasil dikirim ulang.'),
                ),
              );
            },
            child: Text(
              'Kirim Ulang Kode',
              style: TextStyle(color: ecoGreen, fontSize: 10.5 * sx),
            ),
          ),
        ),
      ],
    );
  }

  Widget halamanReset(double sx, double sy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Masukan Kata Sandi Baru',
          style: TextStyle(
            fontSize: 11.5 * sx,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 36 * sy),

        TextField(
          controller: passwordBaruController,
          obscureText: hidePassword,
          style: TextStyle(fontSize: 11.5 * sx, color: Colors.black),
          decoration: passwordDecoration(
            hint: 'Kata Sandi Baru',
            sx: sx,
            hide: hidePassword,
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
          ),
        ),

        SizedBox(height: 24 * sy),

        TextField(
          controller: konfirmasiController,
          obscureText: hideConfirmPassword,
          style: TextStyle(fontSize: 11.5 * sx, color: Colors.black),
          decoration: passwordDecoration(
            hint: 'Konfirmasi Kata Sandi',
            sx: sx,
            hide: hideConfirmPassword,
            onPressed: () {
              setState(() {
                hideConfirmPassword = !hideConfirmPassword;
              });
            },
          ),
        ),

        SizedBox(height: 55 * sy),

        tombolHijau(
          text: 'UBAH KATA SANDI',
          sx: sx,
          sy: sy,
          onPressed: () {
            final passwordBaru = passwordBaruController.text.trim();

            final konfirmasi = konfirmasiController.text.trim();

            if (passwordBaru.isEmpty || konfirmasi.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Kata sandi baru dan konfirmasi harus diisi.'),
                ),
              );

              return;
            }

            if (passwordBaru != konfirmasi) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Konfirmasi kata sandi tidak sama.'),
                ),
              );

              return;
            }

            if (passwordBaru.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kata sandi minimal 6 karakter.')),
              );

              return;
            }

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          },
        ),
      ],
    );
  }

  InputDecoration passwordDecoration({
    required String hint,
    required double sx,
    required bool hide,
    required VoidCallback onPressed,
  }) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 11 * sx,
        color: const Color(0xFF777777),
        fontStyle: FontStyle.italic,
      ),
      prefixIcon: Icon(Icons.lock, color: iconGrey, size: 20 * sx),
      prefixIconConstraints: BoxConstraints(minWidth: 42 * sx),
      suffixIcon: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          hide ? Icons.visibility_off : Icons.visibility,
          color: iconGrey,
          size: 20 * sx,
        ),
      ),
      suffixIconConstraints: BoxConstraints(minWidth: 42 * sx),
      contentPadding: EdgeInsets.symmetric(vertical: 14 * sx),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: lineGrey, width: 1.1),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: ecoGreen, width: 1.5),
      ),
    );
  }

  Widget tombolHijau({
    required String text,
    required double sx,
    required double sy,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 49 * sy,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ecoGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4 * sx),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 11 * sx, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class ForgotHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height * 0.43)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant ForgotHeaderClipper oldClipper) {
    return false;
  }
}
