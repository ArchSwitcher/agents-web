import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:agents_app/widgets/inputs/image_picker_button.dart';
import 'package:flutter/material.dart';

void showCoursesModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Agregar curso al empleado",
  bool isEdit = true,
  required EmployeeAgentController controller,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: ModalCourses(controller: controller),
      onAccept: () async {},
      onCancel: () {},

      title: title,
      subtitle: description,
      acceptText: "Agregar",
      cancelText: "Cerrar",
      // showAcceptButton: true,
    ),
  );
}

class ModalCourses extends StatefulWidget {
  final EmployeeAgentController controller;

  const ModalCourses({Key? key, required this.controller}) : super(key: key);

  @override
  _ModalCoursesState createState() => _ModalCoursesState();
}

class _ModalCoursesState extends State<ModalCourses> {

  @override
  void initState() {
    // widget.controller.courseImageController.updateBase64String(newBase64String)
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 800,
            child: ImagePickerButton(
                uploadImageController: widget.controller.courseImageController,
                text: "Curso",
                validator: null),
          ),
          Row(
            children: [
              SizedBox(
                width: 400,
                child: CustomDatePicker(
                    initialDate: DateTime(2025),
                    controller: widget.controller.dateCourseController,
                    enabled: true,
                    label: "Fecha del curso",
                    hintText: "",
                    prefixIcon: Icons.date_range),
              ),
              const SizedBox(width: 30),
              SizedBox(
                width: 400,
                child: CustomInputWidget(
                    controller: widget.controller.descriptionCourseController,
                    label: "Descripción del curso",
                    hintText: "",
                    prefixIcon: Icons.description),
              )
            ],
          ),
          const Divider(),
          widget.controller.courses.isEmpty
              ? const Text("No hay cursos agregados")
              : Column(children: [
                const Text("Cursos Agregados:"),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.controller.courses.length,
                  itemBuilder: (context, index) {
                    final course = widget.controller.courses[index];
                    return ListTile(
                      title: Text(course.description!.value),
                      subtitle: Text(course.date.toString()),
                      leading: Image.network(course.documentUrl!.value,
                          width: 100, height: 100),
                    );
                  },
                )
              ]),
          const Divider()
        ],
      ),
    );
  }
}
