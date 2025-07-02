import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:flutter/material.dart';

Widget jobInformation(BuildContext context, EmployeeController controller) {
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
            SizedBox(width: width, child: CustomInputWidget(controller: controller.internalCodeController, label: "Código Interno", hintText: "", prefixIcon: Icons.code)),
            SizedBox(
            width: width,
            child: CustomDatePicker(
              validator: (value) {
              if (value == null) {
                return "Fecha de inicio es requerida";
              }
              return null;
              },
              initialDate: DateTime.now(),
              controller: controller.joinDateController,
              label: "Fecha de inicio",
              hintText: "",
              prefixIcon: Icons.calendar_today,
            ),
            ),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.operationalProfileController, label: "Perfil Operacional", hintText: "", prefixIcon: Icons.person_outline)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.hrProfileController, label: "Perfil RH", hintText: "", prefixIcon: Icons.people)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.blueCardController, label: "Tarjeta Azul", hintText: "", prefixIcon: Icons.card_membership)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.typeController, label: "Tipo", hintText: "", prefixIcon: Icons.category)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.administrativeDepartmentController, label: "Departamento Administrativo", hintText: "", prefixIcon: Icons.business)), // should be a dropdown
          SizedBox(width: width, child: CustomInputWidget(controller: controller.positionEmployeeController, label: "Cargo Empleado", hintText: "", prefixIcon: Icons.work)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.socialSecurityCodeController, label: "Código Seguridad Social", hintText: "", prefixIcon: Icons.security)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.paymentTypeController, label: "Tipo de Pago", hintText: "", prefixIcon: Icons.payment)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.companyController, label: "Compañía", hintText: "", prefixIcon: Icons.apartment)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.agencyController, label: "Agencia", hintText: "", prefixIcon: Icons.location_city)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.payrollController, label: "Nómina", hintText: "", prefixIcon: Icons.receipt)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.professionController, label: "Profesión", hintText: "", prefixIcon: Icons.school)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.workplaceController, label: "Lugar de Trabajo", hintText: "", prefixIcon: Icons.location_on)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.contractTypeController, label: "Tipo de Contrato", hintText: "", prefixIcon: Icons.description)), // should be a dropdown
          SizedBox(width: width, child: CustomInputWidget(controller: controller.hiringMethodController, label: "Método de Contratación", hintText: "", prefixIcon: Icons.how_to_reg)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.workCountryController, label: "País de Trabajo", hintText: "", prefixIcon: Icons.public)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.workShiftController, label: "Turno de Trabajo", hintText: "", prefixIcon: Icons.schedule)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.baseSalaryController, label: "Salario Base", hintText: "", prefixIcon: Icons.attach_money)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.decreeBonusController, label: "Bono Decreto", hintText: "", prefixIcon: Icons.military_tech)),
    
        ],
      );
    }),
  );
}