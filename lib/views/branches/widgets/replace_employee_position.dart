import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/views/branches/controller/presence_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReplaceEmployeePosition extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const ReplaceEmployeePosition({super.key, required this.formKey});
  @override
  ReplaceEmployeePositionState createState() => ReplaceEmployeePositionState();
}

class ReplaceEmployeePositionState extends State<ReplaceEmployeePosition> {
  PresenceController controller =
      Get.put<PresenceController>(PresenceController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Fetch inactive employees when the widget is first built
      await controller.employeeController.fetchInactiveEmployees();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAutocompleteDropdown(
              prefixIcon: Icons.person,
              validator: (value) =>
                  notEmptyDropdownOption(value, "Empleado es obligatorio"),
              enabled: true,
              isLoading:
                  controller.employeeController.isLoadingInactiveEmployees,
              listItems: controller.employeeController.employeesTemp
                  .map((e) => DropDownOption(
                        id: e.id!,
                        label: "${e.firstName} ${e.lastName}",
                      ))
                  .toList(),
              onSelected: (DropDownOption option) async {
                controller.employeeController.employeeTemp.value = option;
              },
              label: "Empleados Temporales",
              hintText: "",
              resetValue: controller.employeeController.employeeTemp,
              width: double.infinity,
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = controller
                    .employeeController.employeesTemp
                    .map((e) => DropDownOption(
                          id: e.id!,
                          label: "${e.firstName} ${e.lastName}",
                        ))
                    .where((option) =>
                        option.label.toLowerCase().contains(text.toLowerCase()))
                    .toList();
                return filteredOptions.isEmpty ? [] : filteredOptions;
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showReplaceModal({
  required BuildContext context,
  bool isEnabled = false,
  required String subtitle,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String title = 'Sucursal',
  String acceptText = 'Aceptar',
  required String positionId,
  required String? oldEmployeeId,
  // String cancelText = 'Cancelar',
}) {
  PresenceController controller =
      Get.put<PresenceController>(PresenceController());

  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // TODO: should be replace with correct values
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: ReplaceEmployeePosition(formKey: formKey),
      // isLoading: true,
      onAccept: () async {
        if (!formKey.currentState!.validate()) {
          ToastService.warning(
              title: "Validación",
              subTitle: "Por favor, complete los campos obligatorios");
          return;
        }

        await controller.employeeController.replaceTempEmployeePosition(
          positionId,
          controller.employeeController.employeeTemp.value.id,
          oldEmployeeId,
        );
        ToastService.success(
          title: "Éxito",
          subTitle: "Empleado reemplazado correctamente",
        );
        controller.clearEmployeeTemp();
        Navigator.of(context).pop();
        onAccept?.call();
      },
      subtitle: subtitle,
      onCancel: () {
        controller.clearEmployeeTemp();
      },
      title: title,
      acceptText: acceptText,
      cancelText: "Cerrar",
    ),
  );
}
