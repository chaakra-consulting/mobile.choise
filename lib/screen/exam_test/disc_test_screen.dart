import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/screen/components/carousel_card.dart';
import 'package:mobile_choise/screen/components/complete_test.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';
import 'package:scroll_table/scroll_table.dart';

class DISCTestScreen extends StatefulWidget {
  const DISCTestScreen({super.key});

  @override
  State<DISCTestScreen> createState() => _DISCTestScreenState();
}

class _DISCTestScreenState extends State<DISCTestScreen> {
  final List<String> items = List<String>.generate(20, (i) => i.toString());
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
          "Ujian DISC",
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
                      SizedBox(height: 10),
                      Text(
                        "1. Pilihlah 1 pernyataan yang PALING SESUAI dengan diri Anda SAAT INI ( M )",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "2. Pilihlah 1 pernyataan yang PALING TIDAK SESUAI dengan Anda SAAT INI ( L )",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "3. Dalam 1 nomor akan ada 2 jawaban (1 jawaban pernyataan M & 1 Jawaban pernyataan L)",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "4. Dalam satu nomor soal, tidak boleh ada jawaban yang sama untuk masing-masing kolom M dan L",
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

            SizedBox(height: 25),
            Container(
              width: width / 1.2,
              height: height / 14,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CarouselCard(
                    id: items[index],
                    isSelected: index > 2 ? false : true,
                  );
                },
              ),
            ),
            SizedBox(height: 10),

            Text(
              "Pertanyaan 1",
              // textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: HexColor('454545'),
                fontSize: 27,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              "*Pastikan Tidak Ada 2 Jawaban pada kolom ( M / L ) yang sama , 2 Jawaban diwajibkan pada kolom ( M / L ) yang berbeda",
              style: GoogleFonts.poppins(
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
                        style: GoogleFonts.poppins(
                          color: HexColor("454545"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'L',
                        style: GoogleFonts.poppins(
                          color: HexColor("454545"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Pernyataan',
                        style: GoogleFonts.poppins(
                          color: HexColor("454545"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Radio<String>(
                        activeColor: HexColor('FBC02D'),
                        value: 'option1',
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Radio<String>(
                        activeColor: HexColor('FBC02D'),
                        value: 'option2',
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Sederhana, Mudah Menerima, Rendah Hati"),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height / 10),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(
            //         // vertical: 5,
            //         horizontal: 17,
            //       ),
            //       child: Container(
            //         width: width / 2.7,
            //         height: 50,
            //         child: TextButton(
            //           style: TextButton.styleFrom(
            //             backgroundColor: HexColor('FBC02D'),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //           ),
            //           onPressed: () {},
            //           child: Text(
            //             "Sebelumnya",
            //             style: GoogleFonts.poppins(
            //               color: Color(0xffffffff),
            //               fontWeight: FontWeight.w700,
            //               fontSize: 18,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(
            //         // vertical: 5,
            //         horizontal: 17,
            //       ),
            //       child: Container(
            //         width: width / 2.7,
            //         height: 50,
            //         child: TextButton(
            //           style: TextButton.styleFrom(
            //             backgroundColor: HexColor('FBC02D'),
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //           ),
            //           onPressed: () {},
            //           child: Text(
            //             "Berikutnya",
            //             style: GoogleFonts.poppins(
            //               color: Color(0xffffffff),
            //               fontWeight: FontWeight.w700,
            //               fontSize: 18,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Padding(
              padding: EdgeInsets.only(
                // vertical: 5,
                top: height / 3.7,
                left: 17,
                right: 17,
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
                    Get.to(() => CompleteTest(title: "Ujian Holland"));
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
          ],
        ),
      ),
    );
  }
}
