import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/views/employees/sections/additional_info.dart';
import 'package:agents_app/views/employees/sections/birth_address_info.dart';
import 'package:agents_app/views/employees/sections/contact_info.dart';
import 'package:agents_app/views/employees/sections/emergency_contact.dart';
import 'package:agents_app/views/employees/sections/finance_information.dart';
import 'package:agents_app/views/employees/sections/job_information.dart';
import 'package:agents_app/views/employees/sections/licence_weapon.dart';
import 'package:agents_app/views/employees/sections/personal_information.dart';
import 'package:agents_app/views/employees/sections/system_access_status.dart';
import 'package:agents_app/widgets/buttons/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ManageEmployeeScreen extends StatefulWidget {
  const ManageEmployeeScreen({ super.key });

  @override
  ManageEmployeeScreenState createState() => ManageEmployeeScreenState();
}

class ManageEmployeeScreenState extends State<ManageEmployeeScreen> {
  // Controller for managing employee data
  final controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
        title: 'Empleados',
        description: "Gestión de empleados",
        currentRoute: RouteConstants.employees,
        userRole: 'admin',
        content: SingleChildScrollView(
          child: Column(
            children: [
              cardContentSpace(),
              personalInformation(context, controller),
              cardContentSpace(),
              birthAddressInfo(context, controller),
              cardContentSpace(),
              contactInfo(context, controller),
              cardContentSpace(),
              buildEmergencyContact(context, controller),
              cardContentSpace(),
              jobInformation(context, controller),
              cardContentSpace(),
              licenceWeapon(context, controller),
              cardContentSpace(),
              financialMITInformation(context, controller),
              cardContentSpace(),
              additionalInfo(context, controller),
              cardContentSpace(),
              systemAccessStatus(context, controller),
              cardContentSpace(),
              cardContentSpace(),
              FormButton(onPress: () {
                print("Guardar empleado");
              })
            ],
          ),
        ));
  }
}