import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_buttom.dart';
import 'package:medical_reminder_app/features/home/presentation/views/medication_days_page.dart';

class MedicationFrequencyPage extends StatefulWidget {
  final Medication medication;
  final String strength;

  const MedicationFrequencyPage({
    super.key,
    required this.medication,
    required this.strength,
  });

  @override
  State<MedicationFrequencyPage> createState() => _MedicationFrequencyPageState();
}

class _MedicationFrequencyPageState extends State<MedicationFrequencyPage> {
  String? selectedFrequency;
  final List<String> frequencies = [
    'Daily',
    'Once a week',
    '2 days a week',
    '3 days a week',
    '4 days a week',
    '5 days a week',
    '6 days a week',
    'Once a month',
    'Alternate days',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          '${widget.medication.name}, ${ widget.medication.dosage}',
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
            const Text(
              'How often do you take this medicine?',
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
                itemCount: frequencies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFrequency = frequencies[index];
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
                              color: selectedFrequency == frequencies[index]
                                  ? const Color(0xFF24CCCC)
                                  : Colors.transparent,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            frequencies[index],
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
            if (selectedFrequency != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: CustomButtom(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected Frequency: $selectedFrequency'),
                        ),
                      );

                      final updatedMedication = Medication(
                        name: widget.medication.name,
                        dosage: widget.medication.dosage,
                        time: widget.medication.time,
                        id: widget.medication.id,
                        frequency: selectedFrequency!,
                        startDate: widget.medication.startDate,
                        isCompleted: widget.medication.isCompleted,
                        type: widget.medication.type,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
    builder: (context) => MedicationDaysPage(
                            medication: updatedMedication,
                          )
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
