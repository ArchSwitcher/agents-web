import 'package:agents_app/models/dropdown_option_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageClientController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final urlController = TextEditingController();

  RxBool isLoading = true.obs;

  Rx<DropDownOption> groupId = DropDownOption(id: '', label: 'Seleccione un grupo').obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    urlController.dispose();
    super.onClose();
  }

  // Add any additional methods or properties needed for managing clients
}