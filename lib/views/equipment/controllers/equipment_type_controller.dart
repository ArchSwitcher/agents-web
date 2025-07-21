import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/equipment/equipment_asigment_model.dart';
// import 'package:agents_app/views/equipment/services/equipment_assigment_service.dart';
import 'package:agents_app/views/equipment/services/equipment_type_service.dart';
import 'package:get/get.dart';

class EquipmentTypeController extends GetxController {
  // final equipmentAssignmentService = EquipmentAssigmentService();

  RxList<EquipmentAssignmentModel> equipmentList =
      <EquipmentAssignmentModel>[].obs;
  RxList<DropDownOption> equipmentTypes = <DropDownOption>[].obs;
  Rx<DropDownOption> equipmentType = DropDownOption(
    id: '',
    label: '',
  ).obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingTypes = false.obs;
  final equipmentTypeService = EquipmentTypeService();

  Future<void> fetchEquipmentTypesDropDown() async {
    try {
      isLoadingTypes.value = true;
      final List<EquipmentTypeModel> data =
          await equipmentTypeService.getAll(null);

      equipmentTypes.value = data
          .map((type) => DropDownOption(
                id: type.id.toString(),
                label: type.name,
              ))
          .toList();
      print("objects: equipmentTypes ---- ${equipmentTypes.toString()}");
    } catch (e) {
      print("Error fetching equipment types: $e");
    } finally {
      isLoadingTypes.value = false;
    }
  }




}
