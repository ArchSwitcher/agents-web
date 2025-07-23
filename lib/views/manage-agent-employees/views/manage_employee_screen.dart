import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
// import 'package:agents_app/views/manage-agent-employees/sections/additional_info.dart';
import 'package:agents_app/views/manage-agent-employees/sections/birth_address_info.dart';
import 'package:agents_app/views/manage-agent-employees/sections/contact_info.dart';
// import 'package:agents_app/views/manage-agent-employees/sections/emergency_contact.dart';
// import 'package:agents_app/views/manage-agent-employees/sections/finance_information.dart';
// import 'package:agents_app/views/manage-agent-employees/sections/job_information.dart';
// import 'package:agents_app/views/manage-agent-employees/sections/licence_weapon.dart';
import 'package:agents_app/views/manage-agent-employees/sections/personal_information.dart';
// import 'package:agents_app/views/manage-agent-employees/sections/system_access_status.dart';
import 'package:agents_app/views/manage-agent-employees/widgets/position_modal.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/buttons/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageEmployeeAgentScreen extends StatefulWidget {
  const ManageEmployeeAgentScreen({super.key});

  @override
  ManageEmployeeAgentScreenState createState() => ManageEmployeeAgentScreenState();
}

class ManageEmployeeAgentScreenState extends State<ManageEmployeeAgentScreen> {
  // Controller for managing employee data
  final controller = Get.put(EmployeeAgentController());
  final PositionModel? position = Get.arguments?['position'];
  // formkey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  start() async {
    await controller.genericListController.fetchCountries();
    await controller.genericListController.fetchDepartments();
    await controller.genericListController.fetchZones();
    controller.contractTypeController.text =
        position == null ? "TEMPORAL" : "PERMANENTE";
    
    print("Position---: ${position?.id}");
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
                          text: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.work_outline,
                                  color: Theme.of(context).colorScheme.surface),
                              const SizedBox(width: 8),
                              Text(
                                'Información de la posición',
                                style: CustomStyle.textStyleWhite(context),
                              ),
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
                personalInformation(context, controller),
                cardContentSpace(),
                birthAddressInfo(context, controller),
                cardContentSpace(),
                contactInfo(context, controller),
                cardContentSpace(),
                // buildEmergencyContact(context, controller),
                cardContentSpace(),
                // jobInformation(context, controller),
                cardContentSpace(),
                // licenceWeapon(context, controller),
                cardContentSpace(),
                // financialMITInformation(context, controller),
                cardContentSpace(),
                // additionalInfo(context, controller),
                cardContentSpace(),
                // systemAccessStatus(context, controller),
                cardContentSpace(),
                cardContentSpace(),
                FormButton(onPress: () {
                  print("Guardar empleado");
                  if (!formKey.currentState!.validate()) {
                    ToastService.warning(title: "validación", subTitle: "Verifica los campos");
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
