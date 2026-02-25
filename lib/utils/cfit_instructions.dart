import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:mobile_choise/utils/base_url.dart';
import 'package:mobile_choise/utils/hex_color.dart';

Widget showCFITInstructions(int subTest, BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  switch (subTest) {
    case 1:
      return ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        collapsedBackgroundColor: Colors.red[700],
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        splashColor: Colors.red[700],
        backgroundColor: Colors.red[700],
        title: Text(
          "INSTRUKSI TES!",
          style: TextStyle(
            fontFamily: 'Poppins',
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
                  "1. Pada ujian CFIT ini akan terdapat 4 macam subtes.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "2. Untuk subtes pertama, pilihlah kotak yang dapat melanjutkan pola sebelumnya!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  child: CachedNetworkImage(
                    height: 100,
                    width: width / 1.3,
                    imageUrl:
                        "$choiseUrl/assets3/images/soalcfit/subtes1/contoh/contoh1.jpg",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                              color: HexColor('FBC02D'),
                              value: downloadProgress.progress,
                            ),
                    errorWidget: (context, url, error) {
                      print(error);
                      return Icon(Icons.error, color: HexColor('FBC02D'));
                    },
                  ),
                ),

                SizedBox(height: 10),
                Row(
                  spacing: 10,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "a",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/assets3/images/soalcfit/subtes1/contoh/1a.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "b",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/assets3/images/soalcfit/subtes1/contoh/1b.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "c",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/assets3/images/soalcfit/subtes1/contoh/1c.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "d",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/assets3/images/soalcfit/subtes1/contoh/1d.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "e",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/assets3/images/soalcfit/subtes1/contoh/1e.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "f",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/assets3/images/soalcfit/subtes1/contoh/1f.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  "Jawaban: (c) karena ranting pohon perlahan bergerak ke kanan.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      );
    case 2:
      return ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        collapsedBackgroundColor: Colors.red[700],
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        splashColor: Colors.red[700],
        backgroundColor: Colors.red[700],
        title: Text(
          "INSTRUKSI TES!",
          style: TextStyle(
            fontFamily: 'Poppins',
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
                  "1. Disetiap soal terdapat 5 kotak yang didalamnya memiliki gambar yang berbeda-beda, dimana 3 kotak diantaranya memiliki gambar yang sama.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "2. Tugas anda, carilah 2 kotak dengan gambar yang berbeda dari 3 diantaranya. Kemudian isikan 2 (dua) abjadnya pada pilihan jawaban yang tersedia di masing-masing soal.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "3. INGAT: 1 Soal berisi 2 jawaban!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  spacing: 10,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "a",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/contoh_2a.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "b",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/contoh_2b.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "c",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/contoh_2c.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "d",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/contoh_2d.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "e",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/contoh_2e.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  "Jawaban: (b) dan (d). Karena memiliki bukan berbentuk segitiga seperti yang lainnya.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      );
    case 3:
      return ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        collapsedBackgroundColor: Colors.red[700],
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        splashColor: Colors.red[700],
        backgroundColor: Colors.red[700],
        title: Text(
          "INSTRUKSI TES!",
          style: TextStyle(
            fontFamily: 'Poppins',
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
                  "1. Disetiap soal terdapat sebuah kotak besar, dimana didalamnya terdapat 4 buah kotak kecil.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "2. Tiga kotak kecil diantaranya sudah terisi dengan pola/urutan tertentu.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "3.Tugas anda: Carilah 1 dari 5 pilihan jawaban yang ada untuk mengisi kotak kosong ke-4 sehingga menjadi berurutan satu sama lain!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  child: CachedNetworkImage(
                    height: 100,
                    width: width / 1.3,
                    imageUrl: "$choiseUrl/upload/bank_soal/cfit/contoh11.jpg",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                              color: HexColor('FBC02D'),
                              value: downloadProgress.progress,
                            ),
                    errorWidget: (context, url, error) {
                      print(error);
                      return Icon(Icons.error, color: HexColor('FBC02D'));
                    },
                  ),
                ),

                SizedBox(height: 10),
                Row(
                  spacing: 10,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "a",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1a3.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "b",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1b3.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "c",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1c3.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "d",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1d3.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "e",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1e3.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "f",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1f3.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  "Jawaban: (b). Karena sesuai untuk mengisi kotak kecil yang kosong tersebut",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      );
    case 4:
      return ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        collapsedBackgroundColor: Colors.red[700],
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        splashColor: Colors.red[700],
        backgroundColor: Colors.red[700],
        title: Text(
          "INSTRUKSI TES!",
          style: TextStyle(
            fontFamily: 'Poppins',
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
                  "1. Disetiap soal terdapat sebuah kotak besar, dimana didalamnya terdapat 2 bangun yang saling beririsan satu sama lain.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "2. Irisan 2 bangun tersebut, ditandai dengan sebuah tanda titik (.)",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "3. Tugas anda, Mencari kesamaan gambar soal dengan 5 pilihan gambar yang ada di masing-masing jawaban.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "4. INGAT: Tanda titik (.) akan dihilangkan pada masing-masing pilihan jawaban, sehingga visualisasikan gambar soal dgn pilihan jawaban yang tersedia.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  child: CachedNetworkImage(
                    height: 100,
                    width: width / 1.3,
                    imageUrl: "$choiseUrl/upload/bank_soal/cfit/contoh12.jpg",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                              color: HexColor('FBC02D'),
                              value: downloadProgress.progress,
                            ),
                    errorWidget: (context, url, error) {
                      print(error);
                      return Icon(Icons.error, color: HexColor('FBC02D'));
                    },
                  ),
                ),

                SizedBox(height: 10),
                Row(
                  spacing: 10,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "a",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1a4.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "b",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1b4.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "c",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1c4.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "d",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1d4.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "e",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: CachedNetworkImage(
                            height: 50,
                            width: width / 8,
                            imageUrl:
                                "$choiseUrl/upload/bank_soal/cfit/1e4.jpg",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                      color: HexColor('FBC02D'),
                                      value: downloadProgress.progress,
                                    ),
                            errorWidget: (context, url, error) {
                              print(error);
                              return Icon(
                                Icons.error,
                                color: HexColor('FBC02D'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  "Jawaban: (c). Karena pola tersebut dapat diletakkan titik yang sama seperti pada soal.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      );
    default:
      return Container();
  }
}
