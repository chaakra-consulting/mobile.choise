import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:mobile_choise/screen/dashboard_screen.dart';
import 'package:mobile_choise/screen/exam_test/cepat_teliti_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/cfit_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/disc_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/holland_test_screen.dart';
import 'package:mobile_choise/utils/hex_color.dart';

class ExamDashboard extends StatefulWidget {
  const ExamDashboard({super.key});

  @override
  State<ExamDashboard> createState() => _ExamDashboardState();
}

class _ExamDashboardState extends State<ExamDashboard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          //  Get.off(() => DashboardScreen());
          return;
        }
        Get.off(() => DashboardScreen());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: ListView(
            // physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(top: height / 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Silahkan",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: HexColor('454545'),
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "mengerjakan ujian",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: HexColor('454545'),
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          "yang disediakan",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: HexColor('454545'),
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    // ClockWidget(
                    //   textStyle: GoogleFonts.poppins(
                    //     color: HexColor('828282'),
                    //     fontSize: 15,
                    //   ),
                    // ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20),
                child: MaterialTextField(
                  theme: FilledOrOutlinedTextTheme(
                    radius: 10,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    errorStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    focusedColor: HexColor('FBC02D'),
                    fillColor: Colors.white,
                    enabledColor: HexColor('AEAEAE'),
                    prefixIconColor: HexColor('1C2D57'),
                    hintStyle: GoogleFonts.poppins(
                      color: HexColor('8189B0'),
                      fontSize: 15,
                    ),
                  ),
                  // keyboardType: TextInputType.emailAddress,
                  hint: 'Cari Ujian',
                  // textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(CupertinoIcons.search, size: 19),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                width: width / 5,
                height: height / 8.5,
                decoration: BoxDecoration(
                  color: HexColor('FBC02D'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      Text(
                        "Perhatian",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Harap menggunakan zona waktu indonesia barat sebelum mengerjakan test",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                width: width,
                height: height / 1,
                child: GridView.count(
                  primary: false,
                  padding: EdgeInsets.only(bottom: height / 3),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                      width: width / 5,
                      height: height / 4.3 + 22,
                      decoration: BoxDecoration(
                        color: HexColor('FBC02D'),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            Text(
                              "Ujian CFIT",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 25),
                            Text(
                              "40 menit",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "10:00 - 10:40",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 7),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => CfitTestScreen());
                                },
                                child: Text(
                                  "Kerjakan",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width / 5,
                      height: height / 4.3 + 22,
                      decoration: BoxDecoration(
                        color: HexColor('FBC02D'),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            Text(
                              "Ujian Holland",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 25),
                            Text(
                              "40 menit",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "10:00 - 10:40",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 7),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => HollandTestScreen());
                                },
                                child: Text(
                                  "Kerjakan",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width / 5,
                      height: height / 4.3 + 22,
                      decoration: BoxDecoration(
                        color: HexColor('FBC02D'),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            Text(
                              "Ujian DISC",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 25),
                            Text(
                              "40 menit",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "10:00 - 10:40",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 7),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => DISCTestScreen());
                                },
                                child: Text(
                                  "Kerjakan",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width / 5,
                      height: height / 4.3 + 22,
                      decoration: BoxDecoration(
                        color: HexColor('FBC02D'),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            Container(
                              width: width / 3,
                              height: 30,
                              child: Text(
                                "Ujian Cepat Teliti",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Text(
                              "40 menit",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "10:00 - 10:40",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 7),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => CepatTelitiTestScreen());
                                },
                                child: Text(
                                  "Kerjakan",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width / 5,
                      height: height / 4.3 + 22,
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor('FBC02D'), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            Text(
                              "Ujian Holland",
                              style: GoogleFonts.poppins(
                                color: HexColor("A6A6A6"),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 25),
                            Text(
                              "40 menit",
                              style: GoogleFonts.poppins(
                                color: HexColor("A6A6A6"),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "10:00 - 10:40",
                              style: GoogleFonts.poppins(
                                color: HexColor("A6A6A6"),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 7),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Selesai",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: HexColor("A6A6A6"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
