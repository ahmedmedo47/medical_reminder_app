import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/data/repo/medication_repository_impl.dart';

class EditMedication extends StatefulWidget {
  final Medication medication;

  const EditMedication({super.key, required this.medication});

  @override
  State<EditMedication> createState() => _EditMedicationState();
}

class _EditMedicationState extends State<EditMedication> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _time;
  late String _dosage;

  @override
  void initState() {
    super.initState();
    // Initialize the form fields with the current medication details
    _name = widget.medication.name;
    _time = widget.medication.time;
    _dosage = widget.medication.dosage;
  }

  Future<void> _updateMedication() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Create a new Medication object with updated details
      final updatedMedication = Medication(
        id: widget.medication.id, // Ensure this is a String as per your model
        name: _name,
        time: _time,
        dosage: _dosage,
        isCompleted: widget.medication.isCompleted,
        startDate: widget.medication.startDate,
        frequency: widget.medication.frequency,
        type: widget.medication.type,
        days: widget.medication.days,
      );

      // Call the repository method to update the medication in the database
      await MedicationRepositoryImpl().updateMedication(updatedMedication);

      // Navigate back to the previous screen with a success indicator
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 36),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Medication',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        backgroundColor: const Color(0xFF0C1320),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.teal,
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                cursorColor: Colors.teal,
                initialValue: _time,
                decoration: const InputDecoration(labelText: 'Time'),
                onSaved: (value) => _time = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a time';
                  }
                  return null;
                },
              ),
              TextFormField(
                cursorColor: Colors.teal,
                initialValue: _dosage,
                decoration: const InputDecoration(labelText: 'Dosage'),
                onSaved: (value) => _dosage = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a dosage';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: _updateMedication,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C1320),
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
