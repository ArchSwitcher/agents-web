import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/database_constants.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/branches/sections/turn_config.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:agents_app/views/positions/widgets/actions_btns_widget.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
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
  final String? positionId = Get.arguments?['positionId'];
  final bool isEdit = Get.arguments?['isEdit'] ?? true;

  // final _formKey = GlobalKey<FormState>();
  final controller = Get.put(PositionController());
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
        title: "Proseña",
        description: title,
        currentRoute: RouteConstants.positions,
        userRole: "admin",
        showBackButton: true,
        content: ManagePositionSection(
            currentS: _currentStep,
            positionId: positionId,
            isEdit: isEdit,
            isEnabled: true));
  }
}

class ManagePositionSection extends StatefulWidget {
  final int currentS;
  final String? positionId;
  final bool isEdit;
  final bool isEnabled;

  const ManagePositionSection(
      {super.key,
      required this.currentS,
      this.positionId,
      this.isEdit = true,
      this.isEnabled = true});

  @override
  State<ManagePositionSection> createState() => _ManagePositionSectionState();
}

class _ManagePositionSectionState extends State<ManagePositionSection> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;

  // final _formKey = GlobalKey<FormState>();
  final controller = Get.put(PositionController());

  start() async {
    await controller.genericListController.getAllShiftTime();
    await controller.genericListController.getAllServiceType();

    await controller.genericListController.getAllCompany();
    await controller.genericListController.getAllAgency();
    await controller.groupController.fetchGroups();
    await controller.genericListController.getAllEquipmentType();

    controller.isLoadingEmployee.value = true;
    controller.advisers.value = await controller.employeeDropdownService
        .fetchEmployees(EmployeeTypeDatabaseConstants.adviser);
    controller.isLoadingEmployee.value = false;
  }

  loadEdit() async {
    if (widget.isEdit && widget.positionId != null) {

      PositionModel? position = await controller.loadPositionData(widget.positionId!);
      controller.genericListController
          .fetchClientsByGroupId(position?.group?.id ?? "");
      controller.genericListController
          .fetchBranchByClientId(position?.client?.id ?? "");
      await controller.genericListController
          .fetchTurnsByBranch(position?.branch?.id ?? "");

      controller.branchController.turns.value =
          controller.genericListController.turns;

      controller.branchController.turns.forEach((turn) {
        if (turn.id == position?.turn?.id) {
          turn.isSelected.value = true;
        } else {
          turn.isSelected.value = false;
        }
      });
      currentStep = 3;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.currentS;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      start();
      loadEdit();
    });
  }

  @override
  void dispose() {
    Get.delete<PositionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
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
                    initialValue: controller.group.value,
                    prefixIcon: Icons.group,
                    enabled: widget.isEnabled,
                    isLoading: controller.groupController.isLoading,
                    listItems: controller.groupController.dropdownOptions,
                    onSelected: (DropDownOption option) {
                      controller.group.value = option;
                      controller.genericListController
                          .fetchClientsByGroupId(option.id);
                      controller.client.value =
                          DropDownOption(id: "", label: "");
                      controller.genericListController.cleanClientsByGroup();
                      setState(() {
                        currentStep = 1;
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
                    loadingText: controller
                            .genericListController.isLoadingClientsByGroup.value
                        ? "Seleccione un grupo para ver clientes"
                        : "",
                    prefixIcon: Icons.business,
                    enabled: widget.isEnabled,
                    isLoading: controller
                        .genericListController.isLoadingClientsByGroup,
                    listItems:
                        controller.genericListController.clientsByGroup.isEmpty
                            ? []
                            : controller.genericListController.clientsByGroup,
                    onSelected: (DropDownOption option) {
                      controller.client.value = option;
                      controller.genericListController
                          .fetchBranchByClientId(option.id);
                      controller.branch.value =
                          DropDownOption(id: "", label: "");
                      controller.genericListController.cleanBranchesByClient();
                      setState(() {
                        currentStep = 2;
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
                    loadingText: controller
                            .genericListController.isLoadingBranchByClient.value
                        ? "Seleccione un cliente para ver sucursales"
                        : "",
                    prefixIcon: Icons.store,
                    enabled: widget.isEnabled,
                    isLoading: controller
                        .genericListController.isLoadingBranchByClient,
                    listItems: controller
                            .genericListController.branchesByClient.isEmpty
                        ? []
                        : controller.genericListController.branchesByClient,
                    onSelected: (DropDownOption option) async {
                      controller.branch.value = option;
                      await controller.genericListController
                          .fetchTurnsByBranch(option.id);

                      controller.branchController.turns.value =
                          controller.genericListController.turns;

                      // print(
                      //     "turns: ${controller.genericListController.turns.length}");
                      currentStep = 3;
                      setState(() {});
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

                  SizedBox(
                    width: width,
                    child: CustomDatePicker(
                        enabled: false,
                        initialDate: DateTime.now(),
                        controller: TextEditingController(
                            text: DateTime.now().toString().substring(0, 10)),
                        label: "Fecha",
                        hintText: "",
                        prefixIcon: Icons.calendar_today),
                  ),

                  LoadingAutocompleteDropdown(
                    initialValue: controller.company.value,
                    prefixIcon: Icons.business,
                    enabled: widget.isEnabled,
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
                          ? [DropDownOption(id: '', label: 'No hay resultados')]
                          : filteredOptions;
                    },
                  ),

                  // dropdown for agency
                  LoadingAutocompleteDropdown(
                    initialValue: controller.agency.value,
                    prefixIcon: Icons.business,
                    enabled: widget.isEnabled,
                    isLoading: controller.genericListController.isLoadingAgency,
                    listItems: controller.genericListController.agencies.isEmpty
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
                          ? [DropDownOption(id: '', label: 'No hay resultados')]
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
            currentStep == 3 &&
                    controller.genericListController.isLoadingTurns.value ==
                        false
                ? _formStepContent(
                    controller, context, formKey, widget.isEnabled)
                : Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                        currentStep == 2
                            ? "Seleccione una sucursal"
                            : "La sucursal no tiene turnos disponibles",
                        style: CustomStyle.tableHeader(context, 20)),
                  ),
            cardContentSpace(),
          ],
        ),
      ),
    );
  }
}

