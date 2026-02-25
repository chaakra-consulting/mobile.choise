import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:mobile_choise/screen/auth/login_screen.dart';
import 'package:mobile_choise/screen/exam_dashboard.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('nama_pelamar');
    setState(() {
      userName = name!.split(' ')[0];
    });
  }

  void deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> _showExitConfirmation(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFD69E2E),
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Peringatan',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Apakah Anda yakin ingin keluar?',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 14, height: 1.4),
          ),
          actionsOverflowButtonSpacing: 5,
          actionsOverflowDirection: VerticalDirection.down,
          actions: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: HexColor('FBC02D')),
                        ),
                      ),
                      child: Text(
                        'Batal',
                        style: textTheme.labelMedium?.copyWith(
                          fontFamily: 'Poppins',
                          color: HexColor('FBC02D'),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        deleteUserData();
                        Get.offAll(() => LoginScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD69E2E),
                        foregroundColor: HexColor("FFFFFF"),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Keluar',
                        style: textTheme.labelMedium?.copyWith(
                          fontFamily: 'Poppins',
                          color: HexColor("FFFFFF"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: HexColor('FBC02D'),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              width: width,
              height: height / 4,
              child: Padding(
                padding: EdgeInsets.only(top: width / 4, left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      userName,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Ujian Saya",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                  color: HexColor('454545'),
                ),
              ),
            ),
            SizedBox(height: height / 7.5),
            Column(
              spacing: 4,
              children: [
                Text(
                  "Tes Tulis dan Psikotes",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: HexColor('454545'),
                  ),
                ),
                Text(
                  "Kerjakan Sesuai Dengan Waktu Yang Telah Ditentukan!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: HexColor('454545'),
                  ),
                ),
                Container(
                  width: 100,
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: HexColor('FBC02D'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => ExamDashboard());
                    },
                    child: Text(
                      "Kerjakan",
                      style: TextStyle(color: Color(0xffffffff)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height / 3.1,
                    bottom: 5,
                    left: 17,
                    right: 17,
                  ),
                  child: Shimmer(
                    duration: const Duration(seconds: 5),
                    color: Colors.purpleAccent,
                    colorOpacity: 0, //Default value
                    enabled: true, //Default value
                    direction:
                        const ShimmerDirection.fromLeftToRight(), //Default Value
                    child: Container(
                      width: width,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: HexColor('FBC02D'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          _showExitConfirmation(context);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
