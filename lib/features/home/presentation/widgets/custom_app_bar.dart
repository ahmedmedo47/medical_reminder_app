import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_reminder_app/core/utils/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppImages.imagesDocument,
          ),
        ),
        const Spacer(),
        Container(
          alignment: Alignment.center,
          width: 108.w,
          height: 24.h,
          decoration: ShapeDecoration(
            color: const Color(0xFF24CCCC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.08.r),
            ),
          ),
          child: Text(
            'BOOK  APPOINTMENT',
            style: TextStyle(
              color: const Color(0xFF0C1320),
              fontSize: 10.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.0.h,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppImages.imagesVolumeDown,
          ),
        ),
      ],
    );
  }
}
