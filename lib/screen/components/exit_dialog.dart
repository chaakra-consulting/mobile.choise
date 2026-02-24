import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_choise/screen/exam_dashboard.dart';
import 'package:mobile_choise/utils/hex_color.dart';

Future<bool> showExitConfirmation(BuildContext context) async {
  final textTheme = Theme.of(context).textTheme;
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFD69E2E),
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Peringatan',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Semua data yang telah anda masukkan sebelumnya, mungkin tidak terkirim. Apakah anda yakin ingin keluar dari tes?',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 14, height: 1.4),
        ),
        actionsOverflowButtonSpacing: 5,
        actionsOverflowDirection: VerticalDirection.down,
        actions: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: HexColor('FBC02D')),
                      ),
                    ),
                    child: Text(
                      'Lanjutkan Tes',
                      style: textTheme.labelMedium?.copyWith(
                        fontFamily: 'Poppins',
                        color: HexColor('FBC02D'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(() => ExamDashboard());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD69E2E),
                      foregroundColor: HexColor("FFFFFF"),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Keluar Tes',
                      style: textTheme.labelMedium?.copyWith(
                        fontFamily: 'Poppins',
                        color: HexColor("FFFFFF"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
  return result ?? false;
}
