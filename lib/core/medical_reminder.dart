import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_reminder_app/features/home/presentation/views/home_page.dart';

class MedicalReminder extends StatelessWidget {
  const MedicalReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => child!,
      child: GetMaterialApp(
        theme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
            scaffoldBackgroundColor: const Color(0xFF0C1320),
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: const Color(0xFF0C1320),
                  secondary: const Color(0xFF0C1320),
                )),
        title: 'Medical Reminder App',
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