Widget _formStepContent(PositionController controller, BuildContext context,
    GlobalKey<FormState> formKey, bool isEnabled) {
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
            SizedBox(
              width: width,
              child: CustomInputWidget(
                  enabled: isEnabled,
                  controller: controller.positionName,
                  label: "Nombre de la posición",
                  hintText: "Nombre de la posición",
                  validator: (value) => notEmptyFieldValidator(value),
                  prefixIcon: Icons.location_on_rounded),
            ),

            LoadingAutocompleteDropdown(
              initialValue: controller.serviceType.value,
              prefixIcon: Icons.work,
              enabled: isEnabled,
              isLoading: controller.genericListController.isLoadingServiceType,
              listItems: controller.genericListController.serviceTypes,
              onSelected: (DropDownOption option) {
                controller.serviceType.value = option;
              },
              label: "Tipo de servicio",
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
              enabled: isEnabled,
              isLoading: controller.genericListController.isLoadingShiftTime,
              listItems: controller.genericListController.shiftTimes,
              onSelected: (DropDownOption option) {
                controller.shiftTime.value = option;
              },
              label: "Horario",
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
            Padding(
                padding: const EdgeInsets.only(top: 14),
                child: manageEquipmentButton(context, width, controller, isEnabled)),
            SizedBox(
              width: width,
              child: CustomDatePicker(
                  initialDate: DateTime(2020),
                  controller: controller.startDate,
                  enabled: isEnabled,
                  validator: (value) {
                    if (value == null) {
                      return "Fecha de inicio es requerida";
                    }
                    return null;
                  },
                  label: "Fecha inicio",
                  hintText: "Fecha inicio",
                  prefixIcon: Icons.calendar_today),
            ),
            SizedBox(
                width: width,
                child: CustomDatePicker(
                    enabled: isEnabled,
                    initialDate: DateTime(2020),
                    controller: controller.endDate,
                    label: "Fecha fin",
                    hintText: "Fecha fin",
                    prefixIcon: Icons.calendar_today)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Turnos disponibles de la sucursal",
                    style: CustomStyle.textStyleBlack(context)),
                controller.genericListController.isLoadingTurns.value
                    ? CircularProgressIndicator()
                    : turnConfiguration(Theme.of(context).colorScheme,
                        controller.branchController, true, isEnabled)
              ],
            ),
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
                        enabled: isEnabled,
                        controller: controller.serviceQuantity,
                        label: "Cantidad de servicio",
                        hintText: "Cantidad de servicio",
                        prefixIcon: Icons.numbers),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        enabled: isEnabled,
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
                        enabled: isEnabled,
                        controller: controller.bonus,
                        label: "Bono",
                        hintText: "Bono",
                        prefixIcon: Icons.attach_money),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        enabled: isEnabled,
                        controller: controller.transport,
                        label: "Transporte",
                        hintText: "Transporte",
                        prefixIcon: Icons.directions_bus),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        enabled: isEnabled,
                        controller: controller.foodQuantity,
                        label: "Alimentación",
                        hintText: "Alimentación",
                        prefixIcon: Icons.fastfood),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        enabled: isEnabled,
                        controller: controller.shiftValue,
                        label: "Valor del turno",
                        hintText: "Valor del turno",
                        prefixIcon: Icons.attach_money),
                  ),
                  SizedBox(
                    width: width,
                    child: CustomInputWidget(
                        enabled: isEnabled,
                        controller: controller.servicePrice,
                        label: "Precio del servicio",
                        hintText: "Precio del servicio",
                        prefixIcon: Icons.attach_money),
                  ),
                  CustomInputWidget(
                      enabled: isEnabled,
                      controller: controller.observations,
                      label: "Observaciones",
                      hintText: "Observaciones",
                      prefixIcon: Icons.notes),
                ]);
          }),
        ],
      )),
      if (isEnabled == true)
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                  width: 35,
                  height: 25,
                  color: Theme.of(context).colorScheme.primary,
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
                              "por favor, complete todos los campos obligatorios.");
                      return;
                    }
                    controller.loader.show();
                    controller.isLoadingPosition.value = true;
                    const isNewPosition = null;
                    await controller.newUpdatePosition(isNewPosition);
                    controller.isLoadingPosition.value = false;
                    controller.loader.hide();
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
    ],
  );
}


// Obx(() {
//                     return Align(
//                       alignment: Alignment.centerRight,
//                       child: CustomButton(
//                           color: Theme.of(context).colorScheme.primary,
//                           text: Text(
//                             "Guardar",
//                             style: CustomStyle.textStyleWhite(context),
//                           ),
//                           isLoading: controller.isLoadingPosition.value,
//                           onPress: () async {
//                             if (!formKey.currentState!.validate()) {
//                               ToastService.warning(
//                                   title: "Validación",
//                                   subTitle:
//                                       "por favor, complete todos los campos obligatorios.");
//                               return;
//                             }
//                             //validacion de dias y equipo

//                             controller.isLoadingPosition.value = true;
//                             const isNewPosition = null;
//                             await controller.newUpdatePosition(isNewPosition);
//                             controller.isLoadingPosition.value = false;
//                           }),
//                     );
//                   })