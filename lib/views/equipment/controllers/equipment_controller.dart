import 'package:agents_app/models/equipment/equipment_asigment_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/equipment/services/equipment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EquipmentController extends GetxController {
  final equipmentService = EquipmentService();

  RxList<EquipmentModel> equipments = <EquipmentModel>[].obs;
  TextEditingController quantityController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> fetchEquipments() async {
    try {
      isLoading.value = true;
      final List<EquipmentModel> data = await equipmentService.getAll(null);

      equipments.value = data;
    } catch (e) {
      print("Error fetching equipment assignments: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createEquipment(EquipmentModel data) async {
    final result = await equipmentService.create(data);
    if (result) {
      ToastService.success(
          title: "Inventario", subTitle: "Equipo creado correctamente");
      return true;
    } else {
      ToastService.warning(
          title: "Error", subTitle: "No se pudo crear el equipo");
      return false;
    }
  }
}
