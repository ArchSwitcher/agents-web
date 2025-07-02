import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
 PositionController positionController = Get.put(PositionController());
 GenericListController genericListController = Get.put(GenericListController());

 
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
  Rx<DropDownOption> birthCountryController = DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> birthDepartmentController = DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> birthMunicipalityController = DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> addressDepartmentController = DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> addressMunicipalityController = DropDownOption(id: "", label: "").obs;
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
  final emergencyRelationshipController = TextEditingController();
  final emergencyNameController = TextEditingController();
  final emergencyPhoneController = TextEditingController();
  final emergencyMobileController = TextEditingController();

  // 🏢 Job Information
  final internalCodeController = TextEditingController();
  final joinDateController = TextEditingController();
  final operationalProfileController = TextEditingController();
  final hrProfileController = TextEditingController();
  final blueCardController = TextEditingController();
  final typeController = TextEditingController();
  final administrativeDepartmentController = TextEditingController();
  final positionEmployeeController = TextEditingController();
  final socialSecurityCodeController = TextEditingController();
  final paymentTypeController = TextEditingController();
  final companyController = TextEditingController();
  final agencyController = TextEditingController();
  final payrollController = TextEditingController();
  final professionController = TextEditingController();
  final workplaceController = TextEditingController();
  final contractTypeController = TextEditingController(text: "TEMPORAL");
  final hiringMethodController = TextEditingController();
  final workCountryController = TextEditingController();
  final workShiftController = TextEditingController();
  final baseSalaryController = TextEditingController();
  final decreeBonusController = TextEditingController();

  // 🚗 License & Weapon
  final driverLicenseTypeController = TextEditingController();
  final driverLicenseNumberController = TextEditingController();
  final gunPermitController = TextEditingController();

  // 💳 Financial Info
  final bankController = TextEditingController();
  final accountNumberController = TextEditingController();

  // 🧾 Additional Info
  final lifeInsuranceController = TextEditingController();
  final shootingPracticeController = TextEditingController();
  final graduationScoreController = TextEditingController();
  final referredByController = TextEditingController();

  // ⚙️ System Access / Status
  final stateController = TextEditingController();
  final accessUserController = TextEditingController();
  final billableController = TextEditingController();
  final approvedByPaymentsController = TextEditingController();

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

    emergencyRelationshipController.dispose();
    emergencyNameController.dispose();
    emergencyPhoneController.dispose();
    emergencyMobileController.dispose();

    internalCodeController.dispose();
    joinDateController.dispose();
    operationalProfileController.dispose();
    hrProfileController.dispose();
    blueCardController.dispose();
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
    gunPermitController.dispose();

    bankController.dispose();
    accountNumberController.dispose();

    lifeInsuranceController.dispose();
    shootingPracticeController.dispose();
    graduationScoreController.dispose();
    referredByController.dispose();

    stateController.dispose();
    accessUserController.dispose();
    billableController.dispose();
    approvedByPaymentsController.dispose();

    mtPositionController.dispose();

    super.onClose();
  }


}