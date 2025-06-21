import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/employee_dropdown_service.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
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

  final RxBool isLoadingPosition = true.obs;

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
      day.startTimeController.clear();
      day.endTimeController.clear();
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
