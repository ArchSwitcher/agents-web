import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/branches/controller/branch_position_form_controller.dart';
import 'package:agents_app/widgets/buttons/form_button.dart';
import 'package:agents_app/widgets/inputs/custom_checkbox_label_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/image_upload_widget.dart';
import 'package:agents_app/widgets/inputs/start_rating_widget.dart';
import 'package:agents_app/widgets/inputs/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class BranchAgentsForm extends StatefulWidget {
  const BranchAgentsForm({super.key});

  @override
  BranchAgentsFormState createState() => BranchAgentsFormState();
}

class BranchAgentsFormState extends State<BranchAgentsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BranchPositionFormController controller =
      Get.put(BranchPositionFormController());

  start() async {
    await controller.fetchPositions();
    controller.initializeAgentControllers(controller.positions);
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _basicInfo(context, controller),
              cardContentSpace(),
              _agentsInfo(context, controller),
              cardContentSpace(),
              _buildCheckListEquipment(context, controller),
              cardContentSpace(),
              buildLastPart(context, controller),
              cardContentSpace(),
              _buildSignatureWidget(context, controller),
              cardContentSpace(),
              FormButton(
                  onPress: () {
                    if (_formKey.currentState!.validate() &&
                        controller.signatureController.isNotEmpty) {
                      controller.saveBranchPosition();
                    } else {
                      if (controller.signatureController.isEmpty) {
                        ToastService.warning(
                          title: "Validación",
                          subTitle: "Por favor, firme para continuar.",
                        );
                      }
                      ToastService.warning(
                          title: "Validación",
                          subTitle:
                              "Por favor, complete todos los campos requeridos.");
                    }
                  },
                  text: "Guardar"),
              cardContentSpace(),
              cardContentSpace(),
            ],
          ),
        ),
      ),
    );
  }
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
              child: Obx(() => CustomCheckboxLabelWidget(
                  icon: Icons.outbond,
                  isChecked: controller.requiresEvacuation.value,
                  onChanged: (value) {
                    controller.requiresEvacuation.value = value!;
                  },
                  label:
                      'Requiere Evacuación \n (Aplica únicamente a la Ciudad Capital)')),
            ),
            SizedBox(
                width: width,
                child: CustomInputWidget(
                    controller: controller.agencyController,
                    label: "Establecimiento",
                    hintText: "",
                    validator: (value) => notEmptyFieldValidator(value),
                    prefixIcon: Icons.business_center)),
          ]);
    }),
  );
}

Widget _agentsInfo(
    BuildContext context, BranchPositionFormController controller) {
  final colorscheme = Theme.of(context).colorScheme;
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
      final isWideScreen = constraints.maxWidth > 700;
      final width = isWideScreen
          ? (constraints.maxWidth / 4) - 40
          : constraints.maxWidth - 40;
      return Obx(() => Wrap(
            spacing: 30,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.start,
            direction: isWideScreen ? Axis.horizontal : Axis.vertical,
            children: [
              ...List.generate(controller.positions.length, (index) {
                final position = controller.positions[index];
                final imageController = controller.agentsController[index];

                return SizedBox(
                  width: width,
                  child: buildImageWidget(
                    position.id.toString(),
                    imageController.value,
                    Icon(Icons.security, color: colorscheme.surface),
                    position.name,
                    null,
                    (value) {
                      if (value == null) {
                        return 'Fotografía del agente es requerida';
                      }
                      return null;
                    },
                  ),
                );
              }),
              // Fotografía del Equipamiento
              SizedBox(
                width: width,
                child: buildImageWidget(
                    "20",
                    controller.equipmentController.value,
                    Icon(
                      Icons.security,
                      color: colorscheme.surface,
                    ),
                    "Fotografía del Equipamiento",
                    controller.equipmentController.value.link, (value) {
                  if (value == null) {
                    return 'Fotografía del equipamiento es requerida';
                  }
                  return null;
                }),
              ),
              ElevatedButton(
                onPressed: () {

                  controller.saveBranchPosition();
                  print("Submit button pressed");
                },
                child: Text('Submit'),
              ),

              SizedBox(
                width: width,
                child: buildImageWidget(
                    "3",
                    controller.groupAgentsController.value,
                    Icon(
                      Icons.group,
                      color: colorscheme.surface,
                    ),
                    "Foto grupal de agentes",
                    controller.groupAgentsController.value.link, (value) {
                  if (value == null) {
                    return 'Fotografía grupal de agentes es requerida';
                  }
                  return null;
                }),
              ),
            ],
          ));
    }),
  );
}

Widget _buildCheckListEquipment(
    BuildContext context, BranchPositionFormController controller) {
  // final colorscheme = Theme.of(context).colorScheme;
  return ContentCard(child: LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 700;
    final width = isWideScreen
        ? (constraints.maxWidth / 4) - 40
        : constraints.maxWidth - 40;
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
      children: List.generate(controller.equipmentItems.length, (index) {
        return SizedBox(
          width: width,
          child: Obx(() => CustomCheckboxLabelWidget(
                isChecked: controller.isCheckedList[index].value,
                onChanged: (value) =>
                    controller.isCheckedList[index].value = value ?? false,
                label: controller.equipmentItems[index],
                // icon: Icons.check_box,
              )),
        );
      }),
    );
  }));
}

Widget buildLastPart(
    BuildContext context, BranchPositionFormController controller) {
  return ContentCard(child: LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 700;
    final width = isWideScreen
        ? (constraints.maxWidth / 4) - 40
        : constraints.maxWidth - 40;
    return Wrap(
        spacing: 30,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        direction: isWideScreen ? Axis.horizontal : Axis.vertical,
        children: [
          SizedBox(
            width: width,
            child: CustomInputWidget(
                controller: controller.responsibleController,
                validator: (value) => notEmptyFieldValidator(value),
                label: "Nombre del responsable de Cassesa que entrega",
                hintText: "",
                prefixIcon: Icons.person),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              controller: controller.receiverControllerText,
              label: "Nombre de Gerente del Establecimiento que recibe",
              hintText: "",
              prefixIcon: Icons.person,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          Obx(() => SizedBox(
                width: width,
                child: StarRatingWidget(
                  rating: controller.currentRating.value,
                  onRatingChanged: (newRating) {
                    controller.currentRating.value = newRating.toInt();
                  },
                ),
              )),
        ]);
  }));
}

Widget _buildSignatureWidget(
    BuildContext context, BranchPositionFormController controller) {
  return ContentCard(child: LayoutBuilder(builder: (context, constraints) {
    return Column(
      children: [
        SizedBox(
          width: constraints.maxWidth - 100,
          // height: 300,
          child: Signature(
            controller: controller.signatureController,
            height: 300,
            backgroundColor: Colors.grey[200]!,
            width: double.infinity,
          ),
        ),
        ElevatedButton.icon(
            icon: Icon(Icons.clear),
            onPressed: () {
              controller.signatureController.clear();
            },
            label: Text("Limpiar firma"))
      ],
    );
  }));
}
