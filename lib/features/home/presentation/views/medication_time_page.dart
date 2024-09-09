import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/data/repo/medication_repository_impl.dart';
import 'package:medical_reminder_app/features/home/presentation/views/home_page.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_buttom.dart';

class MedicationTimePage extends StatefulWidget {
  final Medication medication;

  const MedicationTimePage({super.key, required this.medication});

  @override
  State<MedicationTimePage> createState() => _MedicationTimePageState();
}

class _MedicationTimePageState extends State<MedicationTimePage> {
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _saveMedication() async {
    final repository = MedicationRepositoryImpl();

    final updatedMedication = Medication(
      name: widget.medication.name,
      dosage: widget.medication.dosage,
      time: selectedTime?.format(context) ?? widget.medication.time,
      id: widget.medication.id,
      frequency: widget.medication.frequency,
      startDate: widget.medication.startDate,
      isCompleted: widget.medication.isCompleted,
      type: widget.medication.type,
      days: widget.medication.days,
    );

    await repository.addMedication(updatedMedication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          '${widget.medication.name}, ${widget.medication.dosage}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.5,
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
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Set Time',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: const Color(0xFF62F3F3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTime != null
                          ? selectedTime!.format(context)
                          : 'Select Time',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            if (selectedTime != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: CustomButtom(
                    text: 'Done',
                    onPressed: () async {
                      await _saveMedication();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
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
