import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showEquipmentModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  bool? isEnabled,
  required PositionController controller,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      showAcceptButton: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadingAutocompleteDropdown(
                      prefixIcon: Icons.shield_moon,
                      isLoading: controller
                          .genericListController.isLoadingEquipmentType,
                      listItems:
                          controller.genericListController.equipmentTypes,
                      onSelected: (option) {
                        controller.equipmentType.value = option;
                      },
                      label: "Equipo",
                      hintText: "Seleccione un equipo",
                      resetValue: controller.equipmentType,
                      width: 200,
                      enabled: true,
                      onTextChange: (text) async {
                        List<DropDownOption> filteredOptions = controller
                            .genericListController.equipmentTypes
                            .where((option) => option.label
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                            .toList();
                        return filteredOptions.isEmpty ? [] : filteredOptions;
                      },
                    ),
                    const SizedBox(width: 30),
                    SizedBox(
                        width: 150,
                        child: CustomInputWidget(
                            controller: controller.equipmentQuantity,
                            label: "Cantidad",
                            hintText: "Cantidad",
                            prefixIcon: Icons.numbers)),
                    const SizedBox(width: 30),
                    controller.equipmentType.value.id.isNotEmpty && isEnabled == true
                        ? IconButton(
                            onPressed: () {
                              controller.addEquipment(
                                  controller.equipmentType.value,
                                  controller.equipmentQuantity.text);
                            },
                            icon: Icon(Icons.add_moderator,
                                color: Theme.of(context).colorScheme.primary))
                        : const SizedBox(
                            width: 50,
                            height: 2,
                          ),
                  ],
                );
              })),
          const Divider(
            thickness: 5,
            height: 50,
            color: Color.fromARGB(163, 224, 224, 224),
            indent: 20,
            endIndent: 20,
          ),
          EquipmentTableWidget(controller: controller),
        ],
      ),
      onAccept: onAccept,
      onCancel: onCancel,
      title: "Gestión del equipo.",
      subtitle: "puede agregar o quitar equipos de trabajo en la posición.",
      acceptText: "Aceptar",
      cancelText: "Cerrar",
    ),
  );
}

class EquipmentTableWidget extends StatelessWidget {
  final PositionController controller;
  const EquipmentTableWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    String getEquipmentTypeName(int equipmentTypeId) {
      final equipmentType = controller.genericListController.equipmentTypes
          .firstWhere((e) => e.id == equipmentTypeId.toString(),
              orElse: () => DropDownOption(id: '', label: 'Desconocido'));
      return equipmentType.label;
    }

    return Obx(() {
      if (controller.equipmentList.isEmpty) {
        return const Text("No hay equipos agregados.");
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 600, // o el mínimo ancho que desees
          child: DataTable(
            columnSpacing: 24,
            columns: const [
              DataColumn(label: Text("")),
              DataColumn(label: Text("Equipo")),
              DataColumn(label: Text("Cantidad")),
            ],
            rows: List.generate(
              controller.equipmentList.length,
              (index) {
                final element = controller.equipmentList[index];
                return DataRow(
                  cells: [
                    DataCell(IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.deleteEquipment(index);
                      },
                    )),
                    DataCell(Text(
                      getEquipmentTypeName(element.equipmentTypeId),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text(element.quantity.toString())),
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
