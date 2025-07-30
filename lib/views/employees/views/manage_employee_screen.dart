import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/database_constants.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
import 'package:agents_app/views/employees/sections/bank_info.dart';
import 'package:agents_app/views/employees/sections/contact_info.dart';
import 'package:agents_app/views/employees/sections/family_info.dart';
import 'package:agents_app/views/employees/sections/images_info.dart';
import 'package:agents_app/views/employees/sections/job_info.dart';
import 'package:agents_app/views/employees/sections/operation_profile.dart';
import 'package:agents_app/views/employees/sections/payment_info.dart';
import 'package:agents_app/views/employees/sections/personal_info.dart';
import 'package:agents_app/views/employees/sections/personal_references.dart';
import 'package:agents_app/views/manage-agent-employees/widgets/position_modal.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/buttons/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageEmployeeScreen extends StatefulWidget {
  const ManageEmployeeScreen({super.key});

  @override
  ManageEmployeeScreenState createState() => ManageEmployeeScreenState();
}

class ManageEmployeeScreenState extends State<ManageEmployeeScreen> {
  // Controller for managing employee data
  final controller = Get.put(ManageEmployeeController());
  // final editController = Get.put(EditEmployeeController());
  final LoaderController loaderController = Get.put(LoaderController());
  final PositionModel? position = Get.arguments?['position'];
  final String? employeeId = Get.arguments?['employeeId'];

  // formkey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyPersonal = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyOther = GlobalKey<FormState>();

  Future<void> start() async {
    try {
      // loaderController.show();
      print("ManageEmployeeScreenState start");
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
      await controller.genericListController.fetchIdentificationType();

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

      await controller.genericListController.fetchEmployeeClassifications();
      await controller.genericListController.fetchEductionLevel();

      // await controller.genericListController.fetchDepartments();
      // await controller.genericListController.fetchZones();
      // await controller.genericListController.fetchIdentificationType();
      // await controller.genericListController.fetchMaritalStatus();

      // controller.contractTypeController.text =
      //     position == null ? "TEMPORAL" : "PERMANENTE";

      // print("Position---: ${position?.id}");
      print("ManageEmployeeScreenState START 🛸 END");
    } catch (e) {
      print("objects: error in start: $e");
    } finally {
      // Hide the loader after all operations are done
      controller.genericListController.setLoadings(false);
      // loaderController.hide();
    }
  }

  Future<void> editData() async {
    try {
      loaderController.show();
      await start().then((_) async {
        await controller.setEmployeeValues(employeeId);
      });
      controller.genericListController.setLoadings(true);
      setState(() {});
    } catch (e) {
      print("error in editData: $e");
    } finally {
      controller.genericListController.setLoadings(false);
      loaderController.hide();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (employeeId == null) {
        start();
      }
      if (employeeId != null) {
        editData();
      }
    });
  }

  // @mustCallSuper
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

                if (employeeId != null) {
                  controller.updateEmployee();
                } else {
                  controller.createEmployee();
                }
                // controller.createEmployee();
                // Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}








//  DefaultTabController(
//               length: 3,
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.transparent,
//                     ),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: SizedBox(
//                         width: 600,
//                         child: TabBar(
//                           physics: const NeverScrollableScrollPhysics(),
//                           // controller: _tabController,
//                           dividerColor: Colors.transparent,
//                           isScrollable: false,
//                           indicator: BoxDecoration(
//                             color: colorScheme.primaryContainer,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           indicatorSize: TabBarIndicatorSize.tab,
//                           labelColor: Colors.white,
//                           labelPadding:
//                               const EdgeInsets.symmetric(horizontal: 12),
//                           tabs: [
//                             Tab(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: colorScheme.primaryContainer,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 16),
//                                 child: const Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(Icons.work, color: Colors.white),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       "RRHH",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Tab(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: colorScheme.primaryContainer,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 16),
//                                 child: const Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(Icons.person, color: Colors.white),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       "Datos Personales",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Tab(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: colorScheme.primaryContainer,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 16),
//                                 child: const Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(Icons.more_horiz, color: Colors.white),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       "Otros",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   SizedBox(
//                     height: Get.height - 352,
//                     child: TabBarView(
//                       physics: const NeverScrollableScrollPhysics(),
//                       children: [
//                         SingleChildScrollView(
//                           child: Form(
//                             key: formKeyRrhh,
//                             child: Column(children: [
//                               if (position != null)
//                                 ContentCard(
//                                     child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     CustomButton(
//                                         width: 30,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .primary,
//                                         text: const Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Icon(Icons.work_outline),
//                                             SizedBox(width: 8),
//                                             Text('Información de la proseña'),
//                                           ],
//                                         ),
//                                         isLoading: false,
//                                         onPress: () {
//                                           showPositionModal(
//                                               context: context,
//                                               position: position);
//                                         }),
//                                   ],
//                                 )),
//                               cardContentSpace(),
//                               jobInformation(context, controller, true),
//                               cardContentSpace(),
//                               cardContentSpace(),
//                               paymentInfoWidget(context, controller, true),
//                               cardContentSpace(),
//                               cardContentSpace(),
//                               bankInfoWidget(context, controller, true),
//                               cardContentSpace(),
//                               cardContentSpace(),
//                             ]),
//                           ),
//                         ),
//                         SingleChildScrollView(
//                           child: Form(
//                             key: formKeyPersonal,
//                             child: Column(children: [
//                               rrhhProfile(context, controller, true),
//                               cardContentSpace(),
//                               cardContentSpace(),
//                               personalInfo(context, controller, true),
//                               cardContentSpace(),
//                               cardContentSpace(),
//                               contactInfo(context, controller, true),
//                               cardContentSpace(),
//                               cardContentSpace(),
//                               familyInfo(context, controller, true),
//                               cardContentSpace(),
//                               cardContentSpace(),
//                             ]),
//                           ),
//                         ),
//                         SingleChildScrollView(
//                           child: Form(
//                             key: formKeyOther,
//                             child: Column(children: [
//                               personalReference(context, controller, true),
//                               cardContentSpace(),
//                               cardContentSpace(),
//                               imagesInfo(context, controller, true),
//                               cardContentSpace(),
//                               cardContentSpace(),
//                             ]),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),