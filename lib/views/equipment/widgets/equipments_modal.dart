import 'package:agents_app/mocks/personal_info_mocks.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/equipment/equipment_asigment_model.dart';
// import 'package:agents_app/models/position/equipment_model.dart';
// import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/views/equipment/controllers/equipment_controller.dart';
import 'package:agents_app/views/equipment/controllers/equipment_type_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_dropdownv2_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';

void showEquipmentsModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Añadir Inventario",
  bool isEdit = true,
  required EquipmentTypeController equipmentTypeController,
  required EquipmentController equipmentController,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: EquipmentsModal(
          equipmentTypeController: equipmentTypeController,
          equipmentController: equipmentController),
      onAccept: () async {
        EquipmentModel data = EquipmentModel(
            isAssigned: 0,
            quantity:
                int.tryParse(equipmentController.quantityController.text) ?? 0,
            cost:
                double.tryParse(equipmentController.costController.text) ?? 0.0,
            currency: equipmentController.currencyController.text,
            equipmentTypeId:
                int.parse(equipmentTypeController.equipmentType.value.id));

        await equipmentController.createEquipment(data);
        Navigator.of(context).pop();
      },
      onCancel: () {},

      title: title,
      subtitle: description,
      acceptText: "Aceptar",
      cancelText: "Cerrar",
      // showAcceptButton: true,
    ),
  );
}

class EquipmentsModal extends StatefulWidget {
  final EquipmentTypeController equipmentTypeController;
  final EquipmentController equipmentController;
  const EquipmentsModal(
      {super.key,
      required this.equipmentTypeController,
      required this.equipmentController});

  @override
  EquipmentsModalState createState() => EquipmentsModalState();
}

class EquipmentsModalState extends State<EquipmentsModal> {
  // EquipmentTypeController controller = Get.put(EquipmentTypeController());

  start() async {
    await widget.equipmentTypeController.fetchEquipmentTypesDropDown();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      start();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoadingAutocompleteDropdown(
          validator: (value) =>
              notEmptyDropdownOption(value, "Tipo de equipo requerido"),
          initialValue: widget.equipmentTypeController.equipmentType.value,
          prefixIcon: Icons.group,
          enabled: true,
          isLoading: widget.equipmentTypeController.isLoadingTypes,
          listItems: widget.equipmentTypeController.equipmentTypes,
          onSelected: (DropDownOption option) {
            widget.equipmentTypeController.equipmentType.value = option;
          },
          label: "Tipo de equipo",
          hintText: "",
          resetValue: widget.equipmentTypeController.equipmentType,
          width: double.infinity,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = widget
                .equipmentTypeController.equipmentTypes
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),
        CustomInputWidget(
          controller: widget.equipmentController.quantityController,
          label: "Cantidad",
          hintText: "Ingrese la cantidad",
          prefixIcon: Icons.format_list_numbered,
        ),
        CustomInputWidget(
          controller: widget.equipmentController.costController,
          label: "Costo",
          hintText: "Ingrese el costo",
          prefixIcon: Icons.attach_money,
        ),
        CustomDropdownV2Widget(
            labelText: "Moneda",
            hintText: "",
            items: currencyMock,
            validator: (p0) => null,
            prefixIcon: const Icon(Icons.commit),
            textEditingController:
                widget.equipmentController.currencyController,
            onValueChanged: (v) {
              widget.equipmentController.currencyController.text =
                  v!.label.toString();
            }),
        CustomInputWidget(
          controller: widget.equipmentController.serialNumberController,
          label: "Número de serie",
          hintText: "Ingrese el número de serie",
          prefixIcon: Icons.qr_code,
        ),
      ],
    );
  }
}
