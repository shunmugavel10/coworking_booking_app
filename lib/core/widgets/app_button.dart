import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool filled;

  const AppButton({super.key, required this.text, required this.onPressed, this.filled = true});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: filled
            ? ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14.h))
            : ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
        child: Text(text, style: style.textTheme.titleMedium),
      ),
    );
  }
}
