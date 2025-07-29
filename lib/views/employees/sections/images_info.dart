import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
import 'package:agents_app/views/employees/widgets/modal_courses.dart';
import 'package:agents_app/views/employees/widgets/modal_criminal_records.dart';
import 'package:agents_app/views/employees/widgets/modal_police_records.dart';
import 'package:agents_app/views/employees/widgets/modal_shooting_practice.dart';
import 'package:agents_app/views/employees/widgets/modal_vacation_status.dart';
import 'package:agents_app/widgets/inputs/image_upload_widget.dart';
import 'package:flutter/material.dart';

Widget imagesInfo(
    BuildContext context, EmployeeAgentController controller, bool enabled) {
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
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
            child: ElevatedButton.icon(
                onPressed: () {
                  showCoursesModal(context: context, controller: controller);
                },
                label: const Text("Agregar curso"),
                icon: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary)),
          ),
          SizedBox(
            width: width,
            child: ElevatedButton.icon(
                onPressed: () {
                  showCriminalModal(context: context, controller: controller);
                },
                label: const Text("Antecedentes policiales"),
                icon: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary)),
          ),
          SizedBox(
            width: width,
            child: ElevatedButton.icon(
                onPressed: () {
                  showPoliceRecordModal(
                      context: context, controller: controller);
                },
                label: const Text("Antecedentes penales"),
                icon: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary)),
          ),
          SizedBox(
            width: width,
            child: ElevatedButton.icon(
                onPressed: () {
                  showShootingPracticesModal(
                      context: context, controller: controller);
                },
                label: const Text("Practica de tiro"),
                icon: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary)),
          ),
          SizedBox(
            width: width,
            child: ElevatedButton.icon(
                onPressed: () {
                  showVacationStatusModal(
                      context: context, controller: controller);
                },
                label: const Text("Estado de vacaciones"),
                icon: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary)),
          ),
          SizedBox(
            width: width,
            child: LogoUploadWidget(
                height: 40,
                uploadImageController: controller.employeePhoto,
                text: "Foto del empleado",
                // validator: (value) {
                //   if (value == null) {
                //     return "Por favor, sube una foto del empleado";
                //   }
                //   return null;
                // },
                validator: (value) => null,
                enabled: enabled),
          ),
        ],
      );
    }),
  );
}
