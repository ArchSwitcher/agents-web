
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

  Widget personalInformation(BuildContext context, EmployeeController controller) {
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
                child: CustomInputWidget(
                  controller: controller.firstNameController,
                  label: "Nombre",
                  hintText: "",
                  prefixIcon: Icons.person)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.middleNameController,
                  label: "Segundo Nombre",
                  hintText: "",
                  prefixIcon: Icons.person)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.lastNameController,
                  label: "Apellido",
                  hintText: "",
                  prefixIcon: Icons.person)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.secondLastNameController,
                  label: "Segundo Apellido",
                  hintText: "",
                  prefixIcon: Icons.person)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.genderController,
                  label: "Género",
                  hintText: "",
                  prefixIcon: Icons.transgender)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.birthDateController,
                  label: "Fecha de Nacimiento",
                  hintText: "",
                  prefixIcon: Icons.cake)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.idTypeController,
                  label: "Tipo de Identificación",
                  hintText: "",
                  prefixIcon: Icons.badge)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.identificationController,
                  label: "Identificación",
                  hintText: "",
                  prefixIcon: Icons.credit_card)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.nationalityController,
                  label: "Nacionalidad",
                  hintText: "",
                  prefixIcon: Icons.flag)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.bloodTypeController,
                  label: "Tipo de Sangre",
                  hintText: "",
                  prefixIcon: Icons.bloodtype)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.maritalStatusController,
                  label: "Estado Civil",
                  hintText: "",
                  prefixIcon: Icons.family_restroom)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.educationController,
                  label: "Educación",
                  hintText: "",
                  prefixIcon: Icons.school)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.languageController,
                  label: "Idioma",
                  hintText: "",
                  prefixIcon: Icons.language)),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.ethnicityController,
                  label: "Etnia",
                  hintText: "",
                  prefixIcon: Icons.people)),
          ],
        );
      }),
    );
  }