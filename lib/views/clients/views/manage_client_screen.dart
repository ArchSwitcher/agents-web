import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/shared/helpers/validations/email_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/shared/helpers/validations/phone_validator.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/commons/loading.dart';
import 'package:agents_app/widgets/inputs/autocomplete_dropdown.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageClientScreen extends StatefulWidget {
  const ManageClientScreen({
    super.key,
  });

  @override
  State<ManageClientScreen> createState() => ManageClientScreenState();
}

class ManageClientScreenState extends State<ManageClientScreen> {
  final ManageGroupController _groupController =
      Get.put(ManageGroupController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ManageClientController controller = Get.put(ManageClientController());
  final LoaderController loaderController = Get.put(LoaderController());

  final bool? isEdit = Get.arguments?['isEdit'];
  final String title = Get.arguments?['title'] ?? "Agregar cliente";
  final String subtitle =
      Get.arguments?['subtitle'] ?? "Agrega un nuevo cliente";

  start() async {
    await _groupController.fetchGroups();
    await controller.fetchEmployees();
    await controller.genericListController.fetchBillingTypes();
    await controller.genericListController.fetchGenerationTypes();
    await controller.genericListController.fetchCountries();
    await controller.genericListController.fetchDepartments();
    await controller.genericListController.fetchZones();
  }

  startEdit() async {
    controller.loadClientData(Get.arguments?['client']);

    // controller.fiscalMunicipalities.value = await controller
    //     .genericListController
    //     .fetchMunicipalitiesOnly(controller.fiscalDepartment.value.id);

    // controller.paymentMunicipalities.value = await controller
    //     .genericListController
    //     .fetchMunicipalitiesOnly(controller.paymentDepartment.value.id);
  }

  @override
  void initState() {
    super.initState();
    if (isEdit == true) {
      startEdit();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      start();
    });
  }

