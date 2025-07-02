

import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget birthAddressInfo(BuildContext context, EmployeeController controller) {
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 750;
    final width = isWideScreen
        ? (constraints.maxWidth / 3) - 40
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
            controller: controller.birthCountryController,
            label: "País de nacimiento",
            hintText: "",
            prefixIcon: Icons.flag)),
        SizedBox(
          width: width,
          child: CustomInputWidget(
            controller: controller.birthDepartmentController,
            label: "Departamento de nacimiento",
            hintText: "",
            prefixIcon: Icons.map)),
        SizedBox(
          width: width,
          child: CustomInputWidget(
            controller: controller.birthMunicipalityController,
            label: "Municipio de nacimiento",
            hintText: "",
            prefixIcon: Icons.location_city)),
        SizedBox(
          width: width,
          child: CustomInputWidget(
            controller: controller.addressDepartmentController,
            label: "Departamento de residencia",
            hintText: "",
            prefixIcon: Icons.map)),
        SizedBox(
          width: width,
          child: CustomInputWidget(
            controller: controller.addressMunicipalityController,
            label: "Municipio de residencia",
            hintText: "",
            prefixIcon: Icons.home)),
        SizedBox(
          width: width,
          child: CustomInputWidget(
            controller: controller.addressController,
            label: "Dirección",
            hintText: "",
            prefixIcon: Icons.location_on)),
      ],
    );
    }),
  );

}