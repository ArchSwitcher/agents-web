import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/helpers/validations/email_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/shared/helpers/validations/phone_validator.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/clients/widgets/schedule_modal_widget.dart';
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

  final bool isEnabled = Get.arguments?['isEdit'] ?? true;
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

  @override
  void initState() {
    super.initState();
    start();
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
                      isEnabled,
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
                child: _billInfo(controller),
              ),
              cardContentSpace(),
              ContentCard(child: _turnConfiguration(colorScheme, controller)),
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
                        onPress: () {
                          if (controller.turns.isEmpty) {
                            ToastService.warning(
                                title: "No se puede guardar",
                                subTitle: "No hay turnos configurados.");
                            return;
                          }
                          if (formKey.currentState!.validate()) {}
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
        isLoading: controller.isLoading,
        listItems: groupController.dropdownOptions,
        onSelected: (DropDownOption option) {
          controller.groupId.value = option;
        },
        initialValue: DropDownOption(
          id: controller.groupId.value.id,
          label: controller.groupId.value.label,
        ),
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
          label: "Nombre de grupo",
          validator: (v) => notEmptyFieldValidator(v),
          keyboardType: TextInputType.text,
          hintText: "Nombre del grupo",
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
    final isWideScreen = constraints.maxWidth > 600;
    final width = isWideScreen
        ? (constraints.maxWidth / 4) - 40
        : constraints.maxWidth - 40;
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
      children: [
        LoadingAutocompleteDropdown(
          prefixIcon: Icons.location_on,
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
            return filteredOptions.isEmpty
                ? [DropDownOption(id: '', label: 'No hay resultados')]
                : filteredOptions;
          },
        ),

        // LoadingAutocompleteDropdown for Department
        LoadingAutocompleteDropdown(
          prefixIcon: Icons.location_city,
          enabled: true,
          isLoading: controller.genericListController.isLoadingCity,
          listItems: controller.genericListController.departments,
          onSelected: (DropDownOption option) {
            controller.fiscalDepartment.value = option;
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

        // LoadingAutocompleteDropdown for Zone
        LoadingAutocompleteDropdown(
          prefixIcon: Icons.map,
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
            prefixIcon: Icons.location_on,
          ),
        ),
      ],
    );
  });
}

Widget _paymentAddressSection(ManageClientController controller) {
  return LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 600;
    final width = isWideScreen
        ? (constraints.maxWidth / 4) - 40
        : constraints.maxWidth - 40;
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
      children: [
        LoadingAutocompleteDropdown(
          prefixIcon: Icons.location_on,
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
            return filteredOptions.isEmpty
                ? [DropDownOption(id: '', label: 'No hay resultados')]
                : filteredOptions;
          },
        ),

        // LoadingAutocompleteDropdown for Department
        LoadingAutocompleteDropdown(
          prefixIcon: Icons.location_city,
          enabled: true,
          isLoading: controller.genericListController.isLoadingCity,
          listItems: controller.genericListController.departments,
          onSelected: (DropDownOption option) {
            controller.paymentDepartment.value = option;
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
            return filteredOptions.isEmpty
                ? [DropDownOption(id: '', label: 'No hay resultados')]
                : filteredOptions;
          },
        ),

        // LoadingAutocompleteDropdown for Zone
        LoadingAutocompleteDropdown(
          prefixIcon: Icons.map,
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
            hintText: "Ingrese la dirección",
            prefixIcon: Icons.location_on,
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

Widget _turnConfiguration(
    ColorScheme colorScheme, ManageClientController controller) {
  return LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 750;

    final width = isWideScreen
        ? (constraints.maxWidth / 5) - 40
        : constraints.maxWidth - 40;
    return Obx(() {
      return Wrap(
        spacing: 30,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        children: [
          SizedBox(
              width: width,
              child: CustomButton(
                  color: colorScheme.primary,
                  text: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timelapse,
                        color: colorScheme.surface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Agregar turno",
                        style: CustomStyle.textStyleWhite(context),
                      ),
                    ],
                  ),
                  isLoading: false,
                  onPress: () {
                    showScheduleModal(
                        context: context,
                        controller: controller,
                        onAccept: () {
                          controller.addTurn();
                          Navigator.of(context).pop();
                        });
                  })),
          // List of turn cards with index

          ...controller.turns.asMap().entries.map((entry) {
            int index = entry.key;
            var turn = entry.value;
            return _turnCard(
                width, colorScheme, context, turn.name, controller, index);
          }),
        ],
      );
    });
  });
}

Widget _turnCard(double width, ColorScheme colorScheme, BuildContext context,
    String name, ManageClientController controller, int index) {
  return SizedBox(
    width: width,
    child: Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: IntrinsicHeight(
          // permite crecer en alto si es necesario
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: CustomStyle.textStyleBlack(context),
                  softWrap: true,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 20,
                        padding: const EdgeInsets.all(0),
                        icon: Icon(Icons.edit_calendar_rounded,
                            color: colorScheme.primary),
                        onPressed: () {
                          controller.selectTurn(index);
                          showScheduleModal(
                            description: "Editar turno",
                            context: context,
                            controller: controller,
                            onAccept: () {
                              controller.editTurn(index);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                      IconButton(
                        iconSize: 20,
                        padding: const EdgeInsets.all(0),
                        icon: Icon(Icons.close, color: colorScheme.error),
                        onPressed: () {
                          controller.selectTurn(index);
                          showScheduleModal(
                              description:
                                  "¿Está seguro de que desea eliminar este turno?",
                              isEdit: false,
                              context: context,
                              controller: controller,
                              onAccept: () {
                                controller.deleteTurn(index);
                                Navigator.of(context).pop();
                              });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
