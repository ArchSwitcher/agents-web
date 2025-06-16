import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/models/dropdown_option_model.dart';
import 'package:agents_app/views/clients/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageClientController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final urlController = TextEditingController(text: "");
  final ClientService _clientService = ClientService();

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

  fetchClients() async {
    isLoading.value = true;
    final loader = Get.find<LoaderController>();
    loader.show();
    try {
      final data = await _clientService.getAll();
      clients.value = data;
    } catch (e) {
      print("Error fetching clients: $e");
    } finally {
      isLoading.value = false;
      loader.hide();
    }
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

  // Add any additional methods or properties needed for managing clients
}
