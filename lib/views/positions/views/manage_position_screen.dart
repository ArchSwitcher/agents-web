import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/database_constants.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:agents_app/views/positions/widgets/actions_btns_widget.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/commons/loading.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/custom_label_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagePositionScreen extends StatefulWidget {
  const ManagePositionScreen({super.key});

  @override
  ManagePositionScreenState createState() => ManagePositionScreenState();
}

class ManagePositionScreenState extends State<ManagePositionScreen> {
// get value of route arguments
  final String title =
      Get.arguments?['title'] ?? "Gestión de posiciones para clientes";
  final PositionModel? position = Get.arguments?['position'];
  final bool isEdit = Get.arguments?['isEdit'] ?? true;

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(PositionController());
  int _currentStep = 0;

  start() async {
    await controller.genericListController.getAllShiftTime();
    await controller.genericListController.getAllServiceType();
    await controller.genericListController.fetchDepartments();
    await controller.genericListController.fetchZones();
    await controller.genericListController.getAllCompany();
    await controller.genericListController.getAllAgency();
    await controller.groupController.fetchGroups();
    await controller.genericListController.getAllEquipmentType();

    controller.isLoadingEmployee.value = true;
    controller.advisers.value = await controller.employeeDropdownService
        .fetchEmployees(EmployeeTypeDatabaseConstants.adviser);
    controller.isLoadingEmployee.value = false;
  }

  loadEdit() {
    if (isEdit && position != null) {
      controller.loadPositionData(position!);
      _currentStep = 4;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      start();
      loadEdit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
        title: "Posición",
        description: title,
        currentRoute: RouteConstants.positions,
        userRole: "admin",
        showBackButton: true,
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ContentCard(
                    child: LayoutBuilder(builder: (context, constraints) {
                  final isWideScreen = constraints.maxWidth > 600;
                  final width = isWideScreen
                      ? (constraints.maxWidth / 4) - 40
                      : constraints.maxWidth - 40;

                  return Wrap(
                    spacing: 30, // espacio horizontal entre widgets
                    runSpacing:
                        20, // espacio vertical entre líneas si se hace wrap
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      LoadingAutocompleteDropdown(
                        initialValue: controller.group.value,
                        prefixIcon: Icons.group,
                        enabled: true,
                        isLoading: controller.groupController.isLoading,
                        listItems: controller.groupController.dropdownOptions,
                        onSelected: (DropDownOption option) {
                          controller.group.value = option;
                          controller.genericListController
                              .fetchClientsByGroupId(option.id);
                          controller.client.value =
                              DropDownOption(id: "", label: "");
                          controller.genericListController
                              .cleanClientsByGroup();
                          setState(() {
                            _currentStep = 1;
                          });
                        },
                        label: "Grupo",
                        hintText: "Grupo",
                        resetValue: controller.group,
                        width: width,
                        onTextChange: (text) async {
                          List<DropDownOption> filteredOptions = controller
                              .groupController.dropdownOptions
                              .where((option) => option.label
                                  .toLowerCase()
                                  .contains(text.toLowerCase()))
                              .toList();
                          return filteredOptions.isEmpty ? [] : filteredOptions;
                        },
                      ),
                      //loading dropdown client
                      LoadingAutocompleteDropdown(
                        initialValue: controller.client.value,
                        loadingText: controller.genericListController
                                .isLoadingClientsByGroup.value
                            ? "Seleccione un grupo para ver clientes"
                            : "",
                        prefixIcon: Icons.business,
                        enabled: true,
                        isLoading: controller
                            .genericListController.isLoadingClientsByGroup,
                        listItems: controller
                                .genericListController.clientsByGroup.isEmpty
                            ? []
                            : controller.genericListController.clientsByGroup,
                        onSelected: (DropDownOption option) {
                          controller.client.value = option;
                          controller.genericListController
                              .fetchBranchByClientId(option.id);
                          controller.branch.value =
                              DropDownOption(id: "", label: "");
                          controller.genericListController
                              .cleanBranchesByClient();
                          setState(() {
                            _currentStep = 2;
                          });
                        },
                        label: "Cliente",
                        hintText: "Cliente",
                        resetValue: controller.client,
                        width: width,
                        onTextChange: (text) async {
                          List<DropDownOption> filteredOptions = controller
                              .genericListController.clientsByGroup
                              .where((option) => option.label
                                  .toLowerCase()
                                  .contains(text.toLowerCase()))
                              .toList();
                          return filteredOptions.isEmpty ? [] : filteredOptions;
                        },
                      ),

                      //loading dropdown branch
                      LoadingAutocompleteDropdown(
                        initialValue: controller.branch.value,
                        loadingText: controller.genericListController
                                .isLoadingBranchByClient.value
                            ? "Seleccione un cliente para ver sucursales"
                            : "",
                        prefixIcon: Icons.store,
                        enabled: true,
                        isLoading: controller
                            .genericListController.isLoadingBranchByClient,
                        listItems: controller
                                .genericListController.branchesByClient.isEmpty
                            ? []
                            : controller.genericListController.branchesByClient,
                        onSelected: (DropDownOption option) {
                          controller.branch.value = option;
                          setState(() {
                            _currentStep = 3;
                          });
                        },
                        label: "Sucursal",
                        hintText: "Sucursal",
                        resetValue: controller.branch,
                        width: width,
                        onTextChange: (text) async {
                          List<DropDownOption> filteredOptions = controller
                              .genericListController.branchesByClient
                              .where((option) => option.label
                                  .toLowerCase()
                                  .contains(text.toLowerCase()))
                              .toList();
                          return filteredOptions.isEmpty ? [] : filteredOptions;
                        },
                      ),

                      (_currentStep == 3 || _currentStep == 4)
                          ? LoadingAutocompleteDropdown(
                              initialValue: controller.adviser.value,
                              prefixIcon: Icons.person,
                              enabled: true,
                              isLoading: controller.isLoadingEmployee,
                              listItems: controller.advisers,
                              onSelected: (DropDownOption option) {
                                controller.adviser.value = option;
                                setState(() {
                                  _currentStep = 4;
                                });
                              },
                              label: "Asesor",
                              hintText: "Asesor",
                              resetValue: controller.adviser,
                              width: width,
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
                            )
                          : const Loading(),
                      SizedBox(
                        width: width,
                        child: CustomDatePicker(
                            enabled: false,
                            initialDate: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day),
                            controller: TextEditingController(),
                            label: "Fecha",
                            hintText: "",
                            prefixIcon: Icons.calendar_today),
                      ),

                      LoadingAutocompleteDropdown(
                        initialValue: controller.company.value,
                        prefixIcon: Icons.business,
                        enabled: true,
                        isLoading:
                            controller.genericListController.isLoadingCompany,
                        listItems:
                            controller.genericListController.companies.isEmpty
                                ? []
                                : controller.genericListController.companies,
                        onSelected: (DropDownOption option) {
                          controller.company.value = option;
                        },
                        label: "Empresa",
                        hintText: "Empresa",
                        resetValue: controller.company,
                        width: width,
                        onTextChange: (text) async {
                          List<DropDownOption> filteredOptions = controller
                              .genericListController.companies
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

                      // dropdown for agency
                      LoadingAutocompleteDropdown(
                        initialValue: controller.agency.value,
                        prefixIcon: Icons.business,
                        enabled: true,
                        isLoading:
                            controller.genericListController.isLoadingAgency,
                        listItems:
                            controller.genericListController.agencies.isEmpty
                                ? []
                                : controller.genericListController.agencies,
                        onSelected: (DropDownOption option) {
                          controller.agency.value = option;
                        },
                        label: "Agencia",
                        hintText: "Agencia",
                        resetValue: controller.agency,
                        width: width,
                        onTextChange: (text) async {
                          List<DropDownOption> filteredOptions = controller
                              .genericListController.agencies
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

                      SizedBox(
                          width: width,
                          child: CustomLabelWidget(
                              title: "Moneda",
                              label: "Quetzal",
                              prefixIcon: Icons.attach_money)),
                    ],
                  );
                })),
                _currentStep == 4
                    ? _formStepContent(controller, context, _formKey)
                    : const SizedBox(),
                cardContentSpace(),
                cardContentSpace(),
                cardContentSpace(),
              ],
            ),
          ),
        ));
  }
}