  @override
  void dispose() {
    Get.delete<ManageClientController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ResponsiveSidebarLayout(
      title: title,
      description: subtitle,
      userRole: "admin",
      currentRoute: RouteConstants.clients,
      showBackButton: true,
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              ContentCard(
                child: LayoutBuilder(builder: (context, constraints) {
                  final isWideScreen = constraints.maxWidth > 750;

                  final width = isWideScreen
                      ? (constraints.maxWidth / 3) - 40
                      : constraints.maxWidth - 40;

                  return Obx(() {
                    return _basicInfo(
                      controller,
                      isEdit ?? true,
                      _groupController,
                      width,
                    );
                  });
                }),
              ),
              cardContentSpace(),
              ContentCard(
                  child: Column(
                children: [
                  _fiscalAddressSection(controller),
                  _paymentAddressSection(controller)
                ],
              )),
              cardContentSpace(),
              ContentCard(
                child: _managers(controller),
              ),
              cardContentSpace(),
              ContentCard(
                child: _billInfo(controller),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                        width: 35,
                        height: 25,
                        color: colorScheme.primary,
                        text: Text(
                          "Guardar",
                          style: CustomStyle.textStyleWhite(context),
                        ),
                        isLoading: false,
                        onPress: () async {
                          if (!formKey.currentState!.validate()) {
                            ToastService.warning(
                                title: "Validación",
                                subTitle:
                                    "Por favor, rellene todos los campos obligatorios.");
                            return;
                          }
                          loaderController.show();
                          if (isEdit == true) {
                            await controller.editClient();
                          } else {
                            await controller.newClient();
                          }
                          loaderController.hide();
                          Get.back(result: true);
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _managers(ManageClientController controller) {
  return LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 600;
    final width = isWideScreen
        ? (constraints.maxWidth / 3) - 40
        : constraints.maxWidth - 40;
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      children: [
        LoadingAutocompleteDropdown(
          enabled: true,
          width: width,
          resetValue: controller.adviser,
          isLoading: controller.isLoadingAdviser,
          listItems: controller.advisers,
          onSelected: (DropDownOption option) {
            controller.adviser.value = option;
          },
          initialValue: DropDownOption(
            id: controller.adviser.value.id,
            label: controller.adviser.value.label,
          ),
          validator: (DropDownOption? value) {
            if (value == null || value.id.isEmpty) {
              return 'Debe seleccionar un asesor válido';
            }
            return null;
          },
          label: "Asesor",
          hintText: "Seleccione un asesor",
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller.advisers
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),
        LoadingAutocompleteDropdown(
          enabled: true,
          width: width,
          resetValue: controller.accountManager,
          isLoading: controller.isLoadingAccountBoss,
          listItems: controller.accountBosses,
          onSelected: (DropDownOption option) {
            controller.accountManager.value = option;
          },
          initialValue: DropDownOption(
            id: controller.accountManager.value.id,
            label: controller.accountManager.value.label,
          ),
          label: "Jefe de cuenta",
          hintText: "Seleccione un jefe de cuenta",
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller.accountBosses
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),
      ],
    );
  });
}

Widget _basicInfo(ManageClientController controller, bool isEnabled,
    ManageGroupController groupController, double width) {
  return Wrap(
    spacing: 30,
    runSpacing: 20,
    crossAxisAlignment: WrapCrossAlignment.center,
    alignment: WrapAlignment.spaceBetween,
    children: [
      LoadingAutocompleteDropdown(
        width: width,
        resetValue: controller.groupId,
        isLoading: groupController.isLoading,
        listItems: groupController.dropdownOptions,
        onSelected: (DropDownOption option) {
          controller.groupId.value = option;
        },
        initialValue: controller.groupId.value,
        validator: (DropDownOption? value) {
          if (value == null || value.id.isEmpty) {
            return 'Debe seleccionar un grupo válido';
          }
          return null;
        },
        label: "Grupo",
        hintText: "Seleccione un grupo",
        onTextChange: (text) async {
          List<DropDownOption> filteredOptions = groupController.dropdownOptions
              .where((option) =>
                  option.label.toLowerCase().contains(text.toLowerCase()))
              .toList();
          return filteredOptions.isEmpty ? [] : filteredOptions;
        },
        enabled: isEnabled,
      ),
      SizedBox(
        width: width,
        child: CustomInputWidget(
          enabled: isEnabled,
          controller: controller.nameController,
          label: "Nombre del cliente",
          validator: (v) => notEmptyFieldValidator(v),
          keyboardType: TextInputType.text,
          hintText: "Nombre del cliente",
          prefixIcon: Icons.group,
        ),
      ),
      SizedBox(
        width: width,
        child: CustomInputWidget(
          enabled: isEnabled,
          controller: controller.emailController,
          label: "Correo electrónico",
          validator: (v) => emailValidatorOptional(v),
          keyboardType: TextInputType.emailAddress,
          hintText: "Correo electrónico",
          prefixIcon: Icons.mail_rounded,
        ),
      ),
      SizedBox(
        width: width,
        child: CustomInputWidget(
          enabled: isEnabled,
          controller: controller.urlController,
          label: "Url",
          keyboardType: TextInputType.url,
          hintText: "Url",
          prefixIcon: Icons.link,
        ),
      ),
      SizedBox(
        width: width,
        child: CustomInputWidget(
          enabled: isEnabled,
          controller: controller.phoneController,
          label: "Teléfono",
          validator: (v) => phoneValidatorOptional(v),
          keyboardType: TextInputType.phone,
          hintText: "Teléfono",
          prefixIcon: Icons.phone_outlined,
        ),
      ),
      SizedBox(width: width)
    ],
  );
}

Widget _fiscalAddressSection(ManageClientController controller) {
  return LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 650;
    final width = isWideScreen
        ? (constraints.maxWidth / 5) - 40
        : constraints.maxWidth - 40;
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
      children: [
        LoadingAutocompleteDropdown(
          initialValue: controller.fiscalCountry.value,
          prefixIcon: Icons.public,
          validator: (value) => notEmptyDropdownOption(value, "País requerido"),
          enabled: true,
          isLoading: controller.genericListController.isLoadingCountry,
          listItems: controller.genericListController.countries,
          onSelected: (DropDownOption option) {
            controller.fiscalCountry.value = option;
          },
          label: "Dirección fiscal",
          hintText: "País",
          resetValue: controller.fiscalCountry,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .genericListController.countries
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),

        // LoadingAutocompleteDropdown for Department
        LoadingAutocompleteDropdown(
          initialValue: controller.fiscalDepartment.value,
          prefixIcon: Icons.map,
          enabled: true,
          isLoading: controller.genericListController.isLoadingCity,
          listItems: controller.genericListController.departments,
          validator: (value) =>
              notEmptyDropdownOption(value, "Departamento requerido"),
          onSelected: (DropDownOption option) async {
            controller.fiscalDepartment.value = option;
            controller.fiscalMunicipality.value =
                DropDownOption(id: '', label: '');
            controller.isLoadingFiscalMunicipalities.value = true;
            controller.fiscalMunicipalities.value = await controller
                .genericListController
                .fetchMunicipalitiesOnly(option.id);
            controller.isLoadingFiscalMunicipalities.value = false;
          },
          label: "",
          hintText: "Departamento",
          resetValue: controller.fiscalDepartment,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .genericListController.departments
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty
                ? [DropDownOption(id: '', label: 'No hay resultados')]
                : filteredOptions;
          },
        ),
        LoadingAutocompleteDropdown(
          initialValue: controller.fiscalMunicipality.value,
          validator: (value) =>
              notEmptyDropdownOption(value, "Municipio requerido"),
          prefixIcon: Icons.apartment,
          enabled: true,
          isLoading: controller.isLoadingFiscalMunicipalities,
          listItems: controller.fiscalMunicipalities,
          onSelected: (DropDownOption option) {
            controller.fiscalMunicipality.value = option;
          },
          label: "",
          hintText: "Municipio",
          resetValue: controller.fiscalMunicipality,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .fiscalMunicipalities
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),

        // LoadingAutocompleteDropdown for Zone
        LoadingAutocompleteDropdown(
          initialValue: controller.fiscalZone.value,
          validator: (value) => notEmptyDropdownOption(value, "Zona requerida"),
          prefixIcon: Icons.location_on,
          enabled: true,
          isLoading: controller.genericListController.isLoadingZone,
          listItems: controller.genericListController.zones,
          onSelected: (DropDownOption option) {
            controller.fiscalZone.value = option;
          },
          label: "",
          hintText: "Zona",
          resetValue: controller.fiscalZone,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .genericListController.zones
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty
                ? [DropDownOption(id: '', label: 'No hay resultados')]
                : filteredOptions;
          },
        ),
        SizedBox(
          width: width,
          child: CustomInputWidget(
            controller: controller.fiscalAddress,
            label: "",
            hintText: "Dirección",
            prefixIcon: Icons.home,
            validator: (value) => notEmptyFieldValidator(value),
          ),
        ),
      ],
    );
  });
}

Widget _paymentAddressSection(ManageClientController controller) {
  return LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 650;
    final width = isWideScreen
        ? (constraints.maxWidth / 5) - 40
        : constraints.maxWidth - 40;
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
      children: [
        LoadingAutocompleteDropdown(
          initialValue: controller.paymentCountry.value,
          validator: (value) => notEmptyDropdownOption(value, "País requerido"),
          prefixIcon: Icons.public,
          enabled: true,
          isLoading: controller.genericListController.isLoadingCountry,
          listItems: controller.genericListController.countries,
          onSelected: (DropDownOption option) {
            controller.paymentCountry.value = option;
          },
          label: "Dirección de cobro",
          hintText: "País",
          resetValue: controller.paymentCountry,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .genericListController.countries
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),

        // LoadingAutocompleteDropdown for Department
        LoadingAutocompleteDropdown(
          initialValue: controller.paymentDepartment.value,
          validator: (value) =>
              notEmptyDropdownOption(value, "Departamento requerido"),
          prefixIcon: Icons.map,
          enabled: true,
          isLoading: controller.genericListController.isLoadingCity,
          listItems: controller.genericListController.departments,
          onSelected: (DropDownOption option) async {
            controller.paymentDepartment.value = option;
            controller.paymentMunicipality.value =
                DropDownOption(id: '', label: '');
            controller.isLoadingPaymentMunicipalities.value = true;
            controller.paymentMunicipalities.value = await controller
                .genericListController
                .fetchMunicipalitiesOnly(option.id);
            controller.isLoadingPaymentMunicipalities.value = false;
          },
          label: "",
          hintText: "Departamento",
          resetValue: controller.paymentDepartment,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .genericListController.departments
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),

        LoadingAutocompleteDropdown(
          initialValue: controller.paymentMunicipality.value,
          validator: (value) =>
              notEmptyDropdownOption(value, "Municipio requerido"),
          prefixIcon: Icons.apartment,
          enabled: true,
          isLoading: controller.isLoadingPaymentMunicipalities,
          listItems: controller.paymentMunicipalities,
          onSelected: (DropDownOption option) {
            controller.paymentMunicipality.value = option;
          },
          label: "",
          hintText: "Municipio",
          resetValue: controller.paymentMunicipality,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .paymentMunicipalities
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),

        // LoadingAutocompleteDropdown for Zone
        LoadingAutocompleteDropdown(
          initialValue: controller.paymentZone.value,
          validator: (value) => notEmptyDropdownOption(value, "Zona requerida"),
          prefixIcon: Icons.location_on,
          enabled: true,
          isLoading: controller.genericListController.isLoadingZone,
          listItems: controller.genericListController.zones,
          onSelected: (DropDownOption option) {
            controller.paymentZone.value = option;
          },
          label: "",
          hintText: "Zona",
          resetValue: controller.paymentZone,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .genericListController.zones
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty
                ? [DropDownOption(id: '', label: 'No hay resultados')]
                : filteredOptions;
          },
        ),
        SizedBox(
          width: width,
          child: CustomInputWidget(
            controller: controller.paymentAddress,
            label: "",
            hintText: "Dirección",
            prefixIcon: Icons.home,
            validator: (value) => notEmptyFieldValidator(value),
          ),
        ),
      ],
    );
  });
}

