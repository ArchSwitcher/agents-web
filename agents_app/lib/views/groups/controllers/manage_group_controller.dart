import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ManageGroupController extends GetxController {
  final nameController = TextEditingController();
  String? id;

 void setData({required String value, required String? id}) {
    nameController.text = value;
    this.id = id;
  }

  String get name => nameController.text;

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}