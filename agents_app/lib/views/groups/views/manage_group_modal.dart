import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';


Widget manageGroupForm(ManageGroupController controller) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CustomInputWidget(
          controller: controller.nameController,
          label: "Nombre",
          hintText: "Nombre del grupo",
          prefixIcon: Icons.group)
    ],
  );
}

void showManageGroupModal(
    {required BuildContext context,
    VoidCallback? onAccept,
    VoidCallback? onCancel,
    String title = 'Grupo',
    String acceptText = 'Aceptar',
    String cancelText = 'Cancelar',
    required ManageGroupController controller}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: manageGroupForm(controller),
      onAccept: onAccept,
      onCancel: onCancel,
      title: title,
      acceptText: acceptText,
      cancelText: cancelText,
    ),
  );
}
