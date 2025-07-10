
import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void deleteBranchModal(
    {required BuildContext context,
    bool isEnabled = false,
    VoidCallback? onAccept,
    VoidCallback? onCancel,
    String title = 'Sucursal',
    String acceptText = 'Aceptar',
    String cancelText = 'Cancelar',
    required BranchModel branch,
    }) {
  
BranchController controller = Get.put(BranchController());
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "¿Está seguro de eliminar la sucursal ${branch.branchName}?",
            style: CustomStyle.defaultStyle(context),
          ),
          Text("esta acción no se puede deshacer.",
              style: CustomStyle.hintTextStyleBlack(context)),
        ],
      ),
      onAccept: () async {
        final value = await controller.deleteBranch(branch.id);
        if (value) {
          Navigator.pop(context);
        }
      },
      onCancel: onCancel,
      title: title,
      acceptText: acceptText,
      cancelText: cancelText,
    ),
  );
}