Widget _formStepContent(PositionController controller, BuildContext context,
    GlobalKey<FormState> formKey) {
  return Column(
    children: [
      cardContentSpace(),
      ContentCard(child: LayoutBuilder(builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 600;

        final width = isWideScreen
            ? (constraints.maxWidth / 3) - 40
            : constraints.maxWidth - 40;

        return Wrap(
          spacing: 30, // espacio horizontal entre widgets
          runSpacing: 20, // espacio vertical entre líneas si se hace wrap
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            LoadingAutocompleteDropdown(
              initialValue: controller.serviceType.value,
              prefixIcon: Icons.work,
              enabled: true,
              isLoading: controller.genericListController.isLoadingServiceType,
              listItems: controller.genericListController.serviceTypes,
              onSelected: (DropDownOption option) {
                controller.serviceType.value = option;
              },
              label: "",
              hintText: "Tipo de servicio",
              resetValue: controller.serviceType,
              width: width,
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = controller
                    .genericListController.serviceTypes
                    .where((option) =>
                        option.label.toLowerCase().contains(text.toLowerCase()))
                    .toList();
                return filteredOptions.isEmpty
                    ? [DropDownOption(id: '', label: 'No hay resultados')]
                    : filteredOptions;
              },
            ),
            LoadingAutocompleteDropdown(
              initialValue: controller.shiftTime.value,
              prefixIcon: Icons.access_time,
              enabled: true,
              isLoading: controller.genericListController.isLoadingShiftTime,
              listItems: controller.genericListController.shiftTimes,
              onSelected: (DropDownOption option) {
                controller.shiftTime.value = option;
              },
              label: "",
              hintText: "Horario",
              resetValue: controller.shiftTime,
              width: width,
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = controller
                    .genericListController.shiftTimes
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
            ),
            manageEquipmentButton(context, width, controller),
            SizedBox(width: width)
          ],
        );
      })),
      cardContentSpace(),
      ContentCard(child: LayoutBuilder(builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 750;

        final width = isWideScreen
            ? (constraints.maxWidth / 4) - 40
            : constraints.maxWidth - 40;

        return Wrap(
          spacing: 30, // espacio horizontal entre widgets
          runSpacing: 20, // espacio vertical entre líneas si se hace wrap
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width,
              child: CustomInputWidget(
                  controller: controller.startTime,
                  label: "Hora inicio*",
                  hintText: "Hora inicio",
                  prefixIcon: Icons.access_time),
            ),
            SizedBox(
              width: width,
              child: CustomInputWidget(
                  controller: controller.endTime,
                  label: "Hora fin*",
                  hintText: "Hora fin",
                  prefixIcon: Icons.access_time),
            ),
            SizedBox(
              width: width,
              child: CustomDatePicker(
                  initialDate: DateTime(2020),
                  controller: controller.startDate,
                  label: "Fecha inicio",
                  hintText: "Fecha inicio",
                  prefixIcon: Icons.calendar_today),
            ),
            SizedBox(
                width: width,
                child: CustomDatePicker(
                    initialDate: DateTime(2020),
                    controller: controller.endDate,
                    label: "Fecha fin",
                    hintText: "Fecha fin",
                    prefixIcon: Icons.calendar_today)),
          ],
        );
      })),
      cardContentSpace(),
      ContentCard(
          child: Column(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 750;
            final width = isWideScreen
                ? (constraints.maxWidth / 4) - 40
                : constraints.maxWidth - 40;

            return Wrap(
                spacing: 30,
                runSpacing: 20,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        controller: controller.serviceQuantity,
                        label: "Cantidad de servicio",
                        hintText: "Cantidad de servicio",
                        prefixIcon: Icons.numbers),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        controller: controller.serviceAgent,
                        label: "Agente de servicio",
                        hintText: "Agente de servicio",
                        prefixIcon: Icons.person),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        controller: controller.scheduleQuantity,
                        label: "Cantidad de horarios",
                        hintText: "Cantidad de horarios",
                        prefixIcon: Icons.numbers),
                  ),
                  SizedBox(
                      width: width,
                      child: CustomLabelWidget(
                          title: "País servicio",
                          label: "Guatemala",
                          prefixIcon: Icons.flag)),

                  //bonus, transport, food quantity
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        controller: controller.bonus,
                        label: "Bono",
                        hintText: "Bono",
                        prefixIcon: Icons.attach_money),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        controller: controller.transport,
                        label: "Transporte",
                        hintText: "Transporte",
                        prefixIcon: Icons.directions_bus),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        controller: controller.foodQuantity,
                        label: "Alimentación",
                        hintText: "Alimentación",
                        prefixIcon: Icons.fastfood),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        controller: controller.shiftValue,
                        label: "Valor del turno",
                        hintText: "Valor del turno",
                        prefixIcon: Icons.attach_money),
                  ),
                ]);
          }),
          LayoutBuilder(builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 750;
            final width = isWideScreen
                ? (constraints.maxWidth / 2) - 40
                : constraints.maxWidth - 40;

            return Wrap(
                spacing: 30,
                runSpacing: 20,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width,
                    child: CustomLabelWidget(
                        title: "Precio mínimo",
                        label: controller.minimumPrice.text,
                        prefixIcon: Icons.attach_money),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        controller: controller.servicePrice,
                        label: "Precio del servicio",
                        hintText: "Precio del servicio",
                        prefixIcon: Icons.attach_money),
                  ),
                ]);
          }),
        ],
      )),
      cardContentSpace(),
      ContentCard(child: LayoutBuilder(builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 750;
        final width = isWideScreen
            ? (constraints.maxWidth / 4) - 40
            : constraints.maxWidth - 40;

        return Wrap(
            spacing: 30, // espacio horizontal entre widgets
            runSpacing: 20, // espacio vertical entre líneas si se hace wrap
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              LoadingAutocompleteDropdown(
                initialValue: controller.department.value,
                prefixIcon: Icons.business,
                enabled: true,
                isLoading: controller.genericListController.isLoadingCity,
                listItems: controller.genericListController.departments,
                onSelected: (DropDownOption option) {
                  controller.department.value = option;
                  controller.genericListController
                      .fetchMunicipalities(option.id);
                  controller.municipality.value = DropDownOption(id: "", label: "");
                  controller.genericListController.cleanMunicipalities();
                },
                label: "Departamento",
                hintText: "Departamento",
                resetValue: controller.department,
                width: width,
                onTextChange: (text) async {
                  List<DropDownOption> filteredOptions = controller
                      .genericListController.departments
                      .where((option) => option.label
                          .toLowerCase()
                          .contains(text.toLowerCase()))
                      .toList();
                  return filteredOptions.isEmpty
                      ? []
                      : filteredOptions;
                },
              ),
              LoadingAutocompleteDropdown(
                initialValue: controller.municipality.value,
                loadingText:
                    controller.genericListController.isLoadingMunicipality.value
                        ? "Seleccione un departamento para ver municipios"
                        : "",
                prefixIcon: Icons.location_city,
                enabled: true,
                isLoading:
                    controller.genericListController.isLoadingMunicipality,
                listItems:
                    controller.genericListController.municipalities.isEmpty
                        ? []
                        : controller.genericListController.municipalities,
                onSelected: (DropDownOption option) {
                  controller.municipality.value = option;
                },
                label: "Municipio",
                hintText: "Municipio",
                resetValue: controller.municipality,
                width: width,
                onTextChange: (text) async {
                  List<DropDownOption> filteredOptions = controller
                      .genericListController.municipalities
                      .where((option) => option.label
                          .toLowerCase()
                          .contains(text.toLowerCase()))
                      .toList();
                  return filteredOptions.isEmpty ? [] : filteredOptions;
                },
              ),
              //loading dropdown zone
              LoadingAutocompleteDropdown(
                initialValue: controller.zone.value,
                prefixIcon: Icons.location_on,
                enabled: true,
                isLoading: controller.genericListController.isLoadingZone,
                listItems: controller.genericListController.zones,
                onSelected: (DropDownOption option) {
                  controller.zone.value = option;
                },
                label: "Zona",
                hintText: "Zona",
                resetValue: controller.zone,
                width: width,
                onTextChange: (text) async {
                  List<DropDownOption> filteredOptions = controller
                      .genericListController.zones
                      .where((option) => option.label
                          .toLowerCase()
                          .contains(text.toLowerCase()))
                      .toList();
                  return filteredOptions.isEmpty
                      ? [DropDownOption(id: '', label: 'No hay resultados')]
                      : filteredOptions;
                },
              ),
              SizedBox(
                  width: width,
                  child: CustomInputWidget(
                      controller: controller.address,
                      label: "Dirección",
                      hintText: "Dirección",
                      prefixIcon: Icons.home)),

              CustomInputWidget(
                  controller: controller.observations,
                  label: "Observaciones",
                  hintText: "Observaciones",
                  prefixIcon: Icons.notes),
              Obx(() {
                return Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                      color: Theme.of(context).colorScheme.primary,
                      text: Text(
                        "Guardar",
                        style: CustomStyle.textStyleWhite(context),
                      ),
                      isLoading: controller.isLoadingPosition.value,
                      onPress: () async {
                        if (!formKey.currentState!.validate()) {
                          ToastService.warning(
                              title: "Validación",
                              subTitle:
                                  "por favor, complete todos los campos obligatorios.");
                          return;
                        }
                        //validacion de dias y equipo

                        controller.isLoadingPosition.value = true;
                        const isNewPosition = null;
                        await controller.newUpdatePosition(isNewPosition);
                        controller.isLoadingPosition.value = false;
                      }),
                );
              })
            ]);
      })),
    ],
  );
}
