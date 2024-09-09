import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';

abstract class MedicationRepository {
  Future<int> addMedication(Medication medication);
  Future<List<Medication>> getAllMedications();
  Future<int> updateMedication(Medication medication);
  Future<int> deleteMedication(String id);
  Future<void> close();
}
