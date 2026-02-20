import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/models/HollandQuestion.dart';
import 'package:mobile_choise/screen/components/complete_test.dart';
import 'package:mobile_choise/screen/components/dialog_components.dart';
import 'package:mobile_choise/utils/base_url.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_choise/widgets/clock_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HollandTestScreen extends StatefulWidget {
  const HollandTestScreen({super.key});

  @override
  State<HollandTestScreen> createState() => _HollandTestScreenState();
}

class _HollandTestScreenState extends State<HollandTestScreen> {
  String? _selectedOption;
  bool isLoading = false;
  List<HollandQuestion> questions = [];
  int nilaiR = 0;
  int nilaiI = 0;
  int nilaiA = 0;
  int nilaiS = 0;
  int nilaiE = 0;
  int nilaiK = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadQuestion();
  }

  void send() async {
    setState(() {
      nilaiR = questions
          .where((element) => element.isChecked!)
          .where((element) => element.type == "Realistic")
          .fold(0, (sum, item) => sum + item.value!);
      nilaiI = questions
          .where((element) => element.isChecked!)
          .where((element) => element.type == "Investigative")
          .fold(0, (sum, item) => sum + item.value!);
      nilaiA = questions
          .where((element) => element.isChecked!)
          .where((element) => element.type == "Artistic")
          .fold(0, (sum, item) => sum + item.value!);
      nilaiS = questions
          .where((element) => element.isChecked!)
          .where((element) => element.type == "Social")
          .fold(0, (sum, item) => sum + item.value!);
      nilaiE = questions
          .where((element) => element.isChecked!)
          .where((element) => element.type == "Enterprising")
          .fold(0, (sum, item) => sum + item.value!);
      nilaiK = questions
          .where((element) => element.isChecked!)
          .where((element) => element.type == "Konvensional")
          .fold(0, (sum, item) => sum + item.value!);
    });
    print([nilaiR, nilaiI, nilaiA, nilaiS, nilaiE, nilaiK]);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.parse("$baseUrl/holland/send");
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
          "nilai_r": nilaiR,
          "nilai_i": nilaiI == 0 ? 0 : nilaiI,
          "nilai_a": nilaiA,
          "nilai_s": nilaiS,
          "nilai_e": nilaiE,
          "nilai_k": nilaiK,
        }),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil mengerjakan ujian"),
          backgroundColor: Color(0xFF38A169),
          duration: Duration(seconds: 2),
        ),
      );
      Get.off(() => CompleteTest(title: "Ujian DISC"));
    } catch (e) {
      print(e);
    }
  }

  void loadQuestion() async {
    setState(() {
      isLoading = true;
      questions = [];
    });
    try {
      var url = Uri.parse("$baseUrl/holland-questions");
      final response = await http.get(url);
      // print(response.body);

      if (mounted) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body)['data'] as List;
          setState(() {
            questions.addAll(
              data.map((dynamic json) {
                final map = json as Map<String, dynamic>;
                return HollandQuestion(
                  id: map['id'],
                  questionText: map['question_text'],
                  type: map['type'],
                  identifier: map['identifier'],
                  isChecked: false,
                  value: 1,
                );
              }).toList(),
            );
          });
          isLoading = false;

          print(
            questions
                .where((element) => element.type == "Realistic")
                .where((element) => element.identifier == "i_like")
                .length,
          );
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
          "Ujian Holland",
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
              timeSeconds: 1200,
              redirectTo: () {
                Get.to(() => CompleteTest(title: "Ujian Holland"));
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
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(color: HexColor('FBC02D')),
                )
              : ListView(
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
                        "Petunjuk Pengisian",
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
                              Text(
                                "Pada kuesioner ini terdiri atas 6 tabel, masing-masing tabel terdiri atas 3 kolom kosong yang harus diisi oleh Bapak/Ibu sekalian dengan menggunakan tanda () pada pernyataan yang mencerminkan diri Bapak/Ibu sekalian pada beberapa pertanyaan yang telah disediakan. \nUntuk pemilihan masing-masing pernyataan sangat memungkinkan untuk memilih atau mencentang () lebih dari satu pernyataan pada masing-masing kolom. \nOleh karena itu, kami mengharapkan Bapak/Ibu mencermati dengan seksama setiap pernyataan yang ada, kemudian memilih satu atau lebih dari pernyataan pada masing-masing kolom yang tersedia pada tabel tersebut.",
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
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "*Dimohon untuk me submit jawaban sebelum waktu ujian berakhir, agar jawaban dapat terekam !",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: HexColor("454545"),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),

                    Text(
                      "Realistis",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: HexColor('454545'),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowMaxHeight: 80,
                        // Step 2: Define your 3 headers
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              "Saya adalah seorang yang :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya mampu :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya menyukai :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        // Step 3: Add your data rows
                        rows: List<DataRow>.generate(5, (index) {
                          var realisticIAs = questions
                              .where((element) => element.type == "Realistic")
                              .where((element) => element.identifier == "i_as")
                              .elementAt(index);
                          var realisticCan = questions
                              .where((element) => element.type == "Realistic")
                              .where((element) => element.identifier == "i_can")
                              .elementAt(index);
                          var realisticLike = questions
                              .where((element) => element.type == "Realistic")
                              .where(
                                (element) => element.identifier == "i_like",
                              )
                              .elementAt(index);
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(
                                CheckboxListTile(
                                  activeColor: HexColor('FBC02D'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: realisticIAs.isChecked!,
                                  onChanged: (val) {
                                    setState(() {
                                      realisticIAs.isChecked = val!;
                                    });
                                  },
                                  title: Text(realisticIAs.questionText!),
                                ),
                              ),
                              DataCell(
                                CheckboxListTile(
                                  activeColor: HexColor('FBC02D'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: realisticCan.isChecked!,
                                  onChanged: (val) {
                                    setState(() {
                                      realisticCan.isChecked = val!;
                                    });
                                  },
                                  title: Text(realisticCan.questionText!),
                                ),
                              ),
                              DataCell(
                                realisticLike.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: realisticLike.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            realisticLike.isChecked = val!;
                                          });
                                        },
                                        title: Text(
                                          realisticLike.questionText!,
                                        ),
                                      ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: 25),

                    Text(
                      "Investigatif",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: HexColor('454545'),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowMaxHeight: 80,
                        // Step 2: Define your 3 headers
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              "Saya adalah seorang yang :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya mampu :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya menyukai :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        // Step 3: Add your data rows
                        rows: List<DataRow>.generate(7, (index) {
                          var investigativeIAs = questions
                              .where(
                                (element) => element.type == "Investigative",
                              )
                              .where((element) => element.identifier == "i_as")
                              .elementAt(index);
                          var investigativeCan = questions
                              .where(
                                (element) => element.type == "Investigative",
                              )
                              .where((element) => element.identifier == "i_can")
                              .elementAt(index);
                          var investigativeLike = questions
                              .where(
                                (element) => element.type == "Investigative",
                              )
                              .where(
                                (element) => element.identifier == "i_like",
                              )
                              .elementAt(index);
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(
                                CheckboxListTile(
                                  activeColor: HexColor('FBC02D'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: investigativeIAs.isChecked!,
                                  onChanged: (val) {
                                    setState(() {
                                      investigativeIAs.isChecked = val!;
                                    });
                                  },
                                  title: Text(investigativeIAs.questionText!),
                                ),
                              ),
                              DataCell(
                                CheckboxListTile(
                                  activeColor: HexColor('FBC02D'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: investigativeCan.isChecked!,
                                  onChanged: (val) {
                                    setState(() {
                                      investigativeCan.isChecked = val!;
                                    });
                                  },
                                  title: Text(investigativeCan.questionText!),
                                ),
                              ),
                              DataCell(
                                investigativeLike.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: investigativeLike.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            investigativeLike.isChecked = val!;
                                          });
                                        },
                                        title: Text(
                                          investigativeLike.questionText!,
                                        ),
                                      ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: 25),
                    Text(
                      "Artistik",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: HexColor('454545'),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowMaxHeight: 80,
                        // Step 2: Define your 3 headers
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              "Saya adalah seorang yang :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya mampu :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya menyukai :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        // Step 3: Add your data rows
                        rows: List<DataRow>.generate(5, (index) {
                          var artisticIAs = questions
                              .where((element) => element.type == "Artistic")
                              .where((element) => element.identifier == "i_as")
                              .elementAt(index);
                          var artisticCan = questions
                              .where((element) => element.type == "Artistic")
                              .where((element) => element.identifier == "i_can")
                              .elementAt(index);
                          var artisticLike = questions
                              .where((element) => element.type == "Artistic")
                              .where(
                                (element) => element.identifier == "i_like",
                              )
                              .elementAt(index);
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(
                                CheckboxListTile(
                                  activeColor: HexColor('FBC02D'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: artisticIAs.isChecked!,
                                  onChanged: (val) {
                                    setState(() {
                                      artisticIAs.isChecked = val!;
                                    });
                                  },
                                  title: Text(artisticIAs.questionText!),
                                ),
                              ),
                              DataCell(
                                artisticCan.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: artisticCan.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            artisticCan.isChecked = val!;
                                          });
                                        },
                                        title: Text(artisticCan.questionText!),
                                      ),
                              ),
                              DataCell(
                                artisticLike.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: artisticLike.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            artisticLike.isChecked = val!;
                                          });
                                        },
                                        title: Text(artisticLike.questionText!),
                                      ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: 25),
                    Text(
                      "Sosial",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: HexColor('454545'),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowMaxHeight: 80,
                        // Step 2: Define your 3 headers
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              "Saya adalah seorang yang :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya mampu :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya menyukai :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        // Step 3: Add your data rows
                        rows: List<DataRow>.generate(6, (index) {
                          var socialIAs = questions
                              .where((element) => element.type == "Social")
                              .where((element) => element.identifier == "i_as")
                              .elementAt(index);
                          var socialCan = questions
                              .where((element) => element.type == "Social")
                              .where((element) => element.identifier == "i_can")
                              .elementAt(index);
                          var socialLike = questions
                              .where((element) => element.type == "Social")
                              .where(
                                (element) => element.identifier == "i_like",
                              )
                              .elementAt(index);
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(
                                CheckboxListTile(
                                  activeColor: HexColor('FBC02D'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: socialIAs.isChecked!,
                                  onChanged: (val) {
                                    setState(() {
                                      socialIAs.isChecked = val!;
                                    });
                                  },
                                  title: Text(socialIAs.questionText!),
                                ),
                              ),
                              DataCell(
                                socialCan.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: socialCan.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            socialCan.isChecked = val!;
                                          });
                                        },
                                        title: Text(socialCan.questionText!),
                                      ),
                              ),
                              DataCell(
                                socialLike.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: socialLike.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            socialLike.isChecked = val!;
                                          });
                                        },
                                        title: Text(socialLike.questionText!),
                                      ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: 25),
                    Text(
                      "Enterprising",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: HexColor('454545'),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowMaxHeight: 80,
                        // Step 2: Define your 3 headers
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              "Saya adalah seorang yang :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya mampu :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya menyukai :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        // Step 3: Add your data rows
                        rows: List<DataRow>.generate(6, (index) {
                          var enterprisingIAs = questions
                              .where(
                                (element) => element.type == "Enterprising",
                              )
                              .where((element) => element.identifier == "i_as")
                              .elementAt(index);
                          var enterprisingCan = questions
                              .where(
                                (element) => element.type == "Enterprising",
                              )
                              .where((element) => element.identifier == "i_can")
                              .elementAt(index);
                          var enterprisingLike = questions
                              .where(
                                (element) => element.type == "Enterprising",
                              )
                              .where(
                                (element) => element.identifier == "i_like",
                              )
                              .elementAt(index);
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(
                                CheckboxListTile(
                                  activeColor: HexColor('FBC02D'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: enterprisingIAs.isChecked!,
                                  onChanged: (val) {
                                    setState(() {
                                      enterprisingIAs.isChecked = val!;
                                    });
                                  },
                                  title: Text(enterprisingIAs.questionText!),
                                ),
                              ),
                              DataCell(
                                enterprisingCan.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: enterprisingCan.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            enterprisingCan.isChecked = val!;
                                          });
                                        },
                                        title: Text(
                                          enterprisingCan.questionText!,
                                        ),
                                      ),
                              ),
                              DataCell(
                                enterprisingLike.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: enterprisingLike.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            enterprisingLike.isChecked = val!;
                                          });
                                        },
                                        title: Text(
                                          enterprisingLike.questionText!,
                                        ),
                                      ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: 25),
                    Text(
                      "Konvensional",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: HexColor('454545'),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowMaxHeight: 80,
                        // Step 2: Define your 3 headers
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              "Saya adalah seorang yang :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya mampu :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Saya menyukai :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        // Step 3: Add your data rows
                        rows: List<DataRow>.generate(6, (index) {
                          var konvensionalIAs = questions
                              .where(
                                (element) => element.type == "Konvensional",
                              )
                              .where((element) => element.identifier == "i_as")
                              .elementAt(index);
                          var konvensionalCan = questions
                              .where(
                                (element) => element.type == "Konvensional",
                              )
                              .where((element) => element.identifier == "i_can")
                              .elementAt(index);
                          var konvensionalLike = questions
                              .where(
                                (element) => element.type == "Konvensional",
                              )
                              .where(
                                (element) => element.identifier == "i_like",
                              )
                              .elementAt(index);
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(
                                CheckboxListTile(
                                  activeColor: HexColor('FBC02D'),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: konvensionalIAs.isChecked!,
                                  onChanged: (val) {
                                    setState(() {
                                      konvensionalIAs.isChecked = val!;
                                    });
                                  },
                                  title: Text(konvensionalIAs.questionText!),
                                ),
                              ),
                              DataCell(
                                konvensionalCan.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: konvensionalCan.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            konvensionalCan.isChecked = val!;
                                          });
                                        },
                                        title: Text(
                                          konvensionalCan.questionText!,
                                        ),
                                      ),
                              ),
                              DataCell(
                                konvensionalLike.questionText == "-"
                                    ? Text("-")
                                    : CheckboxListTile(
                                        activeColor: HexColor('FBC02D'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: konvensionalLike.isChecked!,
                                        onChanged: (val) {
                                          setState(() {
                                            konvensionalLike.isChecked = val!;
                                          });
                                        },
                                        title: Text(
                                          konvensionalLike.questionText!,
                                        ),
                                      ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: height / 10),
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
                            send();
                            // Get.to(() => CompleteTest(title: "Ujian DISC"));
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
                    ),
                    SizedBox(height: height / 20),
                  ],
                ),
        ),
      ),
    );
  }
}
