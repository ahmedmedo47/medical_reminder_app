import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/presentation/views/add_type_page.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_buttom.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        title: const Text(
          'What medicine do you want\nto add?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 1.0, // Changed to 1.0 for better vertical alignment
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 49.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the medicine name';
                  }
                  return null;
                },
                cursorColor: const Color(0xFF62F3F3),
                decoration: InputDecoration(
                  hintText: 'What medicine do you want to add?',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Colors.white70, // Added color for better readability
                  ),
                  focusedBorder: _borderShape(),
                  enabledBorder: _borderShape(),
                  border: _borderShape(),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Type and choose your med from the list',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF62F3F3),
                  fontSize: 14.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              CustomButtom(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    log('Proceed to next step with: ${_nameController.text}');

                    final Medication medication = Medication(
                      id: DateTime.now().toString(),
                      name: _nameController.text,
                      time: '',
                      dosage: '',
                      frequency: '',
                      startDate: DateTime.now(), 
                      isCompleted: false,
                      type: '',
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMedicineTypePage(
                          medication: medication,
                        ),
                      ),
                    );
                  } else {
                    log('Validation failed');
                  }
                },
              ),
              SizedBox(height: 115.h),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _borderShape() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      borderSide: BorderSide(
        color: Color(0xFF62F3F3),
      ),
    );
  }
}
