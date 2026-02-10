import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/models/MSDTAnswer.dart';
import 'package:mobile_choise/models/MSDTQuestion.dart';
import 'package:mobile_choise/screen/components/carousel_card.dart';
import 'package:mobile_choise/screen/components/dialog_components.dart';
import 'package:mobile_choise/utils/base_url.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../components/complete_test.dart';

class MSDTTestScreen extends StatefulWidget {
  const MSDTTestScreen({super.key});

  @override
  State<MSDTTestScreen> createState() => _MSDTTestScreenState();
}

class _MSDTTestScreenState extends State<MSDTTestScreen> {
  final List<String> items = List<String>.generate(20, (i) => i.toString());

  List<MsdtQuestion> questions = [];
  List<MsdtAnswer> answers = [];
  int nomorSoal = 1;
  bool isLoading = false;
  List choiceList = [];
  Map<String, dynamic> selectedChoice = {};

  @override
  void initState() {
    super.initState();
    loadQuestion();
    loadAnswer();
  }

  void loadAnswer() async {
    setState(() {
      answers = [];
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(
        "$baseUrl/msdt-questions/by-exam-number?id_pelamar=${prefs.getString('id_pelamar')}&id_lowongan=$idLowongan",
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
            answers.addAll(
              data.map((dynamic json) {
                final map = json as Map<String, dynamic>;
                return MsdtAnswer(
                  idJawabanMsdt: map['id_jawaban_msdt'],
                  idPelamar: map['id_pelamar'],
                  idLowongan: map['id_lowongan'],
                  idUjian: map['id_ujian'],
                  noSoal: map['no_soal'],
                  jawaban: map['jawaban'],
                );
              }).toList(),
            );
          });
          setAnswer();
          setState(() {
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

  void next() {
    if (selectedChoice.isNotEmpty) {
      sendAnswer();
    } else {
      setState(() {
        nomorSoal += 1;
        selectedChoice = {};
      });
      setChoiceList();
    }
    // loadAnswer();
  }

  void before() {
    setState(() {
      nomorSoal -= 1;
      selectedChoice = {};
    });
    print(nomorSoal);
    setChoiceList();
    // setState(() {
    //   selectedIndex = -1;
    //   selectedChoice = "";
    // });
    // loadAnswer();
  }

  void loadQuestion() async {
    setState(() {
      isLoading = true;
      questions = [];
    });
    try {
      var url = Uri.parse("$baseUrl/msdt-questions");
      final response = await http.get(url);
      // print(response.body);

      if (mounted) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['data'] as List;
          setState(() {
            questions.addAll(
              data.map((dynamic json) {
                final map = json as Map<String, dynamic>;
                return MsdtQuestion(
                  idSoal: map['id_soal'],
                  noSoal: map['no_soal'],
                  pernyataan1: map['pernyataan_1'],
                  pernyataan2: map['pernyataan_2'],
                  aspek1: map['aspek_1'],
                  aspek2: map['aspek_2'],
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

  void setChoiceList() {
    if (questions.isNotEmpty) {
      var questionsEl = questions.where(
        (element) => element.noSoal == nomorSoal,
      );
      setState(() {
        choiceList = [
          {
            "aspek": questionsEl.first.aspek1,
            "pernyataan": questionsEl.first.pernyataan1,
          },
          {
            "aspek": questionsEl.first.aspek2,
            "pernyataan": questionsEl.first.pernyataan2,
          },
        ];
      });
    }
  }

  void sendAnswer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse("$baseUrl/msdt/send");
      final response = await http.post(
        url,
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
        body: jsonEncode({
          "id_pelamar": int.parse(prefs.getString('id_pelamar')!),
          "id_lowongan": idLowongan,
          "id_ujian": 1,
          "no_soal": nomorSoal,
          "jawaban": selectedChoice["aspek"],
        }),
      );
      print(
        jsonEncode(<String, dynamic>{
          "id_pelamar": prefs.getString('id_pelamar'),
          "id_lowongan": idLowongan,
          "id_ujian": 1,
          "no_soal": nomorSoal,
          "jawaban": selectedChoice["aspek"],
        }),
      );
      print(response.body);
      setState(() {
        nomorSoal += 1;
        selectedChoice = {};
      });
      loadAnswer();
    } catch (e) {
      print(e);
    }
  }

  void setAnswer() {
    var answersEl = answers.where(
      (element) =>
          element.noSoal == nomorSoal && element.idLowongan == idLowongan,
    );
    if (answersEl.isNotEmpty) {
      setState(() {
        selectedChoice = {"aspek": answersEl.first.jawaban, "pernyataan": ""};
      });
    }
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
          "Tes Tipe Kepemimpinan",
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
              timeSeconds: 3600,
              redirectTo: () {
                Get.to(() => CompleteTest(title: "Tes Tipe Kepemimpinan"));
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
          setChoiceList();
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
                                "1. Dalam ujian ini terdapat 64 pasang pernyataan",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "2. Setiap nomor akan terdiri dari satu pasang pernyataan",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "3. Tugas anda memilih satu pernyataan yang paling sesuai / mencerminklan diri anda",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '4. Apabila pernyataan tersebut sama - sama mencerminkan diri anda / bahkan sebaliknya , maka anda tetap harus memilih 1 ( Satu ) pernyataan yang paling mendekati dari setiap pasang pernyataan.',
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
                                setChoiceList();
                                loadAnswer();
                                selectedChoice = {};
                              });
                            },
                            child: CarouselCard(
                              id: questions[index].noSoal.toString(),
                              isSelected:
                                  answers
                                      .where(
                                        (element) =>
                                            element.noSoal ==
                                            questions[index].noSoal,
                                      )
                                      .isEmpty
                                  ? false
                                  : true,
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
                        height: height / 2.5,
                        width: width,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                            2,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedChoice = choiceList[index];
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
                                    color:
                                        choiceList[index]['aspek'] ==
                                            selectedChoice['aspek']
                                        ? HexColor("FBC02D")
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),

                                  height: height / 5.5,
                                  width: 100,
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      choiceList.isEmpty
                                          ? " "
                                          : choiceList[index]['pernyataan'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            choiceList[index]['aspek'] ==
                                                selectedChoice['aspek']
                                            ? Colors.white
                                            : HexColor("FBC02D"),
                                      ),
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
