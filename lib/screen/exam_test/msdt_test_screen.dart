import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/screen/components/carousel_card.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';

import '../components/complete_test.dart';

class MSDTTestScreen extends StatefulWidget {
  const MSDTTestScreen({super.key});

  @override
  State<MSDTTestScreen> createState() => _MSDTTestScreenState();
}

class _MSDTTestScreenState extends State<MSDTTestScreen> {
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
          "Ujian MSDT",
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
                    2,
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

                        height: height / 5.5,
                        width: 100,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Saya tidak akan menegur pelanggar - pelanggar peraturan bila saya merasa pasti bahwa tidak ada satu orangpun yang mengetahui tentang pelanggar - pelanggar tersebut.",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: index == 1
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
