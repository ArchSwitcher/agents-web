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
  required PositionController controller,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAutocompleteDropdown(
                isLoading:
                    controller.genericListController.isLoadingEquipmentType,
                listItems: controller.genericListController.equipmentTypes,
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
              Obx(() {
                return controller.equipmentType.value.id.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          // controller.genericListController.addEquipment(
                          //     controller.equipmentType.value,
                          //     controller.equipmentQuantity.text);
                        },
                        icon: Icon(Icons.add_moderator,
                            color: Theme.of(context).colorScheme.primary))
                    : const SizedBox.shrink();
              })
            ],
          ),
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
