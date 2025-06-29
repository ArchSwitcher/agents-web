import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/branches/controller/contact_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void showContactModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  required ContactController controller,
  String description = "",
  String title = "Contacto",
  bool isEdit = true,
}) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: SingleChildScrollView(child: Obx(() {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              LoadingAutocompleteDropdown(
                validator: (value) =>
                    notEmptyDropdownOption(value, "Sucursal requerida"),
                initialValue: controller.branch.value,
                prefixIcon: Icons.group,
                enabled: isEdit,
                isLoading: controller.genericListController.isLoadingBranchesDd,
                listItems: controller.genericListController.branchesDd,
                onSelected: (DropDownOption option) {
                  controller.branch.value = option;                  
                },
                label: "Sucursal",
                hintText: "Sucursal",
                resetValue: controller.branch,
                width: double.infinity,
                onTextChange: (text) async {
                  List<DropDownOption> filteredOptions = controller
                      .genericListController.branchesDd
                      .where((option) => option.label
                          .toLowerCase()
                          .contains(text.toLowerCase()))
                      .toList();
                  return filteredOptions.isEmpty ? [] : filteredOptions;
                },
              ),

              CustomInputWidget(
                enabled: isEdit,
                controller: controller.name,
                label: "Nombre",
                hintText: "Nombre",
                prefixIcon: Icons.person,
                validator: (value) => notEmptyFieldValidator(value),
              ),
              
              CustomInputWidget(
                enabled: isEdit,
                controller: controller.phone,
                label: "Teléfono",
                hintText: "Teléfono",
                prefixIcon: Icons.phone,
                validator: (value) => notEmptyFieldValidator(value),
              ),
              
            ],
          ),
        );
      })),
      onAccept: () {
        if (formKey.currentState!.validate()) {
          onAccept?.call();
        } else {
          ToastService.warning(
              title: "Error validación",
              subTitle: "Por favor, complete todos los campos requeridos.");
        }
      },
      onCancel: () {
        controller.clear();
      },
      title: title,
      subtitle: description,
      acceptText: "Aceptar",
      cancelText: "Cerrar",
    ),
  );
}