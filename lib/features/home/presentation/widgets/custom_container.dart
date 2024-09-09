import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';

class CustomContain extends StatelessWidget {
  final Medication medication;

  const CustomContain({
    super.key,
    required this.medication,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 376.w,
      height: 136.h,
      decoration: ShapeDecoration(
        color: const Color(0xFF0C1320),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x44000000),
            blurRadius: 4,
            offset: Offset(5, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0xff065353),
            blurRadius: 4,
            offset: Offset(-3, -2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.0.w, vertical: 24.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  medication.time, // Assuming `Medication` has a `time` field
                  style: const TextStyle(
                    color: Color(0xFF62F3F3),
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                )
              ],
            ),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(0.55),
                  child: Container(
                    width: 21.94,
                    height: 30.72,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication
                          .name, // Assuming `Medication` has a `name` field
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 4.0.h),
                    Row(
                      children: [
                        Text(
                          medication
                              .dosage, // Assuming `Medication` has `dosage` and `unit` fields
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        SizedBox(width: 16.0.w),
                        Text(
                          medication
                              .frequency, // Assuming `Medication` has an `instruction` field
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
