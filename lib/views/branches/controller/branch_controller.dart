import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchController extends GetxController {
  // Controllers for form fields
  final codeGpController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final urlController = TextEditingController(text: "");

  // Reactive variables
  RxBool isLoading = true.obs;
  RxList<BranchModel> branches = <BranchModel>[].obs;

  

  @override
  void onClose() {
    codeGpController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    urlController.dispose();
    super.onClose();
  }
}
