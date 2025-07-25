import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/manage-agent-employees/services/employee_agent_service.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeAgentController extends GetxController {
  PositionController positionController = Get.put(PositionController());
  GenericListController genericListController =
      Get.put(GenericListController());
  EmployeeAgentService employeeService = EmployeeAgentService();

  // manage-employees-screen
  TextEditingController selectedPosition =
      TextEditingController(text: "En proceso");

  // 🧍 Personal Information
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final secondLastNameController = TextEditingController();
  final genderController = TextEditingController();
  final birthDateController = TextEditingController();
  // final idTypeController = TextEditingController(text: "DPI");
  final identificationType = Rx<DropDownOption>(
    DropDownOption(id: "", label: ""),
  );
  final identificationController = TextEditingController();
  RxBool nationalityController = false.obs;
  Rx<DropDownOption> bloodTypeController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> maritalStatusController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> educationController = 
      DropDownOption(id: "", label: "").obs;
  final languageController = TextEditingController();
  final ethnicityController = TextEditingController();

  // 🏠 Birth and Address Info DropDownOption
  Rx<DropDownOption> birthCountryController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> birthDepartmentController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> birthMunicipalityController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> addressDepartmentController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> addressMunicipalityController =
      DropDownOption(id: "", label: "").obs;
  final addressController = TextEditingController();
  // 🏠 Birth and Address Info Observables
  RxBool isLoadingBirthMunicipalities = false.obs;
  RxList<DropDownOption> birthMunicipalities = <DropDownOption>[].obs;
  RxBool isLoadingAddressMunicipalities = false.obs;
  RxList<DropDownOption> addressMunicipalities = <DropDownOption>[].obs;

  // ☎️ Contact Info
  final phoneController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  // 🚨 Emergency Contact
  // final emergencyRelationshipController = TextEditingController();
  Rx<DropDownOption> emergencyRelationshipController =
      DropDownOption(id: "", label: "").obs;
  final emergencyNameController = TextEditingController();
  final emergencyPhoneController = TextEditingController();
  final emergencyMobileController = TextEditingController();

  // 🏢 Job Information
  final internalCodeController = TextEditingController();
  final joinDateController = TextEditingController();
  Rx<DropDownOption> operationalProfileController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> positionEmployeeController =
      DropDownOption(id: "", label: "").obs;
  RxBool blueCardController = false.obs;
  final typeController = TextEditingController();
  final administrativeDepartmentController = TextEditingController();

  final hrProfileController = TextEditingController();

  final socialSecurityCodeController = TextEditingController();
  final paymentTypeController = TextEditingController();
  final companyController = TextEditingController(text: "EBANO");
  Rx<DropDownOption> agencyController = 
      DropDownOption(id: "", label: "").obs;
  final payrollController = TextEditingController();
  final professionController = TextEditingController();
  final workplaceController = TextEditingController();
  final contractTypeController = TextEditingController();
  final hiringMethodController = TextEditingController();
  final workCountryController = TextEditingController();
  final workShiftController = TextEditingController();
  final baseSalaryController = TextEditingController();
  final decreeBonusController = TextEditingController();

  // 🚗 License & Weapon
  final driverLicenseTypeController = TextEditingController();
  final driverLicenseNumberController = TextEditingController();
  RxBool gunPermitController = false.obs;

  // 💳 Financial Info
  Rx<DropDownOption> bankController = DropDownOption(id: "", label: "").obs;
  final accountNumberController = TextEditingController();

  // 🧾 Additional Info
  RxBool lifeInsuranceController = false.obs;
  final shootingPracticeController = TextEditingController();
  final graduationScoreController = TextEditingController();
  final referredByController = TextEditingController();

  // ⚙️ System Access / Status
  final stateController = TextEditingController(text: "ALTA");
  final accessUserController = TextEditingController();
  RxBool billableController = false.obs;
  RxBool approvedByPaymentsController = false.obs;

  // 🛠 MT Position
  final mtPositionController = TextEditingController();

  @override
  void onClose() {
    // Dispose each controller here
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    secondLastNameController.clear();
    genderController.clear();
    birthDateController.clear();
    identificationType.value = DropDownOption(id: "", label: "");
    identificationController.clear();
    nationalityController.value = false;
    bloodTypeController.value = DropDownOption(id: "", label: "");
    maritalStatusController.value = DropDownOption(id: "", label: "");
    educationController.value = DropDownOption(id: "", label: "");;
    languageController.clear();
    ethnicityController.clear();

    birthCountryController.value = DropDownOption(id: "", label: "");
    birthDepartmentController.value = DropDownOption(id: "", label: "");
    birthMunicipalityController.value = DropDownOption(id: "", label: "");
    addressDepartmentController.value = DropDownOption(id: "", label: "");
    addressMunicipalityController.value = DropDownOption(id: "", label: "");
    addressController.clear();

    phoneController.clear();
    mobileController.clear();
    emailController.clear();

    emergencyRelationshipController.value = DropDownOption(id: "", label: "");
    emergencyNameController.clear();
    emergencyPhoneController.clear();
    emergencyMobileController.clear();

    internalCodeController.clear();
    joinDateController.clear();
    operationalProfileController.value = DropDownOption(id: "", label: "");
    hrProfileController.clear();
    blueCardController.value = false;
    typeController.clear();
    administrativeDepartmentController.clear();
    // positionController.dispose();
    socialSecurityCodeController.clear();
    paymentTypeController.clear();
    companyController.clear();
    agencyController.value = DropDownOption(id: "", label: "");
    payrollController.clear();
    professionController.clear();
    workplaceController.clear();
    contractTypeController.clear();
    hiringMethodController.clear();
    workCountryController.clear();
    workShiftController.clear();
    baseSalaryController.clear();
    decreeBonusController.clear();

    driverLicenseTypeController.clear();
    driverLicenseNumberController.clear();
    gunPermitController.value = false;

    bankController.value = DropDownOption(id: "", label: "");
    accountNumberController.clear();

    lifeInsuranceController.value = false;
    shootingPracticeController.clear();
    graduationScoreController.clear();
    referredByController.clear();

    stateController.clear();
    accessUserController.clear();
    billableController.value = false;
    approvedByPaymentsController.value = false;

    mtPositionController.clear();

    super.onClose();
  }

  get employeeValues {
    final PositionModel? position = Get.arguments?['position'];
    print("Position: ${position == null ? 'null' : position.id}");

    return EmployeeModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      contact: phoneController.text,
      sex: genderController.text,
      employeeTypeId: int.parse(positionEmployeeController.value.id),
      internalCode: internalCodeController.text,
      birthDate: birthDateController.text,
      entryDate: joinDateController.text,
      identificationTypeId: int.parse(identificationType.value.id),
      identificationNumber: identificationController.text,
      nationality: nationalityController.value,
      operationalProfileId:
          int.parse(operationalProfileController.value.id), //--DD
      rrhhProfile: hrProfileController.text,
      blueCard: blueCardController.value,
      // type: typeController.text, // REMOVE THIS
      licenseTypeId: int.parse(driverLicenseTypeController.text), //--DD
      driverLicenseNumber: driverLicenseNumberController.text,
      gunCarryPermit: gunPermitController.value, //
      administrativeDepartment: administrativeDepartmentController.text,
      position: position == null
          ? null
          : PositionEmployee(
              positionId: int.parse(position.id!),
              isPrincipal: true,
              isActive: true),
      socialSecurityCode: socialSecurityCodeController.text,
      phone: phoneController.text,
      address: addressController.text,
      email: emailController.text,
      paymentTypeId: int.parse(paymentTypeController.text), //--DD
      previousCompanyId: int.parse(companyController.text), //--DD
      agencyId: int.parse(agencyController.value.id), //--DD
      bloodTypeId: int.parse(bloodTypeController.value.id),
      maritalStatusId: int.parse(maritalStatusController.value.id),
      lifeInsurance: lifeInsuranceController.value, //
      educationLevelId: int.parse(educationController.value.id), //--DD
      shootingPracticeDate: shootingPracticeController.text,
      graduationScore: double.tryParse(graduationScoreController.text) ?? 0.0,
      referredBy: referredByController.text,
      emergencyRelationshipId:
          int.parse(emergencyRelationshipController.value.id), //--DD
      emergencyName: emergencyNameController.text,
      emergencyPhone: emergencyPhoneController.text,
      emergencyMobile: emergencyMobileController.text,
      accessUser: accessUserController.text,
      availableForBilling: billableController.value, //
      approvedByPayments: approvedByPaymentsController.value, //
      mobile: mobileController.text,
      language: languageController.text,
      ethnicity: ethnicityController.text,
      mtPosition: mtPositionController.text,
      birthCountry: birthCountryController.value.label,
      birthDepartment: birthDepartmentController.value.label,
      birthMunicipality: birthMunicipalityController.value.label,
      workSchedule: workShiftController.text,
      baseSalary: double.parse(baseSalaryController.text),
      decreeBonus: double.parse(decreeBonusController.text),
      residenceDepartment: addressDepartmentController.value.label,
      residenceMunicipality: addressMunicipalityController.value.label,
      payroll: payrollController.text,
      // educationLevelId: professionController.text,
      positionSlot: positionEmployeeController.value.label,
      contractType: contractTypeController.text,
      hireDate: hiringMethodController.text, // UPDATE
      workCountry: workCountryController.text,
      bankId: int.parse(bankController.value.id), //--DD
      accountNumber: accountNumberController.text,
      isPermanent: contractTypeController.text == "PERMANENT",
    );
  }

  void createEmployee() async {
    try {
      final employee = employeeValues;
      print("Creating employee with values: ${employee.toJson()}");
      final result = await employeeService.create(employee);
      if (result) {
        ToastService.success(
            title: "Empleado", subTitle: "Empleado creado exitosamente");
      }
    } catch (e) {
      print("Error creating employee: $e");
    }
  }
}
