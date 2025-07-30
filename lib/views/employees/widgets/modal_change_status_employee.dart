import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/employee/employee_model.dart';

import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/employees/controller/employee_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/custom_label_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void changeStatusEmployeeModal({
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
  required EmployeeModel employee,
}) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: ModalChangeStatusEmployee(
        terminationDate: terminationDate,
        terminationReason: terminationReason,
        formKey: formKey,
        isEdit: isEdit,
        employee: employee,
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

class ModalChangeStatusEmployee extends StatefulWidget {
  final String? terminationDate;
  final String? terminationReason;
  final GlobalKey<FormState> formKey;
  final bool isEdit;
  final EmployeeModel employee;
  const ModalChangeStatusEmployee(
      {super.key,
      this.terminationDate,
      this.terminationReason,
      this.isEdit = true,
      required this.employee,
      required this.formKey,
      });

  @override
  ModalChangeStatusEmployeeState createState() =>
      ModalChangeStatusEmployeeState();
}

class ModalChangeStatusEmployeeState extends State<ModalChangeStatusEmployee> {
  // EmployeeController controller = EmployeeController();
  final EmployeeController controller = Get.find<EmployeeController>();

  start() async {
    controller.ddEmployeeStatus.value = DropDownOption(id: '', label: '');
    controller.commentEmployeeController.text = "";

    await controller.genericListController.fetchWorkerStatus();

    setState(() {});
  }

  @override
  void initState() {
    start();
    print("employee ID: ${widget.employee.id}");
    controller.employeeIdChangeStatus = widget.employee.id ?? "no ID";
    controller.commentEmployeeController.text = widget.terminationReason ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomLabelWidget(
              title: "Estado actual",
              label: widget.employee.workerStatus?.name ?? "",
              prefixIcon: Icons.download),
          LoadingAutocompleteDropdown(
            // initialValue: controller.genericListController.isLoadingWorkerStatus
            prefixIcon: Icons.change_circle_sharp,
            validator: (value) =>
                notEmptyDropdownOption(value, "Nuevo estado es requerido"),
            enabled: true,
            isLoading: controller.genericListController.isLoadingWorkerStatus,
            listItems: controller.genericListController.workerStatus
                .where(
                    (p0) => p0.id != (widget.employee.workerStatus?.id ?? "0"))
                .toList(),
            onSelected: (DropDownOption option) {
              controller.ddEmployeeStatus.value = option;
            },
            label: "Nuevo estado del empleado",
            hintText: "",
            resetValue: controller.ddEmployeeStatus,
            width: double.infinity,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.workerStatus
                  .where((p0) =>
                      p0.id != (widget.employee.workerStatus?.id ?? "0"))
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          CustomInputWidget(
            enabled: widget.isEdit,
            controller: controller.commentEmployeeController,
            label: "Comentario",
            hintText: "",
            prefixIcon: Icons.comment,
            validator: (value) => notEmptyFieldValidator(value),
          )
        ],
      ),
    );
  }
}
