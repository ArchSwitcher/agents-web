import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/employee_dropdown_service.dart';
import 'package:agents_app/shared/constants/database_constants.dart';
import 'package:agents_app/views/clients/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageClientController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final urlController = TextEditingController(text: "");
  final ClientService _clientService = ClientService();

  final GenericListController genericListController =
      Get.put(GenericListController());

  final EmployeeDropdownService employeeService =
      Get.put(EmployeeDropdownService());

  RxBool isLoading = true.obs;
  RxList<ClientModel> clients = <ClientModel>[].obs;

  Rx<DropDownOption> groupId =
      DropDownOption(id: '', label: 'Seleccione un grupo').obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    urlController.dispose();
    super.onClose();
  }

  //generate variables for dropdowns
  RxBool isLoadingAdviser = true.obs;
  RxBool isLoadingAccountBoss = true.obs;
  RxBool isLoadingBillPerson = true.obs;
  RxList<DropDownOption> advisers = <DropDownOption>[].obs;
  RxList<DropDownOption> accountBosses = <DropDownOption>[].obs;
  RxList<DropDownOption> billPersons = <DropDownOption>[].obs;

  fetchEmployees() async {
    isLoadingAdviser.value = true;
    advisers.value = await employeeService
        .fetchEmployees(EmployeeTypeDatabaseConstants.adviser);
    isLoadingAdviser.value = false;

    isLoadingAccountBoss.value = true;
    accountBosses.value = accountBosses.value = await employeeService
        .fetchEmployees(EmployeeTypeDatabaseConstants.accountManager);
    isLoadingAccountBoss.value = false;

    isLoadingBillPerson.value = true;
    billPersons.value = billPersons.value = await employeeService
        .fetchEmployees(EmployeeTypeDatabaseConstants.billMan);
    isLoadingBillPerson.value = false;
  }

  fetchClients() async {
    isLoading.value = true;
    final loader = Get.find<LoaderController>();
    loader.show();
    try {
      final data = await _clientService.getAll(null);
      clients.value = data;
    } catch (e) {
      print("Error fetching clients: $e");
    } finally {
      isLoading.value = false;
      loader.hide();
    }
  }

  List<DropDownOption> get dropdownOptions {
    return clients.map((client) {
      return DropDownOption(
        id: client.id.toString(),
        label: client.name,
      );
    }).toList();
  }

  newClient(ClientModel client) async {
    try {
      final success = await _clientService.create(client);
      if (success) {
        await fetchClients();
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo crear el cliente: $e");
    }
  }

  editClient(ClientModel client) async {
    try {
      final success = await _clientService.update(client.id.toString(), client);
      if (success) {
        await fetchClients();
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo editar el cliente: $e");
    }
  }

  deleteClient(String id) async {
    try {
      final success = await _clientService.delete(id);
      if (success) {
        await fetchClients();
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar el cliente: $e");
    }
  }

  setData(ClientModel client) {
    nameController.text = client.name;
    emailController.text = client.email;
    phoneController.text = client.phone;
    urlController.text = client.url;
    groupId.value =
        DropDownOption(id: client.group.id, label: client.group.name);
  }

  clear() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    urlController.clear();
    groupId.value = DropDownOption(id: '', label: '');
  }

  Rx<DropDownOption> fiscalCountry =
      DropDownOption(id: '', label: 'Seleccione un país fiscal').obs;
  Rx<DropDownOption> fiscalDepartment =
      DropDownOption(id: '', label: 'Seleccione un departamento fiscal').obs;
  Rx<DropDownOption> fiscalZone =
      DropDownOption(id: '', label: 'Seleccione una zona fiscal').obs;
  final TextEditingController fiscalAddress = TextEditingController();

  Rx<DropDownOption> paymentCountry =
      DropDownOption(id: '', label: 'Seleccione un país').obs;
  Rx<DropDownOption> paymentDepartment =
      DropDownOption(id: '', label: 'Seleccione un departamento').obs;
  Rx<DropDownOption> paymentZone =
      DropDownOption(id: '', label: 'Seleccione una zona').obs;
  final TextEditingController paymentAddress = TextEditingController();

//bill info
  Rx<DropDownOption> billPerson =
      DropDownOption(id: '', label: 'Seleccione una persona de facturación')
          .obs;
  Rx<DropDownOption> billingType =
      DropDownOption(id: '', label: 'Seleccione un tipo de facturación').obs;
  Rx<DropDownOption> generationType =
      DropDownOption(id: '', label: 'Seleccione un tipo de generación').obs;
}
