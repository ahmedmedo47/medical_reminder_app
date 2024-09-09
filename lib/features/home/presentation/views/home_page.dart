import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_reminder_app/core/utils/app_images.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/data/repo/medication_repository_impl.dart';
import 'package:medical_reminder_app/features/home/presentation/views/add_medicine.dart';
import 'package:medical_reminder_app/features/home/presentation/views/edit_medication.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late Future<List<Medication>> _medicationsFuture;

  @override
  void initState() {
    super.initState();
    _medicationsFuture = MedicationRepositoryImpl().getAllMedications();
    log('initState called');
    log(_medicationsFuture.toString());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to show the custom medication dialog
  void _showMedicationDialog(BuildContext context, Medication medication) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF24CCCC), // Dialog color
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      medication.time,
                      style: TextStyle(
                        color: const Color(0xFF0C1320),
                        fontSize: 30.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await MedicationRepositoryImpl()
                            .deleteMedication(medication.id);
                        Navigator.of(context).pop();
                        setState(() {
                          _medicationsFuture =
                              MedicationRepositoryImpl().getAllMedications();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Text(
                    medication.name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0C1320),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Time: ${medication.time}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0C1320),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${medication.dosage} Pill(s)',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0C1320),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF0C1320),
                      ),
                      onPressed: () async {
                        await MedicationRepositoryImpl()
                            .deleteMedication(medication.id);
                        Navigator.of(context).pop();
                        setState(() {
                          _medicationsFuture =
                              MedicationRepositoryImpl().getAllMedications();
                        });
                      },
                      child: const Text('Take'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF0C1320), // Text color
                      ),
                        onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditMedication(medication: medication),
                          ),
                        ).then((success) {
                          if (success != null && success) {
                            setState(() {
                              _medicationsFuture = MedicationRepositoryImpl()
                                  .getAllMedications();
                            });
                          }
                        });
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          selectedLabelStyle: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          backgroundColor: const Color(0xFF0C1320),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.imagesHome,
                    colorFilter: _selectedIndex == 0
                        ? null
                        : const ColorFilter.mode(
                            Color(0xFF22CCCC), BlendMode.srcIn),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
              label: 'Home',
              backgroundColor: const Color(0xFF0C1320),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.imagesSearch,
                    colorFilter: _selectedIndex == 1
                        ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                        : null,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
              label: 'Search',
              backgroundColor: const Color(0xFF0C1320),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.imagesRectangle,
                    colorFilter: _selectedIndex == 2
                        ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                        : null,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
              label: 'MEDICATIONS',
              backgroundColor: const Color(0xFF0C1320),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.imagesProfile,
                    colorFilter: _selectedIndex == 3
                        ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                        : null,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
              label: 'Profile',
              backgroundColor: const Color(0xFF0C1320),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 14.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              SizedBox(height: 24.h),
              Expanded(
                child: FutureBuilder<List<Medication>>(
                  future: _medicationsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No medications found.'));
                    } else {
                      final medications = snapshot.data!;
                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: SizedBox(
                                      height: 16.0.h,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'Good Morning \n',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.07,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: SizedBox(
                                      height: 45.0.h,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'Gracy',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(height: 24.h),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final medication = medications[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 16.0.h,
                                      left: 8.0.w,
                                      right: 8.0.w),
                                  child: GestureDetector(
                                    onTap: () => _showMedicationDialog(
                                        context, medication),
                                    child: CustomContain(
                                      medication: medication,
                                    ),
                                  ),
                                );
                              },
                              childCount: medications.length,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppImages.imagesCalendar,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Add Medication',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddMedicine(),
                        ),
                      );
                    },
                    icon: SvgPicture.asset(
                      AppImages.imagesPlus,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
