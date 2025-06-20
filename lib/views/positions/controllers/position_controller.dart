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

  final Rx<DropDownOption> group = DropDownOption(id: '', label: 'Seleccione un grupo').obs;
  final Rx<DropDownOption> client = DropDownOption(id: '', label: 'Seleccione un cliente').obs;
  final Rx<DropDownOption> branch = DropDownOption(id: '', label: 'Seleccione una sucursal').obs;
  final Rx<DropDownOption> adviser = DropDownOption(id: '', label: 'Seleccione un asesor').obs;

  final RxList<DropDownOption> advisers = <DropDownOption>[].obs;

  final Rx<DropDownOption> serviceType =
      DropDownOption(id: '', label: 'Seleccione un tipo de servicio').obs;

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
}
