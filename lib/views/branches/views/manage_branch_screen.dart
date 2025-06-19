import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/constants/database_constants.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/commons/loading.dart';
import 'package:agents_app/widgets/inputs/autocomplete_dropdown.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/custom_label_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageBranchScreen extends StatefulWidget {
  final BranchModel? branch;

  const ManageBranchScreen({super.key, this.branch});

  @override
  ManageBranchScreenState createState() => ManageBranchScreenState();
}

class ManageBranchScreenState extends State<ManageBranchScreen> {
  final BranchController controller = Get.put(BranchController());

  void start() async {
    await controller.groupController.fetchGroups();
    await controller.clientController.fetchClients();
    await controller.genericListController.fetchClassification();

    controller.isLoadingAdviser.value = true;
    controller.advisers.value = await controller.employeeDropdownService
        .fetchEmployees(EmployeeTypeDatabaseConstants.adviser);
    controller.isLoadingAdviser.value = false;
    controller.isLoadingTerritoryManager.value = true;
    controller.territoryManagers.value = controller.territoryManagers.value =
        await controller.employeeDropdownService
            .fetchEmployees(EmployeeTypeDatabaseConstants.territoryManager);
    controller.isLoadingTerritoryManager.value = false;
    controller.isLoadingAccountBoss.value = true;
    controller.accountBosses.value = controller.accountBosses.value =
        await controller.employeeDropdownService
            .fetchEmployees(EmployeeTypeDatabaseConstants.accountManager);
    controller.isLoadingAccountBoss.value = false;
    controller.isLoadingBillPerson.value = true;
    controller.billPersons.value = controller.billPersons.value =
        await controller.employeeDropdownService
            .fetchEmployees(EmployeeTypeDatabaseConstants.billMan);
    controller.isLoadingBillPerson.value = false;

    await controller.genericListController.fetchBillingTypes();
    await controller.genericListController.fetchGenerationTypes();

    await controller.genericListController.fetchCountries();
    await controller.genericListController.fetchDepartments();
    await controller.genericListController.fetchZones();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
      title: "Administrar Sucursal",
      currentRoute: RouteConstants.branches,
      userRole: "admin",
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              ContentCard(
                child: Column(
                  children: [
                    LayoutBuilder(builder: (context, constraints) {
                      final isWideScreen = constraints.maxWidth > 600;
                      return Wrap(
                        spacing: 40,
                        runSpacing: 20,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceBetween,
                        direction:
                            isWideScreen ? Axis.horizontal : Axis.vertical,
                        children: [
                          Obx(() {
                            if (controller.groupController.isLoading.value) {
                              return SizedBox(
                                  width: isWideScreen
                                      ? (constraints.maxWidth / 3) - 40
                                      : constraints.maxWidth - 40,
                                  child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Loading()));
                            }
                            return SizedBox(
                                width: isWideScreen
                                    ? (constraints.maxWidth / 3) - 40
                                    : constraints.maxWidth - 40,
                                child: AutocompleteDropdownWidget(
                                  prefixIcon: Icons.group,
                                  enabled: true,
                                  // initialValue: DropDownOption(
                                  //     id: widget.branch?.
                                  //     label:
                                  //         clientController.groupId.value.label),
                                  listItems: controller
                                      .groupController.dropdownOptions,
                                  onSelected: (DropDownOption option) {
                                    controller.groupId.value = option;
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
                                    controller.groupId.value = DropDownOption(
                                      id: '',
                                      label: 'Seleccione un grupo',
                                    );
                                  },
                                  onTextChange: (text) async {
                                    List<DropDownOption> filteredOptions =
                                        controller
                                            .groupController.dropdownOptions
                                            .where((option) => option.label
                                                .toLowerCase()
                                                .contains(text.toLowerCase()))
                                            .toList();
                                    return filteredOptions.isEmpty
                                        ? [
                                            DropDownOption(
                                                id: '',
                                                label: 'No hay resultados')
                                          ]
                                        : filteredOptions;
                                  },
                                ));
                          }),
                          Obx(() {
                            if (controller.clientController.isLoading.value) {
                              return SizedBox(
                                  width: isWideScreen
                                      ? (constraints.maxWidth / 3) - 40
                                      : constraints.maxWidth - 40,
                                  child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Loading()));
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
                                listItems:
                                    controller.clientController.dropdownOptions,
                                onSelected: (DropDownOption option) {
                                  controller.client.value = option;
                                },
                                validator: (DropDownOption? value) {
                                  if (value == null || value.id.isEmpty) {
                                    return 'Debe seleccionar un cliente válido';
                                  }
                                  return null;
                                },
                                label: "Cliente-Empresa",
                                hintText: "Seleccione un cliente",
                                onFocusChange: (hasFocus) {},
                                resetClean: (clean) {
                                  controller.client.value = DropDownOption(
                                    id: '',
                                    label: 'Seleccione un cliente',
                                  );
                                },
                                onTextChange: (text) async {
                                  List<DropDownOption> filteredOptions =
                                      controller
                                          .clientController.dropdownOptions
                                          .where((option) => option.label
                                              .toLowerCase()
                                              .contains(text.toLowerCase()))
                                          .toList();
                                  return filteredOptions.isEmpty
                                      ? [
                                          DropDownOption(
                                              id: '',
                                              label: 'No hay resultados')
                                        ]
                                      : filteredOptions;
                                },
                              ),
                            );
                          }),
                          SizedBox(
                              width: isWideScreen
                                  ? (constraints.maxWidth / 3) - 40
                                  : constraints.maxWidth - 40,
                              child: CustomLabelWidget(
                                  title: "País",
                                  label: "Guatemala",
                                  prefixIcon: Icons.flag_outlined)),
                        ],
                      );
                    }),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWideScreen = constraints.maxWidth > 600;
                        return Wrap(
                          spacing: 30,
                          runSpacing: 20,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          direction:
                              isWideScreen ? Axis.horizontal : Axis.vertical,
                          children: [
                            SizedBox(
                              width: isWideScreen
                                  ? (constraints.maxWidth / 3) - 40
                                  : constraints.maxWidth - 40,
                              child: CustomInputWidget(
                                controller: controller.nitController,
                                label: "Nit",
                                hintText: "Ingrese el nit",
                                prefixIcon: Icons.numbers,
                              ),
                            ),
                            SizedBox(
                              width: isWideScreen
                                  ? (constraints.maxWidth / 3) - 40
                                  : constraints.maxWidth - 40,
                              child: CustomInputWidget(
                                controller: controller.codeGpController,
                                label: "Código GP",
                                hintText: "Ingrese el código GP",
                                prefixIcon: Icons.code,
                              ),
                            ),
                            SizedBox(
                              width: isWideScreen
                                  ? (constraints.maxWidth / 3) - 40
                                  : constraints.maxWidth - 40,
                              child: CustomInputWidget(
                                controller: controller.socialReasonController,
                                label: "Razón Social",
                                hintText: "Ingrese la razón social",
                                prefixIcon: Icons.business,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomInputWidget(
                        controller: controller.nameController,
                        label: "Nombre*",
                        hintText: "Nombre de la sucursal",
                        prefixIcon: Icons.business_sharp,
                      ),
                    ),
                  ],
                ),
              ),
              cardContentSpace(),
              ContentCard(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dirección física",
                        style: CustomStyle.hintTextStyleBlack(context),
                      ),
                    ),
                    _physicalAddressSection(controller),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dirección fiscal",
                        style: CustomStyle.hintTextStyleBlack(context),
                      ),
                    ),
                    _fiscalAddressSection(controller),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dirección de cobro",
                        style: CustomStyle.hintTextStyleBlack(context),
                      ),
                    ),
                    _paymentAddressSection(controller)
                  ],
                ),
              ),
              cardContentSpace(),
              ContentCard(
                  child: Column(
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    final isWideScreen = constraints.maxWidth > 600;
                    return Wrap(
                      spacing: 30,
                      runSpacing: 20,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
                      children: [
                        Obx(() {
                          if (controller.isLoadingAdviser.value == true) {
                            return SizedBox(
                                width: isWideScreen
                                    ? (constraints.maxWidth / 3) - 40
                                    : constraints.maxWidth - 40,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Loading()));
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
                              listItems: controller.advisers,
                              onSelected: (DropDownOption option) {
                                controller.adviser.value = option;
                              },
                              label: "Asesor",
                              hintText: "Seleccione un asesor",
                              onFocusChange: (hasFocus) {},
                              resetClean: (clean) {
                                controller.adviser.value = DropDownOption(
                                  id: '',
                                  label: 'Seleccione un asesor',
                                );
                              },
                              onTextChange: (text) async {
                                List<DropDownOption> filteredOptions =
                                    controller.advisers
                                        .where((option) => option.label
                                            .toLowerCase()
                                            .contains(text.toLowerCase()))
                                        .toList();
                                return filteredOptions.isEmpty
                                    ? [
                                        DropDownOption(
                                            id: '', label: 'No hay resultados')
                                      ]
                                    : filteredOptions;
                              },
                            ),
                          );
                        }),
                        Obx(() {
                          if (controller.isLoadingTerritoryManager.value ==
                              true) {
                            return SizedBox(
                                width: isWideScreen
                                    ? (constraints.maxWidth / 3) - 40
                                    : constraints.maxWidth - 40,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Loading()));
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
                              listItems: controller.territoryManagers,
                              onSelected: (DropDownOption option) {
                                controller.territoryManager.value = option;
                              },
                              label: "Gerente de Territorio",
                              hintText: "Seleccione un gerente de territorio",
                              onFocusChange: (hasFocus) {},
                              resetClean: (clean) {
                                controller.territoryManager.value =
                                    DropDownOption(
                                  id: '',
                                  label: 'Seleccione un gerente de territorio',
                                );
                              },
                              onTextChange: (text) async {
                                List<DropDownOption> filteredOptions =
                                    controller.territoryManagers
                                        .where((option) => option.label
                                            .toLowerCase()
                                            .contains(text.toLowerCase()))
                                        .toList();
                                return filteredOptions.isEmpty
                                    ? [
                                        DropDownOption(
                                            id: '', label: 'No hay resultados')
                                      ]
                                    : filteredOptions;
                              },
                            ),
                          );
                        }),
                        Obx(() {
                          if (controller.isLoadingAccountBoss.value == true) {
                            return SizedBox(
                                width: isWideScreen
                                    ? (constraints.maxWidth / 3) - 40
                                    : constraints.maxWidth - 40,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Loading()));
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
                              listItems: controller.accountBosses,
                              onSelected: (DropDownOption option) {
                                controller.accountBoss.value = option;
                              },

                              label: "Jefe de Cuenta",
                              hintText: "Seleccione un jefe de cuenta",
                              onFocusChange: (hasFocus) {},
                              resetClean: (clean) {
                                controller.accountBoss.value = DropDownOption(
                                  id: '',
                                  label: 'Seleccione un jefe de cuenta',
                                );
                              },
                              onTextChange: (text) async {
                                List<DropDownOption> filteredOptions =
                                    controller.accountBosses
                                        .where((option) => option.label
                                            .toLowerCase()
                                            .contains(text.toLowerCase()))
                                        .toList();
                                return filteredOptions.isEmpty
                                    ? [
                                        DropDownOption(
                                            id: '', label: 'No hay resultados')
                                      ]
                                    : filteredOptions;
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                  LayoutBuilder(builder: (context, constraints) {
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
                                    alignment: Alignment.centerLeft,
                                    child: Loading()));
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
                              hintText: "Seleccione un cobrador",
                              onFocusChange: (hasFocus) {},
                              resetClean: (clean) {
                                controller.billPerson.value = DropDownOption(
                                  id: '',
                                  label: 'Seleccione un cobrador',
                                );
                              },
                              onTextChange: (text) async {
                                List<DropDownOption> filteredOptions =
                                    controller.billPersons
                                        .where((option) => option.label
                                            .toLowerCase()
                                            .contains(text.toLowerCase()))
                                        .toList();
                                return filteredOptions.isEmpty
                                    ? [
                                        DropDownOption(
                                            id: '', label: 'No hay resultados')
                                      ]
                                    : filteredOptions;
                              },
                            ),
                          );
                        }),
                        Obx(() {
                          if (controller
                              .genericListController.isLoadingBilling.value) {
                            return SizedBox(
                                width: isWideScreen
                                    ? (constraints.maxWidth / 3) - 40
                                    : constraints.maxWidth - 40,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Loading()));
                          }
                          return SizedBox(
                            width: isWideScreen
                                ? (constraints.maxWidth / 3) - 40
                                : constraints.maxWidth - 40,
                            child: AutocompleteDropdownWidget(
                              enabled: true,
                              listItems:
                                  controller.genericListController.billingTypes,
                              onSelected: (DropDownOption option) {
                                controller.billingType.value = option;
                              },
                              label: "Tipo de Facturación",
                              hintText: "Seleccione un tipo de facturación",
                              onFocusChange: (hasFocus) {},
                              resetClean: (clean) {
                                controller.billingType.value = DropDownOption(
                                  id: '',
                                  label: 'Seleccione un tipo de facturación',
                                );
                              },
                              onTextChange: (text) async {
                                List<DropDownOption> filteredOptions =
                                    controller
                                        .genericListController.billingTypes
                                        .where((option) => option.label
                                            .toLowerCase()
                                            .contains(text.toLowerCase()))
                                        .toList();
                                return filteredOptions.isEmpty
                                    ? [
                                        DropDownOption(
                                            id: '', label: 'No hay resultados')
                                      ]
                                    : filteredOptions;
                              },
                            ),
                          );
                        }),
                        Obx(() {
                          if (controller.genericListController
                              .isLoadingGeneration.value) {
                            return SizedBox(
                                width: isWideScreen
                                    ? (constraints.maxWidth / 3) - 40
                                    : constraints.maxWidth - 40,
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Loading()));
                          }
                          return SizedBox(
                            width: isWideScreen
                                ? (constraints.maxWidth / 3) - 40
                                : constraints.maxWidth - 40,
                            child: AutocompleteDropdownWidget(
                              enabled: true,
                              listItems: controller
                                  .genericListController.generationTypes,
                              onSelected: (DropDownOption option) {
                                controller.generationType.value = option;
                              },
                              label: "Tipo de Generación",
                              hintText:
                                  "Seleccione un tipo de generación de energía",
                              onFocusChange: (hasFocus) {},
                              resetClean: (clean) {
                                controller.generationType.value =
                                    DropDownOption(
                                  id: '',
                                  label:
                                      'Seleccione un tipo de generación de energía',
                                );
                              },
                              onTextChange: (text) async {
                                List<DropDownOption> filteredOptions =
                                    controller
                                        .genericListController.generationTypes
                                        .where((option) => option.label
                                            .toLowerCase()
                                            .contains(text.toLowerCase()))
                                        .toList();
                                return filteredOptions.isEmpty
                                    ? [
                                        DropDownOption(
                                            id: '', label: 'No hay resultados')
                                      ]
                                    : filteredOptions;
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                  LayoutBuilder(builder: (context, constraints) {
                    final isWideScreen = constraints.maxWidth > 600;
                    return Wrap(
                      spacing: 30,
                      runSpacing: 20,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
                      children: [
                        SizedBox(
                          width: isWideScreen
                              ? (constraints.maxWidth / 3) - 40
                              : constraints.maxWidth - 40,
                          child: CustomLabelWidget(
                            title: "Estado",
                            label: "ALTA",
                            prefixIcon: Icons.check_circle_outline,
                          ),
                        ),
                        SizedBox(
                          width: isWideScreen
                              ? (constraints.maxWidth / 3) - 40
                              : constraints.maxWidth - 40,
                        ),
                        SizedBox(
                          width: isWideScreen
                              ? (constraints.maxWidth / 3) - 40
                              : constraints.maxWidth - 40,
                        ),
                      ],
                    );
                  }),
                  Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                          color: Theme.of(context).colorScheme.primary,
                          text: Text(
                            "Guardar",
                            style: CustomStyle.textStyleWhite(context),
                          ),
                          isLoading: false,
                          onPress: () {})),
                ],
              )),
              cardContentSpace(),
              cardContentSpace(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _physicalAddressSection(BranchController controller) {
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
          enabled: true,
          isLoading: controller.genericListController.isLoadingCountry,
          listItems: controller.genericListController.countries,
          onSelected: (DropDownOption option) {
            controller.fiscalCountry.value = option;
          },
          label: "País",
          hintText: "Seleccione un país",
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
          enabled: true,
          isLoading: controller.genericListController.isLoadingCity,
          listItems: controller.genericListController.departments,
          onSelected: (DropDownOption option) {
            controller.fiscalDepartment.value = option;
          },
          label: "Departamento",
          hintText: "Seleccione un departamento",
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
          enabled: true,
          isLoading: controller.genericListController.isLoadingZone,
          listItems: controller.genericListController.zones,
          onSelected: (DropDownOption option) {
            controller.fiscalZone.value = option;
          },
          label: "Zona",
          hintText: "Seleccione una zona",
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
            controller: controller.physicalAddress,
            label: "Dirección",
            hintText: "Ingrese la dirección",
            prefixIcon: Icons.location_on,
          ),
        ),
      ],
    );
  });
}

