import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/employee_dropdown_service.dart';
import 'package:agents_app/views/branches/services/branch_service.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchController extends GetxController {
  final ManageGroupController groupController =
      Get.put(ManageGroupController());

  final ManageClientController clientController =
      Get.put(ManageClientController());

  final GenericListController genericListController =
      Get.put(GenericListController());

  final EmployeeDropdownService employeeDropdownService =
      Get.put(EmployeeDropdownService());

  final BranchService _branchService = BranchService();

  // Controllers for form fields
  final codeGpController = TextEditingController();
  final nameController = TextEditingController();
  final nitController = TextEditingController();
  final socialReasonController = TextEditingController();
  final urlController = TextEditingController(text: "");
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  Rx<DropDownOption> groupId =
      DropDownOption(id: '', label: 'Seleccione un grupo').obs;

  Rx<DropDownOption> client =
      DropDownOption(id: '', label: 'Seleccione un grupo').obs;

  RxList<DropDownOption> adviser = <DropDownOption>[].obs;

  RxList<DropDownOption> territoryManager = <DropDownOption>[].obs;

  RxList<DropDownOption> accountBoss = <DropDownOption>[].obs;

  RxList<DropDownOption> billPerson = <DropDownOption>[].obs;

  // Reactive variables
  RxBool isLoading = true.obs;
  RxList<BranchModel> branches = <BranchModel>[].obs;

  final RxBool isLoadingClients = true.obs;
  final RxBool isLoadingGroups = true.obs;

  Future<List<DropDownOption>> fetchClients() async {
    try {
      isLoadingClients.value = true;
      await clientController.fetchClients();
      isLoadingClients.value = false;
      return clientController.clients.map((client) {
        return DropDownOption(
          id: client.id.toString(),
          label: client.name,
        );
      }).toList();
    } catch (e) {
      print("Error fetching clients: $e");
      return [];
    } finally {
      isLoadingClients.value = false;
    }
  }

  Future<List<DropDownOption>> fetchGroups() async {
    try {
      isLoadingGroups.value = true;
      await groupController.fetchGroups();
      return groupController.groups.map((group) {
        return DropDownOption(
          id: group.id.toString(),
          label: group.name,
        );
      }).toList();
    } catch (e) {
      print("Error fetching groups: $e");
      return [];
    } finally {
      isLoadingGroups.value = false;
    }
  }

  Future<bool> deleteBranch(String id) async {
    try {
      final success = await _branchService.delete(id);
      if (success) {
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar la sucursal: $e");
      return false;
    }
  }

  @override
  void onClose() {
    codeGpController.dispose();
    nameController.dispose();
    nitController.dispose();
    socialReasonController.dispose();
    urlController.dispose();
    super.onClose();
  }
}
