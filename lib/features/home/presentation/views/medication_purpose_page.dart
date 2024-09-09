import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/presentation/views/medication_frequency_page.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_buttom.dart';

class MedicationPurposePage extends StatefulWidget {
  final Medication medication;

  const MedicationPurposePage({super.key, required this.medication});

  @override
  State<MedicationPurposePage> createState() => _MedicationPurposePageState();
}

class _MedicationPurposePageState extends State<MedicationPurposePage> {
  final TextEditingController _purposeController = TextEditingController();
  bool isButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _purposeController.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      isButtonVisible = _purposeController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicationName = widget.medication.name;
    final dosage = widget.medication.dosage;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          '$medicationName, $dosage',
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
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 36),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'What is the purpose for taking this medication?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 68.h),
            TextFormField(
              cursorColor: const Color(0xFF62F3F3),
              controller: _purposeController,
              decoration: InputDecoration(
                hintText: 'Enter the purpose',
                hintStyle: const TextStyle(color: Colors.white70),
                border: borderShape(),
                enabledBorder: borderShape(),
                focusedBorder: borderShape(),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            if (isButtonVisible)
              Center(
                child: CustomButtom(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Purpose: ${_purposeController.text}'),
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
                      // purpose: _purposeController.text,
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicationFrequencyPage(
                                  medication: updatedMedication,
                                  strength: widget.medication.dosage,
                                )));
                  },
                ),
              ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder borderShape() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.r)),
      borderSide: const BorderSide(
        color: Color(0xFF62F3F3),
      ),
    );
  }
}
