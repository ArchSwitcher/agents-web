import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget systemAccessStatus(BuildContext context, EmployeeAgentController controller) {
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
      final isWideScreen = constraints.maxWidth > 750;
      final width = isWideScreen ? (constraints.maxWidth / 4) - 40 : constraints.maxWidth - 40;
    
      return Wrap(
        spacing: 30,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          SizedBox(width: width, child: CustomInputWidget(controller: controller.stateController, label: "Estado", hintText: "", prefixIcon: Icons.toggle_on, enabled: false,)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.accessUserController, label: "Usuario de Acceso", hintText: "", prefixIcon: Icons.person)),
          SizedBox(
            width: width,
            child: Row(
              children: [
                const Icon(Icons.attach_money),
                const SizedBox(width: 10),
                const Text("¿Facturable?"),
                const SizedBox(width: 10),
                Obx(() => Checkbox(
                  value: controller.billableController.value,
                  onChanged: (value) {
                    controller.billableController.value = value!;
                  },
                  checkColor: Theme.of(context).colorScheme.surface,
                )),
              ],
            ),
          ),
          SizedBox(
            width: width,
            child: Row( 
              children: [
                const Icon(Icons.approval),
                const SizedBox(width: 10),
                const Text("¿Aprobado por Pagos?"),
                const SizedBox(width: 10),
                Obx(() => Checkbox(
                  value: controller.approvedByPaymentsController.value,
                  checkColor: Theme.of(context).colorScheme.surface,
                  onChanged: (value) {
                    controller.approvedByPaymentsController.value = value!;
                  },
                )),
              ],
            ),
          ),
        ],
      );
    }),
  );
}