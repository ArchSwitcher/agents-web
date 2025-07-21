import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/views/equipment/controllers/equipment_type_controller.dart';
// import 'package:agents_app/views/equipment/controllers/equipment_assgiment.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/autocomplete_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

void showEquipmentTypeModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Equipo asignado",
  bool isEdit = true,
  required String employeeId,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: const EquipmentTypeModal(),
      onAccept: () {
        ToastService.warning(
            title: "Error validación",
            subTitle: "Por favor, complete todos los campos requeridos.");
      },
      onCancel: () {},
      title: title,
      subtitle: description,
      acceptText: "Aceptar",
      cancelText: "Cerrar",
      showAcceptButton: false,
    ),
  );
}

class EquipmentTypeModal extends StatefulWidget {
  const EquipmentTypeModal({super.key});

  @override
  EquipmentTypeModalState createState() => EquipmentTypeModalState();
}

class EquipmentTypeModalState extends State<EquipmentTypeModal> {
  EquipmentTypeController controller = Get.put(EquipmentTypeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
      ],
    );
  }
}
