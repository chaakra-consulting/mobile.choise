import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_choise/screen/auth/login_screen.dart';
import 'package:mobile_choise/screen/dashboard_screen.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirectToDashboard();
  }

  void _redirectToDashboard() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    // runApp(MaterialApp(home: email == null ? Login() : Home()));
    Timer(const Duration(seconds: 3), () {
      Get.offAll(token == null ? const LoginScreen() : DashboardScreen());
      // Get.offAll(token == null ? const LoginPage() : const JurnalBaruPage());
      // Get.offAll(const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: HexColor('FBC02D'),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(top: height / 2.5),
              child: Center(
                child: Text(
                  "Choise",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 70),
              child: Center(
                child: Text(
                  "Chaakra-choise psychotest",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: height / 10),
            Padding(
              padding: EdgeInsets.only(top: height / 5),
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 20),
              child: Center(
                child: Image.asset('assets/images/chaakra.png', height: 60),
              ),
            ),
          ],
        ),
      ),
      // ListView(
      //   children: [
      //     Container(
      //       width: 414,
      //       height: 896,
      //       clipBehavior: Clip.antiAlias,
      //       decoration: BoxDecoration(color: Colors.white),
      //       child: Stack(
      //         children: [
      //           Positioned(
      //             left: 140,
      //             top: 431,
      //             child: Text(
      //               'Choise',
      //               style: TextStyle(
      //                 color: const Color(0xFF444444),
      //                 fontSize: 36,
      //                 fontFamily: 'Poppins',
      //                 fontWeight: FontWeight.w800,
      //               ),
      //             ),
      //           ),
      //           Positioned(
      //             left: 78,
      //             top: 490,
      //             child: Text(
      //               'Chaakra-choise psychotest',
      //               style: TextStyle(
      //                 color: const Color(0xFF444444),
      //                 fontSize: 20,
      //                 fontFamily: 'Plus Jakarta Sans',
      //                 fontWeight: FontWeight.w400,
      //               ),
      //             ),
      //           ),
      //           Positioned(
      //             left: 65,
      //             top: 271,
      //             child: Container(
      //               width: 279,
      //               height: 136,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: const AssetImage('assets/images/chaakra.png'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      //             ),
      //           ),

      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
