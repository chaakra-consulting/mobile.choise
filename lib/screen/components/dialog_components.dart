import 'package:flutter/material.dart';

void showErrorDialog(String title, String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Color(0xFFE53E3E), size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: TextStyle(color: Color(0xFF666666), fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            // style: TextButton.styleFrom(
            //   foregroundColor: _themeManager.currentColors.primary,
            // ),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
