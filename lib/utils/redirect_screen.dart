import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_choise/screen/components/dialog_components.dart';
import 'package:mobile_choise/screen/exam_test/cepat_teliti_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/cfit_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/disc_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/holland_test_screen.dart';
import 'package:mobile_choise/screen/exam_test/msdt_test_screen.dart';

void redirectToExam(String name, BuildContext context) {
  switch (name) {
    case 'Tes Cepat Teliti ':
      Get.to(() => CepatTelitiTestScreen());
      break;
    case 'Tes Intelegensi 1 (CFIT)':
      Get.to(() => CfitTestScreen());
      break;
    case 'Tes Tipe Kepribadian':
      Get.to(() => DISCTestScreen());
      break;
    case 'Tes Minat Kerja':
      Get.to(() => HollandTestScreen());
      break;
    case 'Tes Tipe Kepemimpinan ':
      Get.to(() => MSDTTestScreen());
      break;
    default:
      showErrorDialog("Error", "Ada kesalahan", context);
  }
}
