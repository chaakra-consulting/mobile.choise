import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:mobile_choise/screen/auth/forgot_password/reset_password_screen.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class FindEmailScreen extends StatefulWidget {
  const FindEmailScreen({super.key});

  @override
  State<FindEmailScreen> createState() => _FindEmailScreenState();
}

class _FindEmailScreenState extends State<FindEmailScreen> {
  var textButton = "Reset Password";
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: HexColor('FBC02D'),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            width: width,
            height: height / 7,
            child: Padding(
              padding: EdgeInsets.only(top: width / 9, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          CupertinoIcons.left_chevron,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Lupa Password",
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height / 26),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Lupa Password",
              style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: HexColor('454545'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Masukkan email yang anda gunakan saat mendaftar. ",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: HexColor('454545'),
              ),
            ),
          ),

          SizedBox(height: height / 20),

          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 17),
            child: Text(
              "Email",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                color: HexColor('828282'),
                fontSize: 15,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
            child: MaterialTextField(
              theme: FilledOrOutlinedTextTheme(
                focusedColor: HexColor('FBC02D'),
                radius: 10,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                errorStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                fillColor: Colors.white,
                prefixIconColor: HexColor('1C2D57'),
                enabledColor: HexColor('AEAEAE'),
                hintStyle: GoogleFonts.poppins(
                  color: HexColor('8189B0'),
                  fontSize: 18,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              hint: 'Email',
              prefixIcon: Icon(
                CupertinoIcons.mail_solid,
                size: 19,
                color: HexColor('8189B0'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height / 2.1,
              bottom: 5,
              left: 17,
              right: 17,
            ),
            child: Shimmer(
              duration: const Duration(seconds: 5),
              color: Colors.purpleAccent,
              colorOpacity: 0, //Default value
              enabled: true, //Default value
              direction:
                  const ShimmerDirection.fromLeftToRight(), //Default Value
              child: Container(
                width: 100,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: HexColor('FBC02D'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      textButton = "Loading...";
                    });
                    Future.delayed(Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() {
                          textButton = "Reset Password";
                          isLoading = false;
                        });
                      }
                    });
                    Get.to(() => ResetPasswordScreen());
                  },
                  child: Text(
                    textButton,
                    style: GoogleFonts.poppins(
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
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