Widget _billInfo(ManageClientController controller) {
  return LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 600;
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
      children: [
        Obx(() {
          if (controller.isLoadingBillPerson.value == true) {
            return SizedBox(
                width: isWideScreen
                    ? (constraints.maxWidth / 3) - 40
                    : constraints.maxWidth - 40,
                child: const Align(
                    alignment: Alignment.centerLeft, child: Loading()));
          }
          return SizedBox(
            width: isWideScreen
                ? (constraints.maxWidth / 3) - 40
                : constraints.maxWidth - 40,
            child: AutocompleteDropdownWidget(
              initialValue: controller.billPerson.value,
              validator: (value) =>
                  notEmptyDropdownOption(value, "Cobrador requerido"),
              enabled: true,
              // initialValue: DropDownOption(
              //     id: controller.clientId.value.id,
              //     label: controller.clientId.value.label),
              listItems: controller.billPersons,
              onSelected: (DropDownOption option) {
                controller.billPerson.value = option;
              },
              label: "Cobrador",
              hintText: "Cobrador",
              onFocusChange: (hasFocus) {},
              resetClean: (clean) {
                controller.billPerson.value = DropDownOption(
                  id: '',
                  label: 'Seleccione un cobrador',
                );
              },
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = controller.billPersons
                    .where((option) =>
                        option.label.toLowerCase().contains(text.toLowerCase()))
                    .toList();
                return filteredOptions.isEmpty
                    ? [DropDownOption(id: '', label: 'No hay resultados')]
                    : filteredOptions;
              },
            ),
          );
        }),
        Obx(() {
          if (controller.genericListController.isLoadingBilling.value) {
            return SizedBox(
                width: isWideScreen
                    ? (constraints.maxWidth / 3) - 40
                    : constraints.maxWidth - 40,
                child: const Align(
                    alignment: Alignment.centerLeft, child: Loading()));
          }
          return SizedBox(
            width: isWideScreen
                ? (constraints.maxWidth / 3) - 40
                : constraints.maxWidth - 40,
            child: AutocompleteDropdownWidget(
              initialValue: controller.billingType.value,
              validator: (value) => notEmptyDropdownOption(
                  value, "Tipo de facturación requerido"),
              enabled: true,
              listItems: controller.genericListController.billingTypes,
              onSelected: (DropDownOption option) {
                controller.billingType.value = option;
              },
              label: "Tipo de Facturación",
              hintText: "Tipo de facturación",
              onFocusChange: (hasFocus) {},
              resetClean: (clean) {
                controller.billingType.value = DropDownOption(
                  id: '',
                  label: 'Seleccione un tipo de facturación',
                );
              },
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = controller
                    .genericListController.billingTypes
                    .where((option) =>
                        option.label.toLowerCase().contains(text.toLowerCase()))
                    .toList();
                return filteredOptions.isEmpty
                    ? [DropDownOption(id: '', label: 'No hay resultados')]
                    : filteredOptions;
              },
            ),
          );
        }),
        Obx(() {
          if (controller.genericListController.isLoadingGeneration.value) {
            return SizedBox(
                width: isWideScreen
                    ? (constraints.maxWidth / 3) - 40
                    : constraints.maxWidth - 40,
                child: const Align(
                    alignment: Alignment.centerLeft, child: Loading()));
          }
          return SizedBox(
            width: isWideScreen
                ? (constraints.maxWidth / 3) - 40
                : constraints.maxWidth - 40,
            child: AutocompleteDropdownWidget(
              initialValue: controller.generationType.value,
              validator: (value) =>
                  notEmptyDropdownOption(value, "Tipo de generación requerido"),
              enabled: true,
              listItems: controller.genericListController.generationTypes,
              onSelected: (DropDownOption option) {
                controller.generationType.value = option;
              },
              label: "Tipo de Generación",
              hintText: "Tipo de generación",
              onFocusChange: (hasFocus) {},
              resetClean: (clean) {
                controller.generationType.value = DropDownOption(
                  id: '',
                  label: 'Seleccione un tipo de generación',
                );
              },
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = controller
                    .genericListController.generationTypes
                    .where((option) =>
                        option.label.toLowerCase().contains(text.toLowerCase()))
                    .toList();
                return filteredOptions.isEmpty
                    ? [DropDownOption(id: '', label: 'No hay resultados')]
                    : filteredOptions;
              },
            ),
          );
        }),
      ],
    );
  });
}
