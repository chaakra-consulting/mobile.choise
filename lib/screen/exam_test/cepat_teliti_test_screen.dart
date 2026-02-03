import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/screen/components/carousel_card.dart';
import 'package:mobile_choise/screen/components/complete_test.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';

class CepatTelitiTestScreen extends StatefulWidget {
  const CepatTelitiTestScreen({super.key});

  @override
  State<CepatTelitiTestScreen> createState() => _CepatTelitiTestScreenState();
}

class _CepatTelitiTestScreenState extends State<CepatTelitiTestScreen> {
  final List<String> items = List<String>.generate(20, (i) => i.toString());
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
          "Ujian Cepat Teliti",
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
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return CarouselCard(
                    id: items[index],
                    isSelected: index > 2 ? false : true,
                  );
                },
              ),
            ),
            Text(
              "Pertanyaan 1",
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
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor("FBC02D"),
                            width: 2,
                          ),
                          color: index == 1 ? HexColor("FBC02D") : Colors.white,
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
                              // Text(
                              //   index.toString(),
                              //   style: GoogleFonts.poppins(
                              //     fontSize: 25,
                              //     fontWeight: FontWeight.bold,
                              //     color: HexColor("FBC02D"),
                              //   ),
                              // ),
                              SizedBox(width: 20),
                              Text(
                                "Vx",
                                style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: index == 1
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
            Padding(
              padding: EdgeInsets.only(
                // vertical: 5,
                top: height / 7,
                left: 17,
                right: 17,
                bottom: 10,
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
                    Get.to(() => CompleteTest(title: "Ujian Cepat Teliti"));
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
