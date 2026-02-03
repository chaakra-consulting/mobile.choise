import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:mobile_choise/screen/auth/login_screen.dart';
import 'package:mobile_choise/screen/exam_dashboard.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Muhammad",
                      style: GoogleFonts.poppins(
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
                style: GoogleFonts.poppins(
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
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: HexColor('454545'),
                  ),
                ),
                Text(
                  "Kerjakan Sesuai Dengan Waktu Yang Telah Ditentukan!",
                  style: GoogleFonts.poppins(
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
                        onPressed: () {
                          Get.offAll(() => LoginScreen());
                        },
                        child: Text(
                          "Logout",
                          style: GoogleFonts.poppins(
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
