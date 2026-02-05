import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_choise/screen/exam_dashboard.dart'; // import 'package:intl/intl.dart';

class ClockWidget extends StatefulWidget {
  // class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key, required this.textStyle});
  final TextStyle textStyle;

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  Timer? _timer;
  int _startSeconds = 500; // Initial time in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_startSeconds == 0) {
        setState(() {
          timer.cancel(); // Stop the timer when it reaches zero
          print("Timer finished");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Waktu Habis",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xFF38A169),
              duration: Duration(seconds: 2),
            ),
          );
          Get.off(() => ExamDashboard());
        });
      } else {
        setState(() {
          _startSeconds--; // Decrement the time
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  // Format seconds into minutes:seconds
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override // @override
  Widget build(BuildContext context) {
    return Text(
      // return Text(
      _formatTime(_startSeconds), // formattedTime,
      style: widget.textStyle,
    );
  }
}
