import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:flutter/material.dart';

Widget paymentInfoWidget(
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
          // SizedBox(
          //   width: width,
          //   child: CustomInputWidget(
          //     enabled: enabled,
          //     controller: controller.baseSalaryController,
          //     label: "Sueldo base",
          //     hintText: "",
          //     prefixIcon: Icons.payment,
          //     keyboardType: TextInputType.number,
          //     validator: (value) => notEmptyFieldValidator(value),
          //     // onFocusChangeInput: (hasFocus) {
          //     //   if (!hasFocus) {
          //     //     controller.baseSalaryController.text =
          //     //         quetzalesCurrency(controller.baseSalaryController.text);
          //     //   }
          //     // },
          //   ),
          // ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.decreeBonusController,
              label: "Bonificación decreto",
              hintText: "",
              prefixIcon: Icons.payment,
              keyboardType: TextInputType.number,
              validator: (value) => notEmptyFieldValidator(value),
              // onFocusChangeInput: (hasFocus) {
              //   if (!hasFocus) {
              //     controller.baseSalaryController.text =
              //         quetzalesCurrency(controller.baseSalaryController.text);
              //   }
              // },
            ),
          ),

          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.payrollController,
              label: "Tipo de planilla",
              hintText: "",
              prefixIcon: Icons.payment,
              validator: (value) => notEmptyFieldValidator(value),
              // onFocusChangeInput: (hasFocus) {
              //   if (!hasFocus) {
              //     controller.baseSalaryController.text =
              //         quetzalesCurrency(controller.baseSalaryController.text);
              //   }
              // },
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.payrollOccupations2989Controller,
              label: "Ocupaciones Nómina 29-89",
              hintText: "",
              prefixIcon: Icons.payment,
              validator: (value) => notEmptyFieldValidator(value),
              // onFocusChangeInput: (hasFocus) {
              //   if (!hasFocus) {
              //     controller.baseSalaryController.text =
              //         quetzalesCurrency(controller.baseSalaryController.text);
              //   }
              // },
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.disabilityType2989ReportController,
              label: "Tipo discapacidad informe 29-89",
              hintText: "",
              prefixIcon: Icons.credit_score_sharp,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.salaryBaseMintrabTypeController,
              label: "Tipo Salario Mintrab",
              hintText: "",
              prefixIcon: Icons.payment,
              validator: (value) => notEmptyFieldValidator(value),
              // onFocusChangeInput: (hasFocus) {
              //   if (!hasFocus) {
              //     controller.baseSalaryController.text =
              //         quetzalesCurrency(controller.baseSalaryController.text);
              //   }
              // },
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.currentSalaryController,
              label: "Sueldo Actual",
              hintText: "",
              prefixIcon: Icons.payment,
              validator: (value) => notEmptyFieldValidator(value),
              // onFocusChangeInput: (hasFocus) {
              //   if (!hasFocus) {
              //     controller.baseSalaryController.text =
              //         quetzalesCurrency(controller.baseSalaryController.text);
              //   }
              // },
            ),
          ),

          SizedBox(
            width: width,
            child: CustomDatePicker(
                initialDate: DateTime(2025),
                controller: controller.currentSalaryDateController,
                enabled: enabled,
                label: "Fecha de sueldo actual",
                hintText: "",
                prefixIcon: Icons.date_range),
          ),
          SizedBox(
            width: width,
            child: CustomDatePicker(
                initialDate: DateTime(2025),
                controller: controller.previousSalaryDateController,
                enabled: enabled,
                label: "Fecha de sueldo anterior",
                hintText: "",
                prefixIcon: Icons.date_range),
          ),

          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.insuranceTypeController,
              label: "Tipo de seguro para cobro",
              hintText: "",
              prefixIcon: Icons.health_and_safety,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
        ],
      );
    }),
  );
}
