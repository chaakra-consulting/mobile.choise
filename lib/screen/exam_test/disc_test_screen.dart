import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/models/DISCAnswer.dart';
import 'package:mobile_choise/models/DISCQuestion.dart';
import 'package:mobile_choise/screen/components/carousel_card.dart';
import 'package:mobile_choise/screen/components/complete_test.dart';
import 'package:mobile_choise/screen/components/dialog_components.dart';
import 'package:mobile_choise/utils/base_url.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DISCTestScreen extends StatefulWidget {
  const DISCTestScreen({super.key});

  @override
  State<DISCTestScreen> createState() => _DISCTestScreenState();
}

class _DISCTestScreenState extends State<DISCTestScreen> {
  final List<String> items = List<String>.generate(20, (i) => i.toString());
  String? _selectedOption;
  String? selectedLOption;
  String? selectedMOption;

  int nomorSoal = 1;
  bool isLoading = false;
  List lChoice = [];
  List mChoice = [];
  List pernyataanChoice = [];
  List<DiscQuestion> questions = [];
  List<DiscAnswer> answers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadQuestion();
    loadAnswer();
  }

  void setAllChoice() {
    var question = questions.where((element) => element.idSoal == nomorSoal);

    if (question.isNotEmpty) {
      setState(() {
        lChoice = [
          question.first.aspekL1,
          question.first.aspekL2,
          question.first.aspekL3,
          question.first.aspekL4,
        ];

        mChoice = [
          question.first.aspekM1,
          question.first.aspekM2,
          question.first.aspekM3,
          question.first.aspekM4,
        ];
        pernyataanChoice = [
          question.first.pernyataan1,
          question.first.pernyataan2,
          question.first.pernyataan3,
          question.first.pernyataan4,
        ];
      });
    }
  }

  void resetChoice() {
    setState(() {
      selectedLOption = null;
      selectedMOption = null;
    });
  }

  void next() {
    if (selectedLOption != null && selectedMOption != null) {
      sendAnswer();
    } else {
      setState(() {
        nomorSoal += 1;
      });
      resetChoice();
      setAllChoice();
    }
  }

  void before() {
    setState(() {
      nomorSoal -= 1;
    });
    resetChoice();
    setAllChoice();
    // setState(() {
    //   selectedIndex = -1;
    //   selectedChoice = "";
    // });
    // loadAnswer();
  }

  void continueTest() {
    loadAnswer();
    if (answers.length != questions.length) {
      showErrorDialog(
        "Perhatian",
        "Anda harus mengisi semua jawaban untuk melanjutkan tes",
        context,
      );
    } else {
      Get.to(() => CompleteTest(title: "Tes Tipe Kepemimpinan"));
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
            },
            child: Text(
              "Kirim Jawaban",
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

  void loadQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      questions = [];
    });
    try {
      var url = Uri.parse("$baseUrl/disc-questions");
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
      );
      // print(response.body);

      if (mounted) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['data'] as List;
          // print(DateTime.parse("2026-02-03T14:25:35+07:00").toLocal());
          setState(() {
            questions.addAll(
              data.map((dynamic json) {
                final map = json as Map<String, dynamic>;
                return DiscQuestion(
                  idSoal: map['id_soal'],
                  noSoal: map['no_soal'],
                  pernyataan1: map['pernyataan_1'],
                  pernyataan2: map['pernyataan_2'],
                  pernyataan3: map['pernyataan_3'],
                  pernyataan4: map['pernyataan_4'],
                  aspekM1: map['aspek_m1'],
                  aspekM2: map['aspek_m2'],
                  aspekM3: map['aspek_m3'],
                  aspekM4: map['aspek_m4'],
                  aspekL1: map['aspek_l1'],
                  aspekL2: map['aspek_l2'],
                  aspekL3: map['aspek_l3'],
                  aspekL4: map['aspek_l4'],
                );
              }).toList(),
            );
            isLoading = false;
          });

          setAllChoice();

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

  void loadAnswer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      answers = [];
      isLoading = true;
    });
    try {
      var url = Uri.parse(
        "$baseUrl/disc-questions/by-exam-number?id_pelamar=${prefs.getString('id_pelamar')}&id_lowongan=$idLowongan",
      );
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
      );
      // print(response.body);

      if (mounted) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['data'] as List;
          // print(DateTime.parse("2026-02-03T14:25:35+07:00").toLocal());
          setState(() {
            answers.addAll(
              data.map((dynamic json) {
                final map = json as Map<String, dynamic>;
                return DiscAnswer(
                  idJawabanDisc: map['id_jawaban_disc'],
                  idPelamar: map['id_pelamar'],
                  idLowongan: map['id_lowongan'],
                  idUjian: map['id_ujian'],
                  noSoal: map['no_soal'],
                  jawaban: map['jawaban'],
                  jawaban2: map['jawaban2'],
                );
              }).toList(),
            );
            isLoading = false;
          });
          print(answers.where((e) => e.noSoal == nomorSoal).isNotEmpty);
          if (answers.where((e) => e.noSoal == nomorSoal).isNotEmpty) {
            setState(() {
              selectedLOption = answers
                  .where((e) => e.noSoal == nomorSoal)
                  .first
                  .jawaban2;
              selectedMOption = answers
                  .where((e) => e.noSoal == nomorSoal)
                  .first
                  .jawaban;
            });
          }
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var url = Uri.parse("$baseUrl/disc/send");
      final response = await http.post(
        url,
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
        body: jsonEncode({
          "id_pelamar": int.parse(prefs.getString('id_pelamar')!),
          "id_lowongan": idLowongan,
          "no_soal": nomorSoal,
          "id_ujian": 1,
          "jawaban": selectedMOption,
          "jawaban2": selectedLOption,
          "nomor_soal": nomorSoal,
        }),
      );
      print(response.body);
      print(
        jsonEncode({
          "id_pelamar": int.parse(prefs.getString('id_pelamar')!),
          "id_lowongan": idLowongan,
          "id_ujian": 1,
          "no_soal": nomorSoal,
          "jawaban": selectedMOption,
          "jawaban2": selectedLOption,
          "nomor_soal": nomorSoal,
        }),
      );
      setState(() {
        nomorSoal += 1;
      });
      resetChoice();
      setAllChoice();
    } catch (e) {
      print(e);
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
          "Tes Tipe Kepribadian",
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
              timeSeconds: 1800,
              redirectTo: () {
                Get.to(() => CompleteTest(title: "Tes Tipe Kepribadian"));
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
                        style: TextStyle(
                          fontFamily: 'Poppins',
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
                              SizedBox(height: 10),
                              Text(
                                "1. Pilihlah 1 pernyataan yang PALING SESUAI dengan diri Anda SAAT INI ( M )",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "2. Pilihlah 1 pernyataan yang PALING TIDAK SESUAI dengan Anda SAAT INI ( L )",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "3. Dalam 1 nomor akan ada 2 jawaban (1 jawaban pernyataan M & 1 Jawaban pernyataan L)",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "4. Dalam satu nomor soal, tidak boleh ada jawaban yang sama untuk masing-masing kolom M dan L",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
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

                    SizedBox(height: 25),
                    Container(
                      width: width / 1.2,
                      height: height / 14,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          var answer = answers.where(
                            (element) =>
                                element.noSoal == questions[index].noSoal,
                          );
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                nomorSoal = questions[index].noSoal!;
                                setAllChoice();
                                loadAnswer();
                                selectedLOption = null;
                                selectedMOption = null;
                              });
                            },
                            child: CarouselCard(
                              id: questions[index].noSoal.toString(),
                              isSelected: answer.isEmpty ? false : true,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),

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
                    Text(
                      "*Pastikan Tidak Ada 2 Jawaban pada kolom ( M / L ) yang sama , 2 Jawaban diwajibkan pada kolom ( M / L ) yang berbeda",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HexColor("454545"),
                      ),
                    ),
                    SizedBox(height: height / 20),
                    Table(
                      border: TableBorder.all(color: Colors.black, width: 1.0),
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'M',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor("454545"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'L',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor("454545"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Pernyataan',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor("454545"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (var i = 0; i < 4; i++)
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Radio<String>(
                                  activeColor: HexColor('FBC02D'),
                                  value: mChoice.isNotEmpty ? mChoice[i] : "",
                                  groupValue: selectedMOption,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedMOption = value;
                                    });
                                    print(selectedMOption);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Radio<String>(
                                  activeColor: HexColor('FBC02D'),
                                  value: lChoice.isNotEmpty ? lChoice[i] : "",
                                  groupValue: selectedLOption,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedLOption = value;
                                    });
                                    print(selectedLOption);
                                  },
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  pernyataanChoice.isNotEmpty
                                      ? pernyataanChoice[i]
                                      : "",
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: height / 10),

                    bottomBtn(width, height),
                    SizedBox(height: height / 20),
                  ],
                ),
              ),
      ),
    );
  }
}
