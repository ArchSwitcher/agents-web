import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_checkbox_label_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

void showAssignEquipmentModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Asignar equipo",
  bool isEdit = true,
  bool showAcceptButton = true,
}) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: ModalAssignEquipment(formKey: formKey),
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
      showAcceptButton: showAcceptButton,
    ),
  );
}

class ModalAssignEquipment extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const ModalAssignEquipment({Key? key, required this.formKey})
      : super(key: key);

  @override
  _ModalAssignEquipmentState createState() => _ModalAssignEquipmentState();
}

class _ModalAssignEquipmentState extends State<ModalAssignEquipment> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInputWidget(
                controller: TextEditingController(),
                label: "Notas",
                hintText: "Notas",
                prefixIcon: Icons.note),
            CustomInputWidget(
                controller: TextEditingController(),
                label: "Cantidad",
                hintText: "Cantidad",
                prefixIcon: Icons.format_list_numbered),
            CustomInputWidget(
                controller: TextEditingController(),
                label: "Numero de serie",
                hintText: "Numero de serie",
                prefixIcon: Icons.qr_code_scanner_outlined),
            CustomCheckboxLabelWidget(
              isChecked: true,
              onChanged: (value) {},
              label: "¿Devolver equipo?",
              icon: Icons.repeat_rounded,
            ),
            CustomInputWidget(
                controller: TextEditingController(),
                label: "Notas de devolución",
                hintText: "Notas de devolución",
                prefixIcon: Icons.note),
          ],
        ));
  }
}
