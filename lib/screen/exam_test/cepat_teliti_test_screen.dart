import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/models/CepatTelitiAnswer.dart';
import 'package:mobile_choise/models/CepatTelitiQuestion.dart';
import 'package:mobile_choise/screen/components/carousel_card.dart';
import 'package:mobile_choise/screen/components/complete_test.dart';
import 'package:mobile_choise/screen/components/dialog_components.dart';
import 'package:mobile_choise/utils/base_url.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CepatTelitiTestScreen extends StatefulWidget {
  const CepatTelitiTestScreen({super.key});

  @override
  State<CepatTelitiTestScreen> createState() => _CepatTelitiTestScreenState();
}

class _CepatTelitiTestScreenState extends State<CepatTelitiTestScreen> {
  int nomorSoal = 1;
  final List<String> items = List<String>.generate(20, (i) => i.toString());
  bool isLoading = false;
  List<CepatTelitiQuestion> questions = [];
  List choiceList = [];
  List<CepatTelitiAnswer> answer = [];
  String selectedChoice = "";
  List alphabet = ["A", "B", "C", "D", "E"];
  int selectedIndex = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadQuestion();
    loadAnswer();
  }

  void loadQuestion() async {
    setState(() {
      isLoading = true;
      questions = [];
      selectedIndex = -1;
      selectedChoice = "";
    });
    try {
      var url = Uri.parse("$baseUrl/cepat-teliti-questions");
      final response = await http.get(url);
      // print(response.body);

      if (mounted) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['data'] as List;
          setState(() {
            questions.addAll(
              data.map((dynamic json) {
                final map = json as Map<String, dynamic>;
                return CepatTelitiQuestion(
                  idSoal: map['id_soal'],
                  noSoal: map['no_soal'],
                  soal: map['soal'],
                  opsiA: map['opsi_a'],
                  opsiB: map['opsi_b'],
                  opsiC: map['opsi_c'],
                  opsiD: map['opsi_d'],
                  opsiE: map['opsi_e'],
                  jawaban: map['jawaban'],
                );
              }).toList(),
            );
            isLoading = false;
          });
          setChoiceList();
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

  void loadAnswer() async {
    setState(() {
      answer = [];
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(
        "$baseUrl/cepat-teliti-questions/by-exam-number?id_pelamar=${prefs.getString('id_pelamar')}&id_lowongan=$idLowongan",
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
                return CepatTelitiAnswer(
                  idJawabanCepat: map['id_jawaban_cepat'],
                  idPelamar: map['id_pelamar'],
                  idLowongan: map['id_lowongan'],
                  noSoal: map['no_soal'],
                  idUjian: map['id_ujian'],
                  jawaban: map['jawaban'],
                );
              }).toList(),
            );
          });
          setAnswer();
          setState(() {
            var answerData = answer.where(
              (element) =>
                  element.noSoal == nomorSoal &&
                  element.idLowongan == idLowongan,
            );
            selectedIndex = answerData.isNotEmpty
                ? alphabet.indexOf(answerData.first.jawaban!)
                : -1;
            print(answerData.isNotEmpty);
            isLoading = false;
          });

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
    print(nomorSoal);
    print(alphabet[selectedIndex]);
    // setAnswer();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("$baseUrl/cepat-teliti/send");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer ${prefs.getString('token')}",
      },
      body: jsonEncode({
        "id_lowongan": idLowongan,
        "id_pelamar": int.parse(prefs.getString('id_pelamar')!),
        "id_ujian": 1,
        "no_soal": nomorSoal,
        "jawaban": alphabet[selectedIndex],
      }),
    );
    print(response.body);
    print(
      jsonEncode({
        "id_lowongan": idLowongan,
        "id_pelamar": int.parse(prefs.getString('id_pelamar')!),
        "id_ujian": 1,
        "no_soal": nomorSoal,
        "jawaban": alphabet[selectedIndex],
      }),
    );
    setState(() {
      nomorSoal += 1;
      selectedIndex = -1;
      selectedChoice = "";
    });
    loadAnswer();
  }

  void setAnswer() {
    var answerElement = answer.where(
      (element) =>
          element.noSoal == nomorSoal && element.idLowongan == idLowongan,
    );
    setState(() {
      if (answerElement.isNotEmpty) {
        var jawaban = alphabet
            .where((element) => element == answerElement.first.jawaban)
            .first;
        // print(jawaban);
      }

      // selectedChoice = jawaban;
    });
  }

  void next() {
    if (selectedIndex != -1) {
      sendAnswer();
    } else {
      setState(() {
        nomorSoal += 1;
      });
      setChoiceList();
      loadAnswer();
    }
  }

  void before() {
    setState(() {
      nomorSoal -= 1;
      selectedIndex = -1;
    });
    print(nomorSoal);
    setChoiceList();
    // setState(() {
    //   selectedIndex = -1;
    //   selectedChoice = "";
    // });
    loadAnswer();
  }

  void setChoiceList() {
    if (questions.isNotEmpty) {
      setState(() {
        choiceList = [
          questions.where((element) => element.noSoal == nomorSoal).first.opsiA,
          questions.where((element) => element.noSoal == nomorSoal).first.opsiB,
          questions.where((element) => element.noSoal == nomorSoal).first.opsiC,
          questions.where((element) => element.noSoal == nomorSoal).first.opsiD,
          questions.where((element) => element.noSoal == nomorSoal).first.opsiE,
        ];
      });
    }
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
      Get.to(() => CompleteTest(title: "Tes Cepat Teliti"));
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
              "Kirim Jawaban",
              style: GoogleFonts.poppins(
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
              style: GoogleFonts.poppins(
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
                  style: GoogleFonts.poppins(
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
                  style: GoogleFonts.poppins(
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
          "Tes Cepat Teliti",
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: HexColor("454545"),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ClockWidget(
              timeSeconds: 720,
              redirectTo: () {
                Get.to(() => CompleteTest(title: "Tes Cepat Teliti"));
              },
              textStyle: GoogleFonts.poppins(
                color: HexColor('828282'),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: HexColor('FBC02D'),
        onRefresh: () async {
          loadQuestion();
          loadAnswer();
        },
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(color: HexColor('FBC02D')),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      collapsedBackgroundColor: HexColor('FBC02D'),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      splashColor: HexColor('FBC02D'),
                      backgroundColor: HexColor('FBC02D'),
                      title: Text(
                        "INSTRUKSI TES!",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1. Dalam tes ini anda akan dihadapkan pada 100 soal yang akan dikerjakan dalam waktu yg terbatas.",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "2. Tes ini bertujuan untuk membandingkan pasangan huruf dan angka yang ada di setiap soalnya.",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "3. Di setiap soal terdapat 5 pasang kombinasi huruf dan angka dalam susunan yg berbeda-beda.",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '4. Tugas anda adalah mencari "SATU KESAMAAN" kombinasi huruf dan angka yang "DIGARISBAWAHI" di soal dengan pilihan jawaban yang sudah disediakan.',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

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
                                nomorSoal = questions[index].noSoal!;
                              });
                              loadAnswer();
                              setChoiceList();
                              setAnswer();
                            },
                            child: CarouselCard(
                              id: questions[index].noSoal.toString(),
                              isSelected:
                                  answer
                                      .where(
                                        (element) =>
                                            element.noSoal ==
                                            questions[index].noSoal,
                                      )
                                      .isNotEmpty
                                  ? true
                                  : false,
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      "Pertanyaan $nomorSoal",
                      // textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: HexColor('454545'),
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    // SizedBox(height: height / 30),
                    Html(
                      data: questions.isEmpty
                          ? ""
                          : "<h1>${questions.where((index) => index.noSoal == nomorSoal).first.soal}</h1>",
                      style: {
                        "p": Style(
                          fontStyle: GoogleFonts.poppins(
                            color: HexColor('454545'),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ).fontStyle,
                        ),
                      },
                    ),
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
                        height: height / 2.5,
                        width: width,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                            4,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  // selectedChoice = questions
                                  //     .where(
                                  //       (element) =>
                                  //           element.noSoal == nomorSoal,
                                  //     )
                                  //     .first
                                  //     .jawaban!;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: HexColor("FBC02D"),
                                      width: 2,
                                    ),
                                    color: index == selectedIndex
                                        ? HexColor("FBC02D")
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),

                                  height: height / 13,
                                  width: 100,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 12,
                                      bottom: 12,
                                      left: 25,
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 20),
                                        Text(
                                          choiceList.isEmpty
                                              ? " "
                                              : choiceList[index],
                                          style: GoogleFonts.poppins(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: index == selectedIndex
                                                ? Colors.white
                                                : HexColor("FBC02D"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 10),
                    bottomBtn(width, height),
                  ],
                ),
              ),
      ),
    );
  }
}
