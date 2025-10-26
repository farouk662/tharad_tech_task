import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tharad_flutter_task/core/themes/app_colors.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';

class CountdownText extends StatefulWidget {
  final int initialSeconds;

  const CountdownText({super.key, this.initialSeconds = 59});

  @override
  State<CountdownText> createState() => _CountdownTextState();
}

class _CountdownTextState extends State<CountdownText> {
  late int _secondsRemaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$minutes:$seconds',
              style: AppTextStyles.subText.copyWith(color: AppColors.textSecondary),
            ),
            const WidgetSpan(child: SizedBox(width: 2)),
            TextSpan(
              text: 'Sec',
              style: AppTextStyles.subText.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
