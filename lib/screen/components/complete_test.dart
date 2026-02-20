import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_choise/screen/exam_dashboard.dart';
import 'package:mobile_choise/utils/hex_color.dart';

class CompleteTest extends StatefulWidget {
  const CompleteTest({super.key, required this.title});
  final String title;

  @override
  State<CompleteTest> createState() => _CompleteTestState();
}

class _CompleteTestState extends State<CompleteTest> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => ExamDashboard());
          },
          icon: Icon(
            CupertinoIcons.left_chevron,
            fontWeight: FontWeight.w700,
            color: HexColor("454545"),
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: HexColor("454545"),
          ),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: height / 4),
          Text(
            "Berhasil",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: HexColor('454545'),
              fontSize: 35,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "Data berhasil dikirim",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: HexColor('454545'),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: height / 15),
          SizedBox(
            height: height / 10,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    heightFactor: 1.8,
                    child: Lottie.asset(
                      'assets/animations/Complete.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height / 4.5),
          Container(
            // padding: EdgeInsets.only(top: height / 2),
            width: width,
            height: height / 5,
            decoration: BoxDecoration(
              color: HexColor('FBC02D'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: height / 15,
                horizontal: 50,
              ),
              child: Container(
                width: width / 2,
                height: 20,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.off(() => ExamDashboard());
                  },
                  child: Text(
                    "Kembali ke Beranda",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: HexColor('FBC02D'),
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
