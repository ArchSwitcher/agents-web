import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/address/address_model.dart';
import 'package:agents_app/models/billing/bill_model.dart';
import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/common/simple_entity_model.dart';
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

  Rx<DropDownOption> groupId = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> adviser = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> accountManager = DropDownOption(id: '', label: '').obs;

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
  RxList<DropDownOption> fiscalMunicipalities = <DropDownOption>[].obs;
  RxList<DropDownOption> paymentMunicipalities = <DropDownOption>[].obs;
  RxBool isLoadingFiscalMunicipalities = true.obs;
  RxBool isLoadingPaymentMunicipalities = true.obs;


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

  newClient() async {
    try {
      ClientModel client = ClientModel(
          name: nameController.text,
          email: emailController.text,
          url: urlController.text,
          phone: phoneController.text,
          group: groupId.value.id.isNotEmpty
              ? SimpleEntity(id: groupId.value.id, name: groupId.value.label)
              : SimpleEntity(id: '', name: ''),
          admin: SimpleEntity(
              id: '1', name: "Admin"), // should be chosen from dropdown
          billing: Billing(
              billingType: billingType.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: billingType.value.id, name: billingType.value.label)
                  : SimpleEntity(id: '', name: ''),
              generationType: generationType.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: generationType.value.id,
                      name: generationType.value.label)
                  : SimpleEntity(id: '', name: ''),
              billCollectorId: billPerson.value.id),
          fiscalAddress: Address(
              country: fiscalCountry.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: fiscalCountry.value.id,
                      name: fiscalCountry.value.label)
                  : SimpleEntity(id: '', name: ''),
              department: fiscalDepartment.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: fiscalDepartment.value.id,
                      name: fiscalDepartment.value.label)
                  : SimpleEntity(id: '', name: ''),
              municipality: fiscalMunicipality.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: fiscalMunicipality.value.id,
                      name: fiscalMunicipality.value.label)
                  : SimpleEntity(id: '', name: ''),
              zone: fiscalZone.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: fiscalZone.value.id, name: fiscalZone.value.label)
                  : SimpleEntity(id: '', name: ''),
              address: fiscalAddress.text),
          paymentAddress: Address(
              country: paymentCountry.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: paymentCountry.value.id,
                      name: paymentCountry.value.label)
                  : SimpleEntity(id: '', name: ''),
              department: paymentDepartment.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: paymentDepartment.value.id,
                      name: paymentDepartment.value.label)
                  : SimpleEntity(id: '', name: ''),
              municipality: paymentMunicipality.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: paymentMunicipality.value.id,
                      name: paymentMunicipality.value.label)
                  : null,
              zone: paymentZone.value.id.isNotEmpty
                  ? SimpleEntity(
                      id: paymentZone.value.id, name: paymentZone.value.label)
                  : SimpleEntity(id: '', name: ''),
              address: paymentAddress.text),
          adviser: Employee(id: adviser.value.id, name: adviser.value.label, contact: "",),
          accountManager: Employee(
              id: accountManager.value.id.isEmpty ? null : accountManager.value.id, name: accountManager.value.label, contact: ""));

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

  Rx<DropDownOption> fiscalCountry = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> fiscalDepartment = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> fiscalMunicipality = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> fiscalZone = DropDownOption(id: '', label: '').obs;
  final TextEditingController fiscalAddress = TextEditingController();

  Rx<DropDownOption> paymentCountry = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> paymentDepartment = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> paymentMunicipality =
      DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> paymentZone = DropDownOption(id: '', label: '').obs;
  final TextEditingController paymentAddress = TextEditingController();

//bill info
  Rx<DropDownOption> billPerson = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> billingType = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> generationType = DropDownOption(id: '', label: '').obs;
}
