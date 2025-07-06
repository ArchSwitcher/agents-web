import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/branches/controller/branch_position_form_controller.dart';
import 'package:agents_app/widgets/inputs/custom_checkbox_label_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/image_upload_widget.dart';
import 'package:agents_app/widgets/inputs/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchAgentsForm extends StatefulWidget {
  const BranchAgentsForm({super.key});

  @override
  BranchAgentsFormState createState() => BranchAgentsFormState();
}

class BranchAgentsFormState extends State<BranchAgentsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BranchPositionFormController controller =
      Get.put(BranchPositionFormController());

  start() {
    controller.fetchPositions();
  }

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
      title: 'Entregar sucursal',
      description: 'Entregar sucursal con agentes',
      currentRoute: RouteConstants.branchPositionStay,
      userRole: 'admin',
      showBackButton: true,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            _basicInfo(context, controller),
            cardContentSpace(),
            _agentsInfo(context, controller),
          ],
        ),
      ),
    );
  }
}

Widget _agentsInfo(
    BuildContext context, BranchPositionFormController controller) {
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
      final isWideScreen = constraints.maxWidth > 700;
      final width = isWideScreen
          ? (constraints.maxWidth / 4) - 40
          : constraints.maxWidth - 40;
      return Wrap(
        spacing: 30,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        direction: isWideScreen ? Axis.horizontal : Axis.vertical,
        children: [
          SizedBox(
            width: width,
            child: CustomInputWidget(
                controller: controller.agencyController,
                label: "Agencia",
                hintText: "",
                prefixIcon: Icons.business),
          ),
        ],
      );
    }),
  );
}

Widget _basicInfo(
    BuildContext context, BranchPositionFormController controller) {
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
      final isWideScreen = constraints.maxWidth > 700;
      final width = isWideScreen
          ? (constraints.maxWidth / 4) - 40
          : constraints.maxWidth - 40;
      return Wrap(
          spacing: 30,
          runSpacing: 20,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          direction: isWideScreen ? Axis.horizontal : Axis.vertical,
          children: [
            SizedBox(
              width: width,
              child: CustomTimePicker(
                initialTime: controller.startTimeController.text.isNotEmpty
                    ? TimeOfDay(
                        hour: int.parse(
                            controller.startTimeController.text.split(":")[0]),
                        minute: int.parse(
                            controller.startTimeController.text.split(":")[1]),
                      )
                    : const TimeOfDay(hour: 0, minute: 0),
                controller: controller.startTimeController,
                label: 'Hora de inicio',
                hintText: 'Seleccione la hora',
                prefixIcon: Icons.access_time,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hora de inicio es requerida';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: width,
              child: CustomTimePicker(
                initialTime: controller.endTimeController.text.isNotEmpty
                    ? TimeOfDay(
                        hour: int.parse(
                            controller.endTimeController.text.split(":")[0]),
                        minute: int.parse(
                            controller.endTimeController.text.split(":")[1]),
                      )
                    : const TimeOfDay(hour: 0, minute: 0),
                controller: controller.endTimeController,
                label: 'Hora de fin',
                hintText: 'Seleccione la hora',
                prefixIcon: Icons.access_time,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hora de fin es requerida';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
                width: width,
                child: CustomInputWidget(
                    controller: controller.lugarPlaceController,
                    label: "Lugar de traslado",
                    hintText: "",
                    prefixIcon: Icons.location_on)),
            SizedBox(
              width: width,
              child: CustomCheckboxLabelWidget(
                  icon: Icons.outbond,
                  isChecked: true,
                  onChanged: (value) {},
                  label:
                      'Requiere Evacuación \n (Aplica únicamente a la Ciudad Capital)'),
            ),
            SizedBox(
                width: width,
                child: buildImageWidget("1", controller.letterController.value,
                    Icon(Icons.abc_rounded), "placeholder", null))
          ]);
    }),
  );
}
