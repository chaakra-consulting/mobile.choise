import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_choise/utils/hex_color.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({Key? key, required this.id, this.isSelected})
    : super(key: key);
  final String id;
  final isSelected;
  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          width: 70,
          height: 100,
          decoration: BoxDecoration(
            color: HexColor('FBC02D'),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              id,
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 70,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: HexColor('FBC02D'), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            id,
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: HexColor('FBC02D'),
            ),
          ),
        ),
      ),
    );
  }
}
