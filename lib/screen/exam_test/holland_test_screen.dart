import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/screen/components/complete_test.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';

class HollandTestScreen extends StatefulWidget {
  const HollandTestScreen({super.key});

  @override
  State<HollandTestScreen> createState() => _HollandTestScreenState();
}

class _HollandTestScreenState extends State<HollandTestScreen> {
  String? _selectedOption;

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
              textStyle: GoogleFonts.poppins(
                color: HexColor('828282'),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
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
                "Petunjuk Pengisian",
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
                        "Pada kuesioner ini terdiri atas 6 tabel, masing-masing tabel terdiri atas 3 kolom kosong yang harus diisi oleh Bapak/Ibu sekalian dengan menggunakan tanda () pada pernyataan yang mencerminkan diri Bapak/Ibu sekalian pada beberapa pertanyaan yang telah disediakan. Untuk pemilihan masing-masing pernyataan sangat memungkinkan untuk memilih atau mencentang () lebih dari satu pernyataan pada masing-masing kolom. Oleh karena itu, kami mengharapkan Bapak/Ibu mencermati dengan seksama setiap pernyataan yang ada, kemudian memilih satu atau lebih dari pernyataan pada masing-masing kolom yang tersedia pada tabel tersebut.",
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
            // Container(
            //   width: width / 5,
            //   height: height / 2.5,
            //   decoration: BoxDecoration(
            //     color: HexColor('FBC02D'),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 20),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(height: 25),
            //         Text(
            //           "Petunjuk Pengisian",
            //           style: GoogleFonts.poppins(
            //             color: Colors.white,
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         SizedBox(height: 10),
            //         Text(
            //           "Pada kuesioner ini terdiri atas 6 tabel, masing-masing tabel terdiri atas 3 kolom kosong yang harus diisi oleh Bapak/Ibu sekalian dengan menggunakan tanda () pada pernyataan yang mencerminkan diri Bapak/Ibu sekalian pada beberapa pertanyaan yang telah disediakan. Untuk pemilihan masing-masing pernyataan sangat memungkinkan untuk memilih atau mencentang () lebih dari satu pernyataan pada masing-masing kolom. Oleh karena itu, kami mengharapkan Bapak/Ibu mencermati dengan seksama setiap pernyataan yang ada, kemudian memilih satu atau lebih dari pernyataan pada masing-masing kolom yang tersedia pada tabel tersebut.",
            //           style: GoogleFonts.poppins(
            //             color: Colors.white,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "*Dimohon untuk me submit jawaban sebelum waktu ujian berakhir, agar jawaban dapat terekam !",
                style: GoogleFonts.poppins(
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
              style: GoogleFonts.poppins(
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
                rows: List<DataRow>.generate(
                  10,
                  (index) => DataRow(
                    cells: <DataCell>[
                      DataCell(
                        CheckboxListTile(
                          activeColor: HexColor('FBC02D'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: true,
                          onChanged: (val) {},
                          title: Text("Praktis"),
                        ),
                      ),
                      DataCell(
                        CheckboxListTile(
                          activeColor: HexColor('FBC02D'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: true,
                          onChanged: (val) {},
                          title: Text("Memperbaiki alat elektronik"),
                        ),
                      ),
                      DataCell(
                        CheckboxListTile(
                          activeColor: HexColor('FBC02D'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: true,
                          onChanged: (val) {},
                          title: Text(
                            "Kegiatan yang menuntut untuk berpikir secara mekanis",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    Get.to(() => CompleteTest(title: "Ujian DISC"));
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
            ),
            SizedBox(height: height / 20),
          ],
        ),
      ),
    );
  }
}
