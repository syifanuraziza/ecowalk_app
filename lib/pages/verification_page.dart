import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color ecoGreen = Color(0xFF1A6556);
const Color ecoBlue = Color(0xFF02B8E0);
const Color headerMint = Color(0xFFDAE6E4);
const Color fieldFill = Color(0xFFF9F9F9);
const Color fieldBorder = Color(0xFFD3D3D3);

class VerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String emailAddress;

  const VerificationPage({
    super.key,
    required this.phoneNumber,
    required this.emailAddress,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool pakaiNomorHp = true;

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final node in focusNodes) {
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

            final horizontalPadding = 18 * sx;
            final gap = 14 * sx;

            final otpSize =
                (constraints.maxWidth - (horizontalPadding * 2) - (gap * 3)) /
                4;

            return Stack(
              children: [
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 273 * sy,
                    color: headerMint,
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      105 * sy,
                      horizontalPadding,
                      30 * sy,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/ecowalk_logo.png',
                            width: constraints.maxWidth * 0.68,
                            height: 68 * sy,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: 63 * sy),

                        Row(
                          children: [
                            Icon(
                              Icons.check,
                              size: 22 * sx,
                              color: Colors.black,
                            ),
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
                              pakaiNomorHp
                                  ? Icons.phonelink_lock_outlined
                                  : Icons.mark_email_read_outlined,
                              size: 30 * sx,
                              color: Colors.black,
                            ),

                            SizedBox(width: 11 * sx),

                            Expanded(
                              child: Text(
                                pakaiNomorHp
                                    ? 'Periksa dan ketik kode verifikasi yang telah dikirimkan\nke ${formatNomorHp(widget.phoneNumber)}'
                                    : 'Periksa dan ketik kode verifikasi yang telah dikirimkan\nke ${widget.emailAddress}',
                                style: TextStyle(
                                  fontSize: 10.5 * sx,
                                  height: 1.35,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 42 * sy),

                        Row(
                          children: List.generate(4, (index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index == 3 ? 0 : gap,
                              ),
                              child: AnimatedBuilder(
                                animation: focusNodes[index],
                                builder: (context, child) {
                                  return Container(
                                    width: otpSize,
                                    height: otpSize,
                                    decoration: BoxDecoration(
                                      color: fieldFill,
                                      borderRadius: BorderRadius.circular(
                                        8 * sx,
                                      ),
                                      border: Border.all(
                                        color: focusNodes[index].hasFocus
                                            ? ecoGreen
                                            : fieldBorder,
                                        width: focusNodes[index].hasFocus
                                            ? 1.5
                                            : 1,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: otpControllers[index],
                                      focusNode: focusNodes[index],
                                      keyboardType: TextInputType.number,
                                      textInputAction: index == 3
                                          ? TextInputAction.done
                                          : TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      textAlignVertical:
                                          TextAlignVertical.center,

                                      expands: true,
                                      maxLines: null,
                                      minLines: null,
                                      maxLength: 1,

                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],

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
                                          focusNodes[index + 1].requestFocus();
                                        }

                                        if (value.isEmpty && index > 0) {
                                          focusNodes[index - 1].requestFocus();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        ),

                        SizedBox(height: 34 * sy),

                        GestureDetector(
                          onTap: gantiMetode,
                          child: Text(
                            pakaiNomorHp
                                ? 'Verifikasi menggunakan Email'
                                : 'Verifikasi menggunakan No. Hp',
                            style: TextStyle(
                              color: ecoBlue,
                              fontSize: 10.5 * sx,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(height: 38 * sy),

                        SizedBox(
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
                            onPressed: verifikasi,
                            child: Text(
                              'KIRIM',
                              style: TextStyle(
                                fontSize: 11 * sx,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 17 * sy),

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
                            onPressed: kirimUlang,
                            child: Text(
                              'Kirim Ulang Kode',
                              style: TextStyle(
                                color: ecoGreen,
                                fontSize: 10.5 * sx,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40 * sy),
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

  void gantiMetode() {
    setState(() {
      pakaiNomorHp = !pakaiNomorHp;

      for (final controller in otpControllers) {
        controller.clear();
      }
    });

    focusNodes.first.requestFocus();
  }

  void kirimUlang() {
    for (final controller in otpControllers) {
      controller.clear();
    }

    focusNodes.first.requestFocus();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Kode dikirim ulang.')));
  }

  void verifikasi() {
    final kode = otpControllers.map((controller) => controller.text).join();

    if (kode.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan 4 digit kode verifikasi.')),
      );

      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Verifikasi berhasil.')));

    Navigator.popUntil(context, (route) => route.isFirst);
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height * 0.44)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant HeaderClipper oldClipper) {
    return false;
  }
}
