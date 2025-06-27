import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/database_constants.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/views/branches/sections/address.dart';
import 'package:agents_app/views/branches/sections/basic_info.dart';
import 'package:agents_app/views/branches/sections/complementary_info.dart';
import 'package:agents_app/views/branches/sections/turn_config.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
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
  final loader = Get.find<LoaderController>();
  final formKey = GlobalKey<FormState>();

  void start() async {
    await controller.groupController.fetchGroups();
    await controller.clientController.fetchClients();
    await controller.genericListController.fetchClassification();
    await controller.genericListController.fetchCountries();
    await controller.genericListController.fetchDepartments();
    await controller.genericListController.fetchZones();
    await controller.genericListController.fetchFactories();

    controller.isLoadingAdviser.value = true;
    controller.advisers.value = await controller.employeeDropdownService
        .fetchEmployees(EmployeeTypeDatabaseConstants.adviser);
    controller.isLoadingAdviser.value = false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      start();
    });
  }

  @override
  void dispose() {
    Get.delete<BranchController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ResponsiveSidebarLayout(
      title: "Administrar Sucursal",
      currentRoute: RouteConstants.branches,
      userRole: "admin",
      showBackButton: true,
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              basicInfo(controller),
              cardContentSpace(),
              complementaryInfo(controller),
              cardContentSpace(),
              ContentCard(
                child: Column(
                  children: [
                    physicalAddressSection(controller),
                  ],
                ),
              ),
              cardContentSpace(),
              ContentCard(child: turnConfiguration(colorScheme, controller)),
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
                          if (controller.turns.isEmpty) {
                            ToastService.warning(
                                title: "No se puede guardar",
                                subTitle: "No hay turnos configurados.");
                          }
                          if (!formKey.currentState!.validate()) {
                            ToastService.warning(
                                title: "Validación",
                                subTitle:
                                    "Por favor, complete todos los campos obligatorios.");
                            return;
                          }

                          loader.show();
                          await controller.createBranch();
                          loader.hide();
                          Navigator.pop(context);
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
