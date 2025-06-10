import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget manageGroupForm(ManageGroupController controller,
    GlobalKey<FormState> formKeyManageGroups) {
  return Form(
    key: formKeyManageGroups,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomInputWidget(
            controller: controller.nameController,
            label: "Nombre de grupo",
            validator: (v) => notEmptyFieldValidator(v),
            hintText: "Nombre del grupo",
            prefixIcon: Icons.group)
      ],
    ),
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
  final formKeyManageGroups = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: manageGroupForm(controller, formKeyManageGroups),
      onAccept: () => {
        if (formKeyManageGroups.currentState!.validate()) {onAccept} else {
          ToastService.warning(title: "Grupos", subTitle: "Por favor, verifique campos")
        }
      },
      onCancel: onCancel,
      title: title,
      acceptText: acceptText,
      cancelText: cancelText,
    ),
  );
}
