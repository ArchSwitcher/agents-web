import 'package:agents_app/models/equipment/equipment_asigment_model.dart';
import 'package:agents_app/views/equipment/services/equipment_assigment.dart';
import 'package:get/get.dart';

class EquipmentAsigmentController extends GetxController {
  final equipmentAssignmentService = EquipmentAssigmentService();

  RxList<EquipmentAssignmentModel> equipmentList = <EquipmentAssignmentModel>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchEquipmentAssignments(String employeeId) async {
    try {
      isLoading.value = true;
      // final data = await equipmentAssignmentService.getAll({"employeeId": employeeId});

      final List<EquipmentAssignmentModel> data =
          await equipmentAssignmentService.getAll({"employeeId": employeeId});
      print("objects: data ---- ${data.toString()}");
      equipmentList.value = data;
    } catch (e) {
      print("Error fetching equipment assignments: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
