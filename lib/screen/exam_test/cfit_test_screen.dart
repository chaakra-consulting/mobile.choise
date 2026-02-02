import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/screen/components/carousel_card.dart';
import 'package:mobile_choise/screen/components/complete_test.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/widgets/clock_widget.dart';

class CfitTestScreen extends StatefulWidget {
  const CfitTestScreen({super.key});

  @override
  State<CfitTestScreen> createState() => _CfitTestScreenState();
}

class _CfitTestScreenState extends State<CfitTestScreen> {
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
          "Ujian CFIT",
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
            SizedBox(height: height / 20),
            Center(
              child: Text(
                "Harap kerjakan ujian dengan sejujur-jujurnya",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: HexColor("454545"),
                ),
              ),
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
            SizedBox(height: height / 20),

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
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: index == 2
                                ? HexColor("FBC02D")
                                : Colors.white,
                            width: 2,
                          ),
                          color: HexColor("D9D9D9"),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        height: height / 3,
                        width: width / 2.5,
                        child: Center(
                          child: Icon(Icons.image, color: HexColor('454545')),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
                    Get.to(() => CompleteTest(title: "Ujian CFIT"));
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
