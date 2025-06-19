import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/widgets/commons/loading.dart';
import 'package:agents_app/widgets/inputs/autocomplete_dropdown.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/custom_label_widget.dart';
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

    controller.adviser.value = controller.adviser.value =
        await controller.employeeDropdownService.fetchEmployees("1");
    controller.territoryManager.value = controller.territoryManager.value =
        await controller.employeeDropdownService.fetchEmployees("2");
    controller.accountBoss.value = controller.accountBoss.value =
        await controller.employeeDropdownService.fetchEmployees("3");
    controller.billPerson.value = controller.billPerson.value =
        await controller.employeeDropdownService.fetchEmployees("4");
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
                    LayoutBuilder(builder: (context, constraints) {
                      final isWideScreen = constraints.maxWidth > 600;
                      return Wrap(
                        spacing: 30,
                        runSpacing: 20,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceBetween,
                        direction:
                            isWideScreen ? Axis.horizontal : Axis.vertical,
                        children: [
                          
                        ],
                      );
                    }),
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
