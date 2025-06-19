import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageBranchScreen extends StatefulWidget {
  const ManageBranchScreen({super.key});

  @override
  ManageBranchScreenState createState() => ManageBranchScreenState();
}

class ManageBranchScreenState extends State<ManageBranchScreen> {
  final BranchController controller = Get.put(BranchController());

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
              CustomInputWidget(
                  controller: controller.codeGpController,
                  label: "Código GP",
                  hintText: "Ingrese el código GP",
                  prefixIcon: Icons.code)
            ],
          ),
        ),
      ),
    );
  }
}
