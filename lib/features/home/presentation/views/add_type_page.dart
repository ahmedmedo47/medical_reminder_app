import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/presentation/views/medicine_strength_page.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_buttom.dart';

class AddMedicineTypePage extends StatefulWidget {
  final Medication medication;

  const AddMedicineTypePage({required this.medication, super.key});

  @override
  State<AddMedicineTypePage> createState() => _AddMedicineTypePageState();
}

class _AddMedicineTypePageState extends State<AddMedicineTypePage> {
  String? selectedType;

  final List<String> medicineTypes = [
    'Pill',
    'Solution',
    'Injection',
    'Powder',
    'Drops',
    'Inhaler',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 36,
          ),
        ),
        title: Text(
          widget.medication.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What kind of medicine is it?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: medicineTypes.length,
                itemBuilder: (context, index) {
                  final type = medicineTypes[index];
                  final isSelected = selectedType == type;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = type;
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
                            type,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontFamily: 'Roboto',
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
            if (selectedType != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CustomButtom(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected Type: $selectedType')),
                      );
                      final updatedMedication = Medication(
                        name: widget.medication.name,
                        dosage: widget.medication.dosage,
                        time: widget.medication.time,
                        id: widget.medication.id,
                        frequency: widget.medication.frequency,
                        startDate: widget.medication.startDate,
                        isCompleted: widget.medication.isCompleted,
                        type: selectedType!, // Add this line
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicineStrengthPage(
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
