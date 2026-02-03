import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:mobile_choise/models/ExamList.dart';
import 'package:mobile_choise/screen/components/dialog_components.dart';
import 'package:mobile_choise/screen/components/exam_card.dart';
import 'package:mobile_choise/screen/dashboard_screen.dart';
import 'package:mobile_choise/screen/exam_test/cepat_teliti_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/cfit_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/disc_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/holland_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/msdt_test_screen.dart';
import 'package:mobile_choise/utils/base_url.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_choise/utils/redirect_screen.dart';

class ExamDashboard extends StatefulWidget {
  const ExamDashboard({super.key});

  @override
  State<ExamDashboard> createState() => _ExamDashboardState();
}

class _ExamDashboardState extends State<ExamDashboard> {
  bool isLoading = false;
  List<ExamList> examList = [];
  List<ExamList> examData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSchedule();
  }

  List<ExamList> getSorted(List<ExamList> allExams) {
    final now = DateTime.now();
    return allExams..sort((a, b) => a.waktuMulai.compareTo(b.waktuMulai));
    // return allExams.where((exam) => exam.waktuMulai.isAfter(now)).toList()
    //   ..sort((a, b) => a.waktuMulai.compareTo(b.waktuMulai));
  }

  void loadSchedule() async {
    setState(() {
      isLoading = true;
      examList = [];
      examData = [];
    });

    try {
      var url = Uri.parse("$baseUrl/exam-list");
      final response = await http.get(url);
      // print(response.body);

      if (mounted) {
        if (response.statusCode == 200) {
          DateTime now = DateTime.now();
          var data = jsonDecode(response.body)['data'] as List;
          // print(DateTime.parse("2026-02-03T14:25:35+07:00").toLocal());
          setState(() {
            examData.addAll(
              data.map((dynamic json) {
                final map = json as Map<String, dynamic>;
                return ExamList(
                  namaUjian: map['nama_ujian'],
                  status: map['status'],
                  waktuMulai: DateTime.parse(
                    map['waktu_mulai'] ?? map['waktu_dimulai'],
                  ).toLocal(),
                  waktuAkhir: DateTime.parse(
                    map['waktu_akhir'] ?? map['waktu_berakhir'],
                  ).toLocal(),
                );
              }).toList(),
            );
            examList = getSorted(examData);
          });

          isLoading = false;
          // print(getSorted(examData));
        } else {
          setState(() {
            isLoading = false;
          });
          // Show error message
          showErrorDialog(
            "Gagal",
            "Gagal login. Periksa kembali username dan password anda",
            context,
          );
        }
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        showErrorDialog(
          "Gagal",
          "Gagal login. Periksa koneksi internet anda dan coba lagi",
          context,
        );
      }
    }
  }

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
        body: RefreshIndicator(
          color: HexColor('FBC02D'),
          onRefresh: () async {
            loadSchedule();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
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
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: HexColor('FBC02D'),
                          ),
                        )
                      : GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemCount: examList.length,
                          itemBuilder: (context, index) {
                            return ExamCard(
                              title: examList[index].namaUjian,
                              status: DateTime.now().isBefore(
                                examList[index].waktuAkhir,
                              ),
                              waktuMulai: examList[index].waktuMulai,
                              waktuAkhir: examList[index].waktuAkhir,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
