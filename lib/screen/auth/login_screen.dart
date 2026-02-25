import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:material_text_fields/utils/form_validation.dart';
import 'package:mobile_choise/screen/auth/forgot_password/find_email_screen.dart';
import 'package:mobile_choise/screen/dashboard_screen.dart';
import 'package:mobile_choise/utils/base_url.dart';
import 'package:mobile_choise/utils/hex_color.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_choise/screen/components/dialog_components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidden = true;
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  var textButton = "Login";
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        textButton = "Loading...";
      });

      try {
        var url = Uri.parse("$baseUrl/login");
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "username": _usernameTextController.text,
            "password": _passwordTextController.text,
          }),
        );
        print(response.body);

        if (mounted) {
          setState(() {
            isLoading = false;
            textButton = "Login";
          });

          if (response.statusCode == 200) {
            var data = jsonDecode(response.body)['data'];
            prefs.setString("username", data['user']['username']);
            prefs.setString(
              "id_pelamar",
              data['user']['id_pelamar'].toString(),
            );
            prefs.setString("token", data['token']);
            prefs.setString(
              "nama_pelamar",
              data['user']['UserData']['nama_pelamar'],
            );

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Berhasil login"),
                backgroundColor: Color(0xFF38A169),
                duration: Duration(seconds: 2),
              ),
            );
            // print(data['token']);
            Get.offAll(() => DashboardScreen());
          } else {
            setState(() {
              isLoading = false;
              textButton = "Login";
            });
            // Show error message
            showErrorDialog(
              "Gagal",
              "Gagal login. Periksa kembali username dan password anda",
              context,
            );
          }
        }
      } catch (e) {
        print(e);
        if (mounted) {
          setState(() {
            isLoading = false;
            textButton = "Login";
          });
          showErrorDialog(
            "Gagal",
            "Periksa koneksi internet anda dan coba lagi",
            context,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: ListView(
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
                  style: TextStyle(
                    fontFamily: 'Poppins',
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
                  style: TextStyle(
                    fontFamily: 'Poppins',
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
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: HexColor('828282'),
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 17,
                ),
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
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
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
                      _usernameTextController, // TextEditingController _usernameTextController = TextEditingController()
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // Use your localized string here
                      return "Kolom harus diisi";
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 17),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: HexColor('828282'),
                    fontSize: 15,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 17,
                ),
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
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      color: HexColor('8189B0'),
                      fontSize: 18,
                    ),
                  ),
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
                      _passwordTextController, // TextEditingController _usernameTextController = TextEditingController()
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // Use your localized string here
                      return "Kolom harus diisi";
                    }
                    return null;
                  },
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
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: HexColor('828282'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 17,
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
                    height: 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: HexColor('FBC02D'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        login();
                      },
                      child: Text(
                        textButton,
                        style: TextStyle(
                          fontFamily: 'Poppins',
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
        ),
      ),
    );
  }
}
