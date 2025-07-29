import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/custom_label_widget.dart';
import 'package:flutter/material.dart';

void downEmployeeModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Dar de baja a empleado",
  bool isEdit = true,
  bool showAcceptButton = true,
  bool employeeStatus = true,
  String terminationDate = "",
  String terminationReason = "",
}) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller =
      TextEditingController(text: terminationReason);

  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomLabelWidget(
                title: "Estado",
                label: "BAJA",
                prefixIcon: Icons.download),
            CustomInputWidget(
              enabled: employeeStatus,
              controller: controller,
              label: "Comentario baja",
              hintText: "",
              prefixIcon: Icons.comment,
              validator: (value) => notEmptyFieldValidator(value),
            ),
            if (!employeeStatus && terminationDate.isNotEmpty)
              CustomLabelWidget(
                  title: "Fecha de baja",
                  label: terminationDate,
                  prefixIcon: Icons.date_range)
          ],
        ),
      ),
      onAccept: () {
        if (formKey.currentState?.validate() ?? false) {
          onAccept?.call();
        } else {
          ToastService.warning(
              title: "Error validación",
              subTitle: "Por favor, complete todos los campos requeridos.");
        }
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
