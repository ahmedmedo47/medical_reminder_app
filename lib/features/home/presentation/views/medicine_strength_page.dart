import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:medical_reminder_app/features/home/presentation/views/medication_purpose_page.dart';
import 'package:medical_reminder_app/features/home/presentation/widgets/custom_buttom.dart';

class MedicineStrengthPage extends StatefulWidget {
  final Medication medication;

  const MedicineStrengthPage({super.key, required this.medication});

  @override
  State<MedicineStrengthPage> createState() => _MedicineStrengthPageState();
}

class _MedicineStrengthPageState extends State<MedicineStrengthPage> {
  final TextEditingController _strengthController = TextEditingController();
  String? selectedUnit;
  final List<String> strengthUnits = ['g', 'mcg', 'mg', 'ml', 'IU'];

  @override
  void dispose() {
    _strengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.medication.name,
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
      body: SingleChildScrollView(
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
              'What strength is the medicine?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _strengthController,
              decoration: InputDecoration(
                hintText: 'Enter the amount',
                hintStyle: const TextStyle(color: Colors.white70),
                labelStyle: const TextStyle(color: Colors.white),
                border: borderShape(),
                enabledBorder: borderShape(),
                focusedBorder: borderShape(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(
                    () {}); 
              },
            ),
            SizedBox(height: 20.h),
            _buildUnitOptions(),
            SizedBox(height: 40.h),
            if (_strengthController.text.isNotEmpty && selectedUnit != null)
              _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitOptions() {
    return Column(
      children: strengthUnits.map((unit) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedUnit = unit;
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
                    color: selectedUnit == unit
                        ? const Color(0xFF24CCCC)
                        : Colors.transparent,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  unit,
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
      }).toList(),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
        child: CustomButtom(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Strength: ${_strengthController.text} $selectedUnit'),
              ),
            );

            final updatedMedication = Medication(
              name: widget.medication.name,
              dosage: '${_strengthController.text} $selectedUnit',
              time: widget.medication.time,
              id: widget.medication.id,
              frequency: widget.medication.frequency,
              startDate: widget.medication.startDate,
              isCompleted: widget.medication.isCompleted,
              type: widget.medication.type,
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MedicationPurposePage(
                  medication: updatedMedication,
                ),
              ),
            );
          },
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
