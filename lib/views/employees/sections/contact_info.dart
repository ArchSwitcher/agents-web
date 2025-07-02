
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/shared/helpers/validations/email_validator.dart';
import 'package:agents_app/shared/helpers/validations/phone_validator.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget contactInfo(BuildContext context, EmployeeController controller) {
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
      final isWideScreen = constraints.maxWidth > 750;
      final width = isWideScreen ? (constraints.maxWidth / 3) - 40 : constraints.maxWidth - 40;
    
      return Wrap(
        spacing: 30,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          SizedBox(width: width, child: CustomInputWidget(controller: controller.phoneController, label: "Teléfono", hintText: "", prefixIcon: Icons.phone, validator: (value) => phoneValidatorOptional(value),)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.mobileController, label: "Celular", hintText: "", prefixIcon: Icons.smartphone, validator: (value) => phoneValidatorOptional(value),)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.emailController, label: "Correo electrónico", hintText: "", prefixIcon: Icons.email, validator: (value) => emailValidatorOptional(value),)),
        ],
      );
    }),
  );
}