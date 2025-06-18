import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/email_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/shared/helpers/validations/phone_validator.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/commons/loading.dart';
import 'package:agents_app/widgets/inputs/autocomplete_dropdown.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageClientForm extends StatefulWidget {
  final ManageClientController controller;
  final bool isEnabled;
  final GlobalKey<FormState> formKey;

  const ManageClientForm(
      {super.key,
      required this.isEnabled,
      required this.controller,
      required this.formKey});

  @override
  State<ManageClientForm> createState() => ManageClientFormState();
}

class ManageClientFormState extends State<ManageClientForm> {
  final ManageGroupController _groupController =
      Get.put(ManageGroupController());

  start() async {
    await _groupController.fetchGroups();
    widget.controller.isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _groupDropdown(widget.isEnabled, widget.controller, _groupController),
          CustomInputWidget(
            enabled: widget.isEnabled,
            controller: widget.controller.nameController,
            label: "Nombre de grupo",
            validator: (v) => notEmptyFieldValidator(v),
            keyboardType: TextInputType.text,
            hintText: "Nombre del grupo",
            prefixIcon: Icons.group,
          ),
          CustomInputWidget(
            enabled: widget.isEnabled,
            controller: widget.controller.emailController,
            label: "Correo electrónico",
            validator: (v) => emailValidatorOptional(v),
            keyboardType: TextInputType.emailAddress,
            hintText: "Correo electrónico",
            prefixIcon: Icons.mail_rounded,
          ),
          CustomInputWidget(
            enabled: widget.isEnabled,
            controller: widget.controller.urlController,
            label: "Url",
            keyboardType: TextInputType.url,
            hintText: "Url",
            prefixIcon: Icons.link,
          ),
          CustomInputWidget(
            enabled: widget.isEnabled,
            controller: widget.controller.phoneController,
            label: "Teléfono",
            validator: (v) => phoneValidatorOptional(v),
            keyboardType: TextInputType.phone,
            hintText: "Teléfono",
            prefixIcon: Icons.phone_outlined,
          ),
        ],
      ),
    );
  }
}

void showManageClientModal(
    {required BuildContext context,
    bool isEnabled = false,
    VoidCallback? onAccept,
    VoidCallback? onCancel,
    String title = 'Cliente',
    String acceptText = 'Aceptar',
    String cancelText = 'Cancelar',
    required ManageClientController controller}) {
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: ManageClientForm(
        isEnabled: isEnabled,
        controller: controller,
        formKey: formKey,
      ),
      onAccept: () => {
        if (formKey.currentState!.validate())
          {onAccept?.call()}
        else
          {
            ToastService.warning(
                title: "Clientes", subTitle: "Por favor, verifique campos")
          }
      },
      onCancel: onCancel,
      title: title,
      acceptText: acceptText,
      cancelText: cancelText,
    ),
  );
}

Widget _groupDropdown(bool isEnabled, ManageClientController clientController,
    ManageGroupController groupController) {
  return Obx(() {
    if (clientController.isLoading.value) {
      return Loading(isLoading: clientController.isLoading.value);
    }

    return AutocompleteDropdownWidget(
      enabled: isEnabled,
      initialValue: DropDownOption(
          id: clientController.groupId.value.id,
          label: clientController.groupId.value.label),
      listItems: groupController.dropdownOptions,
      onSelected: (DropDownOption option) {
        clientController.groupId.value = option;
      },
      validator: (DropDownOption? value) {
        if (value == null || value.id.isEmpty) {
          return 'Debe seleccionar un grupo válido';
        }
        return null;
      },
      label: "Grupo",
      hintText: "Seleccione un grupo",
      onFocusChange: (hasFocus) {},
      resetClean: (clean) {
        clientController.groupId.value = DropDownOption(
          id: '',
          label: 'Seleccione un grupo',
        );
      },
      onTextChange: (text) async {
        List<DropDownOption> filteredOptions = groupController.dropdownOptions
            .where((option) =>
                option.label.toLowerCase().contains(text.toLowerCase()))
            .toList();
        return filteredOptions.isEmpty
            ? [DropDownOption(id: '', label: 'No hay resultados')]
            : filteredOptions;
      },
    );
  });
}
