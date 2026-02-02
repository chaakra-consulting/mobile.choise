import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // import 'package:intl/intl.dart';

class ClockWidget extends StatelessWidget {
  // class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key, required this.textStyle});
  final TextStyle textStyle;
  @override // @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        final String formattedTime = DateFormat(
          'hh:mm:ss',
        ).format(DateTime.now());
        return Text(
          // return Text(
          formattedTime, // formattedTime,
          style: textStyle,
        );
      },
    );
  }
}
