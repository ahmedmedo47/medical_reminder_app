import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;

  const CustomButtom({super.key, this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF24CCCC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(37),
        ),
      ),
      child: Text(
        text ?? 'Next',
        style: TextStyle(
          color: const Color(0xFF0C1320),
          fontSize: 25.sp,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
