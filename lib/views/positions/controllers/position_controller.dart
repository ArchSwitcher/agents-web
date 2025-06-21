import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/position/equipment_model.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/employee_dropdown_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/views/positions/services/position_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PositionController extends GetxController {
  final GenericListController genericListController =
      Get.put(GenericListController());

  RxBool isLoadingEmployee = true.obs;
  final EmployeeDropdownService employeeDropdownService =
      Get.put(EmployeeDropdownService());

  final ManageGroupController groupController =
      Get.put(ManageGroupController());

  final positionServices = PositionServices();

  final RxBool isLoadingPosition = true.obs;
  final RxBool isLoadingPositions = true.obs;

  final Rx<DropDownOption> group =
      DropDownOption(id: '', label: 'Seleccione un grupo').obs;
  final Rx<DropDownOption> client =
      DropDownOption(id: '', label: 'Seleccione un cliente').obs;
  final Rx<DropDownOption> branch =
      DropDownOption(id: '', label: 'Seleccione una sucursal').obs;
  final Rx<DropDownOption> adviser =
      DropDownOption(id: '', label: 'Seleccione un asesor').obs;
  final Rx<DropDownOption> company =
      DropDownOption(id: '', label: 'Seleccione una sucursal').obs;
  final Rx<DropDownOption> agency =
      DropDownOption(id: '', label: 'Seleccione un asesor').obs;

  final RxList<DropDownOption> advisers = <DropDownOption>[].obs;

  final Rx<DropDownOption> serviceType =
      DropDownOption(id: '', label: 'Seleccione un tipo de servicio').obs;

// Equipment related fields
  final Rx<DropDownOption> equipmentType =
      DropDownOption(id: '', label: 'Seleccione un tipo de equipo').obs;
  final TextEditingController equipmentQuantity = TextEditingController();

  // Shift related fields

  final Rx<DropDownOption> shiftTime =
      DropDownOption(id: '', label: 'Seleccione un turno').obs;

  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  final TextEditingController serviceQuantity = TextEditingController();
  final TextEditingController serviceAgent = TextEditingController();
  final TextEditingController scheduleQuantity = TextEditingController();

  final TextEditingController bonus = TextEditingController();
  final TextEditingController transport = TextEditingController();
  final TextEditingController foodQuantity = TextEditingController();
  final TextEditingController shiftValue = TextEditingController();
  final TextEditingController minimumPrice = TextEditingController();
  final TextEditingController servicePrice = TextEditingController();

  Rx<DropDownOption> department =
      DropDownOption(id: '', label: 'Seleccione una departamento').obs;
  TextEditingController subCity = TextEditingController();
  Rx<DropDownOption> zone =
      DropDownOption(id: '', label: 'Seleccione una zona').obs;
  TextEditingController address = TextEditingController();
  TextEditingController observations = TextEditingController();

  final RxList<EquipmentModel> equipmentList = <EquipmentModel>[].obs;

  void clearFields() {
    startTime.clear();
    endTime.clear();
    startDate.clear();
    endDate.clear();
    serviceQuantity.clear();
    serviceAgent.clear();
    scheduleQuantity.clear();
    bonus.clear();
    transport.clear();
    foodQuantity.clear();
    shiftValue.clear();
    minimumPrice.clear();
    servicePrice.clear();
    subCity.clear();
    address.clear();
    observations.clear();
    equipmentList.clear();
  }

  final weekDays = <WeekDay>[
    WeekDay(
      name: "Lunes",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      name: "Martes",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      name: "Miércoles",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      name: "Jueves",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      name: "Viernes",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      name: "Sábado",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      name: "Domingo",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
  ].obs;

  void toggleWeekDay(WeekDay day) {
    day.isSelected.value = !day.isSelected.value;

    if (!day.isSelected.value) {
      day.startTimeController.text = "00:00";
      day.endTimeController.text = "00:00";
    }
  }

  List<Map<String, String>> getSelectedDays() {
    return weekDays
        .where((day) => day.isSelected.value)
        .map((day) => {
              "day": day.name,
              "startTime": day.startTimeController.text,
              "endTime": day.endTimeController.text,
            })
        .toList();
  }

  addEquipment(DropDownOption equipment, String quantity) {
    if (equipment.id.isEmpty || quantity.isEmpty) {
      ToastService.warning(
          title: "Advertencia",
          subTitle: "Por favor, complete todos los campos.");
      return;
    }
    ToastService.success(
        title: "Equipo", subTitle: "Equipo agregado correctamente.");

    equipmentList.add(EquipmentModel(
        quantity: int.parse(quantity),
        cost: 0,
        currency: "GTQ",
        equipmentTypeId: int.parse(equipment.id)));

    equipmentType.value =
        DropDownOption(id: '', label: 'Seleccione un tipo de equipo');
    equipmentQuantity.clear();
  }

  deleteEquipment(int index) {
    if (index < 0 || index >= equipmentList.length) {
      ToastService.warning(
          title: "Advertencia", subTitle: "Índice de equipo no válido.");
      return;
    }
    equipmentList.removeAt(index);
    ToastService.success(
        title: "Equipo", subTitle: "Equipo eliminado correctamente.");
  }

  fetchPositions() async {
    isLoadingPositions.value = true;
    try {
      await positionServices.getAll();
    } catch (e) {
      ToastService.error(
        title: "Posiciones",
        subTitle: "Error al cargar posiciones: $e",
      );
    } finally {
      isLoadingPositions.value = false;
    }
  }

  Future<bool> newUpdatePosition(String? idPosition) async {
    try {
      isLoadingPosition.value = true;
      final positionData = {
        "id": idPosition, 
        "groupId": group.value.id,
        "clientId": client.value.id,
        "branchId": branch.value.id,
        "adviserId": adviser.value.id,
        "companyId": company.value.id,
        "agencyId": agency.value.id,
        "serviceTypeId": serviceType.value.id,
        "shiftTimeId": shiftTime.value.id,
        "startTime": startTime.text,
        "endTime": endTime.text,
        "startDate": startDate.text,
        "endDate": endDate.text,
        "serviceQuantity": serviceQuantity.text,
        "serviceAgent": serviceAgent.text,
        "scheduleQuantity": scheduleQuantity.text,
        "bonus": bonus.text,
        "transport": transport.text,
        "foodQuantity": foodQuantity.text,
        "shiftValue": shiftValue.text,
        "minimumPrice": minimumPrice.text,
        "servicePrice": servicePrice.text,
        "departmentId": department.value.id,
        "subCity": subCity.text,
        "zoneId": zone.value.id,
        "address": address.text,
        "observations": observations.text,
      };

      final selectedDays = getSelectedDays();
      if (selectedDays.isEmpty) {
        ToastService.warning(
            title: 'Advertencia', subTitle: 'Seleccione al menos un día.');
        return false;
      }

      PositionModel positionDataData = PositionModel.fromJson(positionData);

      final position = await positionServices.create(positionDataData);

      if (position) {
        ToastService.success(
            title: 'Éxito', subTitle: 'Posición creada correctamente.');
      } else {
        ToastService.error(
            title: 'Error', subTitle: 'No se pudo crear la posición.');
      }
      return position;
    } catch (e) {
      ToastService.error(
          title: 'Error', subTitle: 'Error al crear la posición: $e');
      return false;
    } finally {
      isLoadingPosition.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPositions();
  }
}

class WeekDay {
  final String name;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final RxBool isSelected;

  WeekDay({
    required this.name,
    required this.startTimeController,
    required this.endTimeController,
    required this.isSelected,
  });
}
