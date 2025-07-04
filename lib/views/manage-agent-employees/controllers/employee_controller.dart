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
  TextEditingController selectedPosition = TextEditingController(text: "En proceso");
  

  // 🧍 Personal Information
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final secondLastNameController = TextEditingController();
  final genderController = TextEditingController();
  final birthDateController = TextEditingController();
  final idTypeController = TextEditingController(text: "DPI");
  final identificationController = TextEditingController();
  final nationalityController = TextEditingController(text: "Guatemalteca");
  final bloodTypeController = TextEditingController(text: "");
  final maritalStatusController = TextEditingController(text: "");
  final educationController = TextEditingController();
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
  Rx<DropDownOption>  positionEmployeeController =
      DropDownOption(id: "", label: "").obs;
  RxBool blueCardController = false.obs;
  final typeController = TextEditingController();
  final administrativeDepartmentController = TextEditingController();
  
  final hrProfileController = TextEditingController();

  final socialSecurityCodeController = TextEditingController();
  final paymentTypeController = TextEditingController();
  final companyController = TextEditingController(text: "EBANO");
  final agencyController = TextEditingController();
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
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    secondLastNameController.dispose();
    genderController.dispose();
    birthDateController.dispose();
    idTypeController.dispose();
    identificationController.dispose();
    nationalityController.dispose();
    bloodTypeController.dispose();
    maritalStatusController.dispose();
    educationController.dispose();
    languageController.dispose();
    ethnicityController.dispose();

    birthCountryController.value = DropDownOption(id: "", label: "");
    birthDepartmentController.value = DropDownOption(id: "", label: "");
    birthMunicipalityController.value = DropDownOption(id: "", label: "");
    addressDepartmentController.value = DropDownOption(id: "", label: "");
    addressMunicipalityController.value = DropDownOption(id: "", label: "");
    addressController.dispose();

    phoneController.dispose();
    mobileController.dispose();
    emailController.dispose();

    emergencyRelationshipController.value = DropDownOption(id: "", label: "");
    emergencyNameController.dispose();
    emergencyPhoneController.dispose();
    emergencyMobileController.dispose();

    internalCodeController.dispose();
    joinDateController.dispose();
    operationalProfileController.value = DropDownOption(id: "", label: "");
    hrProfileController.dispose();
    blueCardController.value = false;
    typeController.dispose();
    administrativeDepartmentController.dispose();
    positionController.dispose();
    socialSecurityCodeController.dispose();
    paymentTypeController.dispose();
    companyController.dispose();
    agencyController.dispose();
    payrollController.dispose();
    professionController.dispose();
    workplaceController.dispose();
    contractTypeController.dispose();
    hiringMethodController.dispose();
    workCountryController.dispose();
    workShiftController.dispose();
    baseSalaryController.dispose();
    decreeBonusController.dispose();

    driverLicenseTypeController.dispose();
    driverLicenseNumberController.dispose();
    gunPermitController.value = false;

    bankController.value = DropDownOption(id: "", label: "");
    accountNumberController.dispose();

    lifeInsuranceController.value = false;
    shootingPracticeController.dispose();
    graduationScoreController.dispose();
    referredByController.dispose();

    stateController.dispose();
    accessUserController.dispose();
    billableController.value = false;
    approvedByPaymentsController.value = false;

    mtPositionController.dispose();

    super.onClose();
  }

  get employeeValues {
    final PositionModel? position = Get.arguments?['position'];

    return EmployeeModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      contact: phoneController.text,
      sex: genderController.text,
      employeeTypeId: int.parse(positionEmployeeController.value.id),
      internalCode: internalCodeController.text,
      gender: genderController.text,
      birthDate: birthDateController.text,
      entryDate: joinDateController.text,
      identificationType: idTypeController.text,
      identificationNumber: identificationController.text,
      nationality: nationalityController.text,
      operationalProfile: operationalProfileController.value.label,
      rrhhProfile: hrProfileController.text,
      blueCard: blueCardController.value,
      type: typeController.text,
      driverLicenseType: driverLicenseTypeController.text,
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
      paymentType: paymentTypeController.text,
      company: companyController.text,
      agency: agencyController.text,
      bloodType: bloodTypeController.text,
      maritalStatus: maritalStatusController.text,
      lifeInsurance: lifeInsuranceController.value, //
      educationLevel: educationController.text,
      shootingPractice: shootingPracticeController.text,
      graduationNote: graduationScoreController.text,
      referredBy: referredByController.text,
      emergencyRelationship: emergencyRelationshipController.value.label,
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
      profession: professionController.text,
      positionSlot: positionEmployeeController.value.label,
      contractType: contractTypeController.text,
      howHired: hiringMethodController.text,
      workCountry: workCountryController.text,
      bank: bankController.value.label,
      accountNumber: accountNumberController.text,
      isPermanent: contractTypeController.text == "PERMANENT",
      titles: [],
      professions: [],
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
        // Optionally, you can reset the form or navigate to another screen
      }
    } catch (e) {
      print("Error creating employee: $e");
    }
  }
}
