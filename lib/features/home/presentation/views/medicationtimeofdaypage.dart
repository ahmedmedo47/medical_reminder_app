import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/presentation/views/medication_time_page.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_buttom.dart';

class MedicationTimeOfDayPage extends StatefulWidget {
  final Medication medication;

  const MedicationTimeOfDayPage({
    super.key,
    required this.medication,
  });

  @override
  State<MedicationTimeOfDayPage> createState() =>
      _MedicationTimeOfDayPageState();
}

class _MedicationTimeOfDayPageState extends State<MedicationTimeOfDayPage> {
  String? selectedTimeOfDay;
  String? selectedFoodRelation;
  final List<String> timeOfDayOptions = [
    'Morning',
    'Afternoon',
    'Evening',
    'Night',
  ];
  final List<String> foodRelationOptions = [
    'Before Food',
    'After Food',
    'Anytime',
  ];

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
            const Text(
              'At what time do you take your first dose?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView(
                children: [
                  ...timeOfDayOptions.map((option) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTimeOfDay = option;
                          });
                        },
                        child: _buildOptionRow(option, selectedTimeOfDay),
                      )),
                  SizedBox(height: 20.h),
                  const Text(
                    'Relation to Food:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ...foodRelationOptions.map((option) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFoodRelation = option;
                          });
                        },
                        child: _buildOptionRow(option, selectedFoodRelation),
                      )),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            if (selectedTimeOfDay != null && selectedFoodRelation != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: CustomButtom(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Selected Time: $selectedTimeOfDay\nFood Relation: $selectedFoodRelation',
                          ),
                        ),
                      );

                      final updatedMedication = Medication(
                        name: widget.medication.name,
                        dosage: widget.medication.dosage,
                        time:
                            '${selectedTimeOfDay!} - ${selectedFoodRelation!}',
                        id: widget.medication.id,
                        frequency: widget.medication.frequency,
                        startDate: widget.medication.startDate,
                        isCompleted: widget.medication.isCompleted,
                        type: widget.medication.type,
                        days: widget.medication.days,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicationTimePage(
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

  Widget _buildOptionRow(String option, String? selectedOption) {
    return Container(
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
              color: selectedOption == option
                  ? const Color(0xFF24CCCC)
                  : Colors.transparent,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            option,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
