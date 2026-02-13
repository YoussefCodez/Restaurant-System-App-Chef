import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFieldText extends StatelessWidget {
  const CustomFieldText({super.key, required this.text, this.color = Colors.black});
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(fontSize: 11.sp, color: color, fontWeight: .w100),
    );
  }
}