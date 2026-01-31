import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:mobile_choise/screen/auth/forgot_password/find_email_screen.dart';
import 'package:mobile_choise/screen/dashboard_screen.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidden = true;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  var textButton = "Login";
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(height: 100),
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset('assets/images/chaakra.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Text(
              "Choise",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: HexColor('454545'),
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              "Masuk menggunakan akun anda",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: HexColor('828282'),
                fontSize: 15,
              ),
            ),
          ),

          SizedBox(height: height / 14),
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 17),
            child: Text(
              "Username",
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
                radius: 10,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                errorStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                focusedColor: HexColor('FBC02D'),
                fillColor: Colors.white,
                enabledColor: HexColor('AEAEAE'),
                prefixIconColor: HexColor('1C2D57'),
                hintStyle: GoogleFonts.poppins(
                  color: HexColor('8189B0'),
                  fontSize: 18,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              hint: 'Username',
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(
                CupertinoIcons.person,
                size: 19,
                color: HexColor('8189B0'),
              ),
              controller:
                  _emailTextController, // TextEditingController _emailTextController = TextEditingController()
              validator: FormValidation.emailTextField,
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 17),
            child: Text(
              "Password",
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
              obscureText: hidden,
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
              hint: 'Password',
              prefixIcon: Icon(
                CupertinoIcons.lock,
                size: 19,
                color: HexColor('8189B0'),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidden = !hidden;
                  });
                },
                icon: hidden
                    ? Icon(
                        CupertinoIcons.eye,
                        size: 19,
                        color: HexColor('8189B0'),
                      )
                    : Icon(
                        CupertinoIcons.eye_slash,
                        size: 19,
                        color: HexColor('8189B0'),
                      ),
              ),
              controller:
                  _passwordTextController, // TextEditingController _emailTextController = TextEditingController()
              validator: FormValidation.requiredTextField,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.to(() => FindEmailScreen());
                },
                child: Text(
                  "Lupa password?",
                  style: GoogleFonts.poppins(color: HexColor('828282')),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
            child: Shimmer(
              duration: const Duration(seconds: 5),
              color: Colors.purpleAccent,
              colorOpacity: 0, //Default value
              enabled: true, //Default value
              direction:
                  const ShimmerDirection.fromLeftToRight(), //Default Value
              child: Container(
                width: 100,
                height: 40,
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
                          textButton = "Login";
                          isLoading = false;
                        });
                      }
                    });

                    Get.offAll(() => DashboardScreen());
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
              // ), ElevatedButton(
              //   onPressed: () {
              // setState(() {
              //   isLoading = true;
              //   textButton = "Loading...";
              // });
              // Future.delayed(Duration(seconds: 2), () {
              //   if (mounted) {
              //     setState(() {
              //       textButton = "Login";
              //       isLoading = false;
              //     });
              //   }
              // });

              // Get.offAll(() => DashboardScreen());
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: HexColor('FBC02D'),
              //   ),
              //   child: Text(
              //     textButton,
              //     style: GoogleFonts.poppins(
              //       fontWeight: FontWeight.w800,
              //       fontSize: 16,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
