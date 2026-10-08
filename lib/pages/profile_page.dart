import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color ecoGreen = Color(0xFF1A6556);
const Color ecoGreenTop = Color(0xFF36786B);
const Color dividerColor = Color(0xFFD3D3D3);

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: ecoGreenTop,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const EcoBottomBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final sx = (constraints.maxWidth / 412)
                .clamp(0.90, 1.08)
                .toDouble();

            final sy = (constraints.maxHeight / 823)
                .clamp(0.92, 1.08)
                .toDouble();

            return Column(
              children: [
                SizedBox(
                  height: 325 * sy,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 72 * sy,
                            color: ecoGreenTop,
                          ),
                          Container(
                            width: double.infinity,
                            height: 116 * sy,
                            color: ecoGreen,
                          ),
                        ],
                      ),
                      Positioned(
                        top: 124 * sy,
                        child: Container(
                          width: 128 * sx,
                          height: 128 * sx,
                          padding: EdgeInsets.all(4 * sx),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profile_ecowalk.jpeg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFE8E8E8),
                                  child: Icon(
                                    Icons.person,
                                    size: 70 * sx,
                                    color: const Color(0xFF555555),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 265 * sy,
                        child: Text(
                          'Syifa Nurazizah',
                          style: TextStyle(
                            fontSize: 21 * sx,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 296 * sy,
                        child: Container(
                          constraints: BoxConstraints(minWidth: 180 * sx),
                          padding: EdgeInsets.symmetric(
                            horizontal: 22 * sx,
                            vertical: 5 * sy,
                          ),
                          decoration: BoxDecoration(
                            color: ecoGreen,
                            borderRadius: BorderRadius.circular(3 * sx),
                          ),
                          child: Text(
                            'syifa@gmail.com',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10 * sx,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16 * sx),
                    children: [
                      menu(
                        icon: Icons.settings_outlined,
                        text: 'Pengaturan',
                        sx: sx,
                        sy: sy,
                      ),
                      divider(),
                      menu(
                        icon: Icons.edit_outlined,
                        text: 'Edit Profil',
                        sx: sx,
                        sy: sy,
                      ),
                      divider(),
                      menu(
                        icon: Icons.lock_outline,
                        text: 'Kebijakan Privasi',
                        sx: sx,
                        sy: sy,
                      ),
                      divider(),
                      menu(
                        icon: Icons.info_outline,
                        text: 'Tentang Kami',
                        sx: sx,
                        sy: sy,
                      ),
                      divider(),
                      menu(
                        icon: Icons.description_outlined,
                        text: 'Ketentuan Layanan',
                        sx: sx,
                        sy: sy,
                      ),
                      divider(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 60 * sy,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 46 * sx,
                                child: Icon(
                                  Icons.logout,
                                  size: 26 * sx,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Keluar',
                                  style: TextStyle(
                                    fontSize: 15.5 * sx,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 30 * sx,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget menu({
    required IconData icon,
    required String text,
    required double sx,
    required double sy,
  }) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: 60 * sy,
        child: Row(
          children: [
            SizedBox(
              width: 46 * sx,
              child: Icon(icon, size: 26 * sx, color: Colors.black),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.5 * sx,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 30 * sx, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(height: 1, thickness: 1, color: dividerColor);
  }
}

class EcoBottomBar extends StatelessWidget {
  const EcoBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sx = (constraints.maxWidth / 412).clamp(0.90, 1.08).toDouble();

        return SizedBox(
          height: 92 * sx,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 58 * sx,
                child: Container(
                  color: ecoGreen,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                            size: 29 * sx,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.verified_user_outlined,
                            color: Colors.white,
                            size: 27 * sx,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.chat_bubble,
                            color: Colors.white,
                            size: 26 * sx,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 16 * sx,
                top: 0,
                child: SizedBox(
                  width: 68 * sx,
                  child: Column(
                    children: [
                      Container(
                        width: 68 * sx,
                        height: 68 * sx,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: ecoGreen, width: 7 * sx),
                        ),
                        child: Icon(
                          Icons.person,
                          color: ecoGreen,
                          size: 31 * sx,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -1 * sx),
                        child: Text(
                          'AKUN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8 * sx,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