Widget _fiscalAddressSection(BranchController controller) {
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
          enabled: true,
          isLoading: controller.genericListController.isLoadingCountry,
          listItems: controller.genericListController.countries,
          onSelected: (DropDownOption option) {
            controller.physicalCountry.value = option;
          },
          label: "País",
          hintText: "Seleccione un país",
          resetValue: controller.physicalCountry,
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
          enabled: true,
          isLoading: controller.genericListController.isLoadingCity,
          listItems: controller.genericListController.departments,
          onSelected: (DropDownOption option) {
            controller.physicalDepartment.value = option;
          },
          label: "Departamento",
          hintText: "Seleccione un departamento",
          resetValue: controller.physicalDepartment,
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
          enabled: true,
          isLoading: controller.genericListController.isLoadingZone,
          listItems: controller.genericListController.zones,
          onSelected: (DropDownOption option) {
            controller.physicalZone.value = option;
          },
          label: "Zona",
          hintText: "Seleccione una zona",
          resetValue: controller.physicalZone,
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
            controller: controller.physicalAddress,
            label: "Dirección",
            hintText: "Ingrese la dirección",
            prefixIcon: Icons.location_on,
          ),
        ),
      ],
    );
  });
}

Widget _paymentAddressSection(BranchController controller) {
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
          enabled: true,
          isLoading: controller.genericListController.isLoadingCountry,
          listItems: controller.genericListController.countries,
          onSelected: (DropDownOption option) {
            controller.paymentCountry.value = option;
          },
          label: "País",
          hintText: "Seleccione un país",
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
          enabled: true,
          isLoading: controller.genericListController.isLoadingCity,
          listItems: controller.genericListController.departments,
          onSelected: (DropDownOption option) {
            controller.paymentDepartment.value = option;
          },
          label: "Departamento",
          hintText: "Seleccione un departamento",
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
          enabled: true,
          isLoading: controller.genericListController.isLoadingZone,
          listItems: controller.genericListController.zones,
          onSelected: (DropDownOption option) {
            controller.paymentZone.value = option;
          },
          label: "Zona",
          hintText: "Seleccione una zona",
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
            label: "Dirección",
            hintText: "Ingrese la dirección",
            prefixIcon: Icons.location_on,
          ),
        ),
      ],
    );
  });
}
