import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/presentation/views/medicationtimeofdaypage.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_buttom.dart';

class MedicationDaysPage extends StatefulWidget {
  final Medication medication;

  const MedicationDaysPage({
    super.key,
    required this.medication,
  });

  @override
  State<MedicationDaysPage> createState() => _MedicationDaysPageState();
}

class _MedicationDaysPageState extends State<MedicationDaysPage> {
  List<String> selectedDays = [];
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          '${widget.medication.name} ,${widget.medication.dosage}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              'Choose the days you need to take the med',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: daysOfWeek.length,
                itemBuilder: (context, index) {
                  final day = daysOfWeek[index];
                  final isSelected = selectedDays.contains(day);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedDays.remove(day);
                        } else {
                          selectedDays.add(day);
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF24CCCC),
                                width: 2.0.w,
                              ),
                              color: isSelected
                                  ? const Color(0xFF24CCCC)
                                  : Colors.transparent,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            day,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            if (selectedDays.isNotEmpty)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: CustomButtom(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Selected Days: ${selectedDays.join(', ')}'),
                        ),
                      );

                      final updatedMedication = Medication(
                        name: widget.medication.name,
                        dosage: widget.medication.dosage,
                        time: widget.medication.time,
                        id: widget.medication.id,
                        frequency: widget.medication.frequency,
                        startDate: widget.medication.startDate,
                        isCompleted: widget.medication.isCompleted,
                        type: widget.medication.type,
                        // days:
                        //     selectedDays,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicationTimeOfDayPage(
                            medication: updatedMedication,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
