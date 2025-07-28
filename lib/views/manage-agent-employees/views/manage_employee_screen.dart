import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/database_constants.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/views/manage-agent-employees/sections/bank_info.dart';
import 'package:agents_app/views/manage-agent-employees/sections/contact_info.dart';
import 'package:agents_app/views/manage-agent-employees/sections/family_info.dart';
import 'package:agents_app/views/manage-agent-employees/sections/images_info.dart';
import 'package:agents_app/views/manage-agent-employees/sections/job_info.dart';
import 'package:agents_app/views/manage-agent-employees/sections/operation_profile.dart';
import 'package:agents_app/views/manage-agent-employees/sections/payment_info.dart';
import 'package:agents_app/views/manage-agent-employees/sections/personal_info.dart';
import 'package:agents_app/views/manage-agent-employees/sections/personal_references.dart';
import 'package:agents_app/views/manage-agent-employees/widgets/position_modal.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/buttons/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageEmployeeAgentScreen extends StatefulWidget {
  const ManageEmployeeAgentScreen({super.key});

  @override
  ManageEmployeeAgentScreenState createState() =>
      ManageEmployeeAgentScreenState();
}

class ManageEmployeeAgentScreenState extends State<ManageEmployeeAgentScreen> {
  // Controller for managing employee data
  final controller = Get.put(EmployeeAgentController());
  final PositionModel? position = Get.arguments?['position'];
  // formkey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  start() async {
    await controller.genericListController.getAllAgency();
    await controller.genericListController.fetchEmployeeType();
    await controller.genericListController.fetchBank();
    await controller.genericListController.fetchHrProfile();
    await controller.genericListController.fetchEmployeeType();

    controller.isLoadingSupervisor.value = true;
    controller.supervisors.value = await controller.employeeDropdownService
        .fetchEmployees(EmployeeTypeDatabaseConstants
            .adviser); //! todo supervisor boss is not defined
    controller.isLoadingSupervisor.value = false;

    controller.isLoadingPerformanceDepartments.value = true;
    controller.performanceDepartments.value =
        await controller.genericListController.fetchDepartments();
    controller.isLoadingPerformanceDepartments.value = false;

    await controller.genericListController.fetchLicense();

    controller.isLoadingDepartmentHome.value = true;
    controller.departmentsHome.value =
        await controller.genericListController.fetchDepartments();
    controller.isLoadingDepartmentHome.value = false;

    controller.isLoadingResidenceDepartment.value = true;
    controller.residenceDepartments.value =
        await controller.genericListController.fetchDepartments();
    controller.isLoadingResidenceDepartment.value = false;

    await controller.genericListController.fetchCountries();

    controller.isLoadingMunicipalityOfBirth.value = true;
    controller.municipalitiesOfBirth.value =
        await controller.genericListController.fetchMunicipalities("null");
    controller.isLoadingMunicipalityOfBirth.value = false;

    await controller.genericListController.fetchProfessions();


    await controller.genericListController.fetchMaritalStatus();

    // await controller.genericListController.fetchDepartments();
    // await controller.genericListController.fetchZones();
    // await controller.genericListController.fetchIdentificationType();
    // await controller.genericListController.fetchMaritalStatus();

    // controller.contractTypeController.text =
    //     position == null ? "TEMPORAL" : "PERMANENTE";

    // print("Position---: ${position?.id}");
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
        title: 'Empleados',
        description: "Gestión de empleados",
        currentRoute: RouteConstants.manageAgent,
        userRole: 'admin',
        showBackButton: true,
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (position != null)
                  ContentCard(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                          width: 30,
                          color: Theme.of(context).colorScheme.primary,
                          text: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.work_outline),
                              SizedBox(width: 8),
                              Text('Información de la proseña'),
                            ],
                          ),
                          isLoading: false,
                          onPress: () {
                            showPositionModal(
                                context: context, position: position);
                          }),
                    ],
                  )),
                cardContentSpace(),
                jobInformation(context, controller, true),
                cardContentSpace(),
                cardContentSpace(),
                paymentInfoWidget(context, controller, true),
                cardContentSpace(),
                cardContentSpace(),
                bankInfoWidget(context, controller, true),
                cardContentSpace(),
                cardContentSpace(),
                rrhhProfile(context, controller, true),
                cardContentSpace(),
                cardContentSpace(),
                personalInfo(context, controller, true),
                cardContentSpace(),
                cardContentSpace(),
                contactInfo(context, controller, true),
                cardContentSpace(),
                cardContentSpace(),
                familyInfo(context, controller, true),
                cardContentSpace(),
                cardContentSpace(),
                personalReference(context, controller, true),
                cardContentSpace(),
                cardContentSpace(),
                imagesInfo(context, controller, true),
                cardContentSpace(),
                cardContentSpace(),
                FormButton(onPress: () {
                  print("Guardar empleado");
                  if (!formKey.currentState!.validate()) {
                    ToastService.warning(
                        title: "validación", subTitle: "Verifica los campos");
                    return;
                  }
                  controller.createEmployee();
                  Navigator.pop(context);
                })
              ],
            ),
          ),
        ));
  }
}
