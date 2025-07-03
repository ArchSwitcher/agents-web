import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/mocks/personal_info_mocks.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';

import 'package:agents_app/widgets/inputs/custom_dropdownv2_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:flutter/material.dart';

Widget personalInformation(
    BuildContext context, EmployeeController controller) {
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
                  label: "Primer nombre",
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
                child: CustomDropdownV2Widget(
                  labelText: "Género",
                  hintText: "",
                  items: genderMock.map<DropDownOption>((String value) {
                  return DropDownOption(
                    id: value,
                    label: value,
                  );
                  }).toList(),
                  validator: (p0) => null,
                  prefixIcon: const Icon(Icons.transgender),
                  textEditingController: controller.genderController,
                  onValueChanged: (v) {
                  controller.genderController.text = v!.label.toString();
                  })),
          SizedBox(
              width: width,
              child: CustomDatePicker(
                firstDate: DateTime(1900),
                  validator: (value) {
                    // Validate the date input and verify if the ages is greater than 18
                    if (value == null) {
                      return "Fecha de nacimiento es requerida";
                    }
                    DateTime? birthDate;
                    try {
                      birthDate = DateTime.parse(value);
                    } catch (e) {
                      return "Fecha de nacimiento inválida";
                    }
                    final age =
                        DateTime.now().difference(birthDate).inDays ~/ 365;
                    if (age < 18) {
                      return "El empleado debe ser mayor de 18 años";
                    }
                    return null;
                  },
                  initialDate: DateTime.now(),
                  controller: controller.birthDateController,
                  label: "Fecha de nacimiento",
                  hintText: "",
                  prefixIcon: Icons.cake)),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  enabled: false,
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
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Identificación es requerida";
                    }
                    final regex = RegExp(r'^\d{13}$');
                    if (!regex.hasMatch(value)) {
                      return "La identificación debe tener exactamente 13 dígitos numéricos";
                    }
                    return null;
                    },
                  prefixIcon: Icons.credit_card)),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  enabled: false,
                  controller: controller.nationalityController,
                  label: "Nacionalidad",
                  hintText: "",
                  prefixIcon: Icons.flag)),         
          SizedBox(
              width: width,
              child: CustomDropdownV2Widget(
                  labelText: "Tipo de sangre",
                  hintText: "",
                  items: bloodListMock.map<DropDownOption>((String value) {
                    return DropDownOption(
                      id: value,
                      label: value,
                    );
                  }).toList(),
                  validator: (p0) => null,
                  prefixIcon: const Icon(Icons.bloodtype),
                  textEditingController: controller.bloodTypeController,
                  onValueChanged: (v) {
                    controller.bloodTypeController.text = v!.label.toString();
                  })),
          SizedBox(
              width: width,
                child: CustomDropdownV2Widget(
                  labelText: "Estado Civil",
                  hintText: "",
                  items: civilStatusMock.map<DropDownOption>((String value) {
                  return DropDownOption(
                    id: value,
                    label: value,
                  );
                  }).toList(),
                  validator: (p0) => null,
                  prefixIcon: const Icon(Icons.family_restroom),
                  textEditingController: controller.maritalStatusController,
                  onValueChanged: (v) {
                    controller.maritalStatusController.text = v!.label.toString();
                  })),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  controller: controller.educationController,
                  label: "Educación",
                  hintText: "",
                  prefixIcon: Icons.school)),
          SizedBox(
              width: width,
                child: CustomDropdownV2Widget(
                  labelText: "Idioma",
                  hintText: "",
                  items: languageMock.map<DropDownOption>((String value) {
                  return DropDownOption(
                    id: value,
                    label: value,
                  );
                  }).toList(),
                  validator: (p0) => null,
                  prefixIcon: const Icon(Icons.language),
                  textEditingController: controller.languageController,
                  onValueChanged: (v) {
                  controller.languageController.text = v!.label.toString();
                  })),
          SizedBox(
              width: width,
                child: CustomDropdownV2Widget(
                  labelText: "Etnia",
                  hintText: "",
                  items: ethnicityMock.map<DropDownOption>((String value) {
                  return DropDownOption(
                    id: value,
                    label: value,
                  );
                  }).toList(),
                  validator: (p0) => null,
                  prefixIcon: const Icon(Icons.people),
                  textEditingController: controller.ethnicityController,
                  onValueChanged: (v) {
                  controller.ethnicityController.text = v!.label.toString();
                  })),
              SizedBox(width: width),
              SizedBox(width: width),
        ],
      );
    }),
  );
}
