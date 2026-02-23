import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/models/CFITAnswer.dart';
import 'package:mobile_choise/models/CFITQuestion.dart';
import 'package:mobile_choise/screen/components/carousel_card.dart';
import 'package:mobile_choise/screen/components/complete_test.dart';
import 'package:mobile_choise/screen/components/dialog_components.dart';
import 'package:mobile_choise/screen/exam_dashboard.dart';
import 'package:mobile_choise/screen/exam_test/cfit_sub2_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/cfit_sub4_test_screen.dart';
import 'package:mobile_choise/utils/base_url.dart';
import 'package:mobile_choise/utils/cfit_instructions.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CfitSub3TestScreen extends StatefulWidget {
  const CfitSub3TestScreen({super.key, required this.targetSubtes});
  final int targetSubtes;

  @override
  State<CfitSub3TestScreen> createState() => _CfitSub3TestScreenState();
}

class _CfitSub3TestScreenState extends State<CfitSub3TestScreen> {
  final List<String> items = List<String>.generate(20, (i) => i.toString());
  int subtes = 1;
  int nomorSoal = 1;
  bool isLoading = false;
  List<CfitQuestion> questions = <CfitQuestion>[];
  List<CfitAnswer> answer = <CfitAnswer>[];
  String keyAnswer = "";
  String keyAnswer2 = "";
  List alphabeticOrder = List<String>.from(["a", "b", "c", "d", "e", "f"]);
  List images = [];
  // String selectedAlpha = "";
  String selectedAnswer = "";
  int selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      subtes = widget.targetSubtes;
    });
    loadAnswer();
    loadQuestion();
    loadImages();
    redirectToNextTest();
  }

  redirectToNextTest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (DateTime.now().isAfter(
      DateTime.parse(prefs.getString("end_uji_sub3")!),
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Waktu Habis, melanjutkan ke subtes berikutnya",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF38A169),
          duration: Duration(seconds: 2),
        ),
      );
      Get.to(() => CfitSub4TestScreen(targetSubtes: 4));
    }
  }

  void setAnswer() async {
    try {
      if (answer
          .where((element) => element.nomorSoal == nomorSoal)
          .where((element) => element.subtes == subtes.toString())
          .isNotEmpty) {
        var userAnswer =
            answer
                .where((element) => element.nomorSoal == nomorSoal)
                .where((element) => element.subtes == subtes.toString())
                .first
                .jawaban ??
            "";
        var alphabetIndex = alphabeticOrder.indexWhere(
          (element) =>
              element.toString().trim().toUpperCase() ==
              userAnswer.trim().toUpperCase(),
        );
        setState(() {
          selectedIndex = alphabetIndex;
          selectedAnswer = alphabetIndex.toString();
        });
      } else {
        setState(() {
          selectedIndex = -1;
          selectedAnswer = "";
        });
      }
    } catch (e) {
      showErrorDialog("Error", "Elemen tidak ditemukan", context);
    }
  }

  void loadImages() {
    setState(() {
      images = [];
    });

    setState(() {
      if (questions.isNotEmpty) {
        images.addAll([
          questions[nomorSoal - 1].opsiA,
          questions[nomorSoal - 1].opsiB,
          questions[nomorSoal - 1].opsiC,
          questions[nomorSoal - 1].opsiD,
          questions[nomorSoal - 1].opsiE,
          questions[nomorSoal - 1].opsiF,
        ]);
      }
    });
  }

  void loadAnswer() async {
    setState(() {
      answer = [];
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(
        "$baseUrl/cfit-questions/by-exam-number/$subtes?id_pelamar=${prefs.getString('id_pelamar')}&id_lowongan=$idLowongan",
      );
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
      );
      // print(response.body);

      if (mounted) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['data'] as List;
          setState(() {
            answer.addAll(
              data.map((dynamic json) {
                final map = json as Map<String, dynamic>;
                return CfitAnswer(
                  idJawabanCfit: map['id_jawaban_cfit'],
                  idPelamar: map['id_pelamar'],
                  idLowongan: map['id_lowongan'],
                  nomorSoal: map['nomor_soal'],
                  idUjian: map['id_ujian'],
                  subtes: map['subtes'],
                  jawaban: map['jawaban'],
                  jawaban2: map['jawaban2'],
                  jawabanKunci: map['jawaban_kunci'],
                  jawabanKunci2: map['jawaban_kunci2'],
                );
              }).toList(),
            );
          });
          loadImages();
          setAnswer();
          isLoading = false;

          // print(getSorted(examData));
        } else {
          setState(() {
            isLoading = false;
          });
          // Show error message
          showErrorDialog("Gagal", "Ada kesalahan", context);
        }
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        showErrorDialog("Gagal", e.toString(), context);
      }
    }
  }

  void loadQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      questions = [];
    });
    try {
      var url = Uri.parse("$baseUrl/cfit-questions/$subtes");
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
      );
      print(response.body);

      if (mounted) {
        if (response.statusCode == 200) {
          DateTime now = DateTime.now();
          var data = jsonDecode(response.body)['data'] as List;
          // print(DateTime.parse("2026-02-03T14:25:35+07:00").toLocal());
          setState(() {
            questions.addAll(
              data.map((dynamic json) {
                final map = json as Map<String, dynamic>;
                return CfitQuestion(
                  idSoal: map['id_soal'],
                  nomorSoal: map['nomor_soal'],
                  soal: map['soal'],
                  opsiA: map['opsi_a'],
                  opsiB: map['opsi_b'],
                  opsiC: map['opsi_c'],
                  opsiD: map['opsi_d'],
                  opsiE: map['opsi_e'],
                  opsiF: map['opsi_f'],
                  jawaban: map['jawaban'],
                  jawaban2: map['jawaban2'],
                  typeSoal: map['type_soal'],
                  subtes: map['subtes'],
                );
              }).toList(),
            );
          });

          isLoading = false;
          loadImages();
          // print(getSorted(examData));
        } else {
          setState(() {
            isLoading = false;
          });
          // Show error message
          showErrorDialog("Gagal", "Ada kesalahan", context);
        }
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        showErrorDialog("Gagal", e.toString(), context);
      }
    }
  }

  void sendAnswer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.parse("$baseUrl/cfit/send?subtes=$subtes");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${prefs.getString('token')}",
        },
        body: jsonEncode({
          "id_pelamar": int.parse(prefs.getString('id_pelamar')!),
          "id_lowongan": idLowongan,
          "nomor_soal": nomorSoal,
          "id_ujian": 1,
          "jawaban": alphabeticOrder[selectedIndex == -1 ? 0 : selectedIndex]
              .toString()
              .toUpperCase(),
          "jawaban_kunci": questions
              .where((e) => e.nomorSoal == nomorSoal)
              .first
              .jawaban,
          "jawaban2": "",
          "jawaban_kunci2": "",
        }),
      );
      print(response.body);
      // if (response.statusCode == 200) {

      // }
    } catch (e) {
      print(e);
    }
  }

  void next() {
    if (selectedIndex != -1) {
      sendAnswer();
    }
    setState(() {
      nomorSoal += 1;
      selectedIndex = -1;
    });
    print(nomorSoal);
    loadAnswer();
  }

  void before() {
    setState(() {
      nomorSoal -= 1;
      selectedIndex = -1;
    });
    print(nomorSoal);
    loadAnswer();
  }

  void continueTest() {
    loadAnswer();
    if (answer.length != questions.length) {
      showErrorDialog(
        "Perhatian",
        "Anda harus mengisi semua jawaban untuk melanjutkan tes",
        context,
      );
    } else {
      Get.to(() => CfitSub4TestScreen(targetSubtes: 4));
    }
  }

  Widget bottomBtn(width, height) {
    if (nomorSoal == questions.length) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          // vertical: 5,
          horizontal: 17,
        ),
        child: Container(
          width: width / 2.7,
          height: 50,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: HexColor('FBC02D'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              continueTest();
              // Get.to(() => CompleteTest(title: "Ujian CFIT"));
            },
            child: Text(
              subtes == 4 ? "Kirim Jawaban" : "Lanjutkan Ujian",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xffffffff),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
    } else if (nomorSoal == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          // vertical: 5,
          horizontal: 17,
        ),
        child: Container(
          width: width / 2.7,
          height: 50,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: HexColor('FBC02D'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              next();
            },
            child: Text(
              "Berikutnya",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xffffffff),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              // vertical: 5,
              horizontal: 17,
            ),
            child: Container(
              width: width / 2.7,
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: HexColor('FBC02D'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  before();
                },
                child: Text(
                  "Sebelumnya",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              // vertical: 5,
              horizontal: 17,
            ),
            child: Container(
              width: width / 2.7,
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: HexColor('FBC02D'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  next();
                },
                child: Text(
                  "Berikutnya",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Future<bool> _showExitConfirmation(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
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
            'Jika kamu kembali atau tidak melanjutkan tes, semua data yang telah diisi akan dihapus dan tidak terkirim. Apakah kamu yakin ingin keluar dari tes?',
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
                        'Lanjutkan Tes',
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
                        Get.off(() => ExamDashboard());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        foregroundColor: HexColor("FFFFFF"),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Keluar Tes',
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false, // Prevents automatic popping
      onPopInvokedWithResult: (didPop, result) async {
        // If the system already handled the pop, don't do anything
        if (didPop) return;

        // Show the dialog and wait for the user's choice
        final shouldPop = await _showExitConfirmation(context);

        // Crucial: Check if the widget is still "mounted" before using context
        if (context.mounted && (shouldPop)) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.left_chevron,
              fontWeight: FontWeight.w700,
              color: HexColor("454545"),
            ),
          ),
          title: Text(
            "Ujian CFIT Sub $subtes",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: HexColor("454545"),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ClockWidget(
                timeSeconds: 180,
                redirectTo: () {
                  Get.to(() => CfitSub4TestScreen(targetSubtes: 4));
                },
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: HexColor('828282'),
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            loadAnswer();
            loadQuestion();
          },
          color: HexColor('FBC02D'),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              children: [
                SizedBox(height: 25),
                showCFITInstructions(subtes, context),
                SizedBox(height: 10),
                Container(
                  width: width / 1.2,
                  height: height / 14,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            nomorSoal = questions[index].nomorSoal!;
                          });
                          loadAnswer();
                          setAnswer();
                        },
                        child: CarouselCard(
                          id: questions[index].nomorSoal.toString(),
                          isSelected:
                              answer
                                  .where(
                                    (element) =>
                                        element.nomorSoal ==
                                        questions[index].nomorSoal,
                                  )
                                  .isNotEmpty
                              ? true
                              : false,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: height / 30),

                Text(
                  "Pertanyaan $nomorSoal",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: HexColor('454545'),
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Container(
                  child: CachedNetworkImage(
                    height: 100,
                    width: width / 1.3,
                    imageUrl:
                        "$choiseUrl/upload/bank_soal/cfit/${questions.isEmpty ? 0 : questions[nomorSoal - 1].soal!}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            color: HexColor('FBC02D'),
                            value: downloadProgress.progress,
                          ),
                        ),
                    errorWidget: (context, url, error) {
                      print(error);
                      return Icon(Icons.error, color: HexColor('FBC02D'));
                    },
                  ),
                ),

                SizedBox(height: height / 30),
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    strokeCap: StrokeCap.round,
                    color: HexColor('FBC02D'),
                    dashPattern: [10, 5],
                    strokeWidth: 2,
                    padding: EdgeInsets.all(16),
                    radius: Radius.circular(16),
                  ),
                  child: Container(
                    height: height / 3.7,
                    width: width,
                    child: GridView.count(
                      childAspectRatio: 1.0,
                      crossAxisCount: 3,
                      children: List.generate(
                        6,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex =
                                    index; // Update the selected index on tap
                                keyAnswer = questions
                                    .where(
                                      (element) =>
                                          element.nomorSoal == nomorSoal,
                                    )
                                    .first
                                    .jawaban!;
                              });
                              sendAnswer();
                              // loadAnswer();
                              // print("Selected choice: ${alphabeticOrder[index]}");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndex == index
                                      ? HexColor("FBC02D")
                                      : Colors.white,
                                  width: 5,
                                ),
                                color: HexColor("D9D9D9"),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              height: height / 3,
                              width: width / 2.5,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 100,
                                width: width / 1.3,
                                imageUrl:
                                    "$choiseUrl/upload/bank_soal/cfit/${images.isEmpty ? 0 : images[index]}",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                        color: HexColor('FBC02D'),
                                        value: downloadProgress.progress,
                                      ),
                                    ),
                                errorWidget: (context, url, error) {
                                  print(error);
                                  return Icon(
                                    Icons.error,
                                    color: HexColor('FBC02D'),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 7),

                bottomBtn(width, height),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
