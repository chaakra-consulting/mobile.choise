import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:mobile_choise/utils/redirect_screen.dart';

class ExamCard extends StatelessWidget {
  Function? onClick;
  String title;
  DateTime waktuMulai;
  DateTime waktuAkhir;
  bool status;
  ExamCard({
    super.key,
    required this.title,
    required this.waktuMulai,
    required this.waktuAkhir,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 5,
      height: height / 4.2,
      decoration: BoxDecoration(
        border: Border.all(color: HexColor('FBC02D'), width: 2),
        color: status ? HexColor('FBC02D') : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              width: width / 3,
              height: 30,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: status ? Colors.white : HexColor("A6A6A6"),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "${waktuAkhir.difference(waktuMulai).inMinutes} Menit",
              style: GoogleFonts.poppins(
                color: status ? Colors.white : HexColor("A6A6A6"),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: width / 2,
              height: 20,
              child: Text(
                overflow: TextOverflow.ellipsis,
                "${DateFormat('yy-MM-dd').format(waktuMulai)} ${DateFormat.Hm().format(waktuMulai)} - ${DateFormat('HH:mm').format(waktuAkhir)} ",
                style: GoogleFonts.poppins(
                  color: status ? Colors.white : HexColor("A6A6A6"),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: width / 7),
              child: TextButton(
                onPressed: !status
                    ? null
                    : () {
                        redirectToExam(title, context);
                      },
                child: Text(
                  status ? "Kerjakan" : "Berakhir",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: status ? Colors.white : HexColor("A6A6A6"),
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
