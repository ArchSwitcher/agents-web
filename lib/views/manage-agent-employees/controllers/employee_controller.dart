import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/common/image_model.dart';
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/services/employee_dropdown_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/services/upload_file.dart';
import 'package:agents_app/views/manage-agent-employees/services/employee_agent_service.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeAgentController extends GetxController {
  bool rrhForm = false;
  bool personalForm = false;
  bool otherForm = false;

  PositionController positionController = Get.put(PositionController());
  GenericListController genericListController =
      Get.put(GenericListController());
  EmployeeAgentService employeeService = EmployeeAgentService();
  EmployeeDropdownService employeeDropdownService = EmployeeDropdownService();
  UploadFileService uploadFileService = UploadFileService();

  get employeeValues {
    EmployeeModel employee = EmployeeModel(
        agencyId: int.parse(agencyController.value.id),
        employeeTypeId: int.parse(employeeTypeController.value.id),
        contractType: contractTypeController.text,
        contractTermType: contractTypeTermController.text,
        contractTime: DateTime.parse(contractTimeController.text),
        hireDate: DateTime.parse(startDateController.text),
        workSchedule: workScheduleController.text,
        costCenter: costCenterController.text,
        maritalStatusId: int.parse(maritalStatusController.value.id),
        // Datos Salariales
        entryReason: entryReasonController.text,
        decreeBonus: double.tryParse(decreeBonusController.text) ?? 0.0,
        payroll: payrollController.text,
        payrollOccupations2989: payrollOccupations2989Controller.text,
        disabilityType2989Report: disabilityType2989ReportController.text,
        salaryBaseMintrabType: salaryBaseMintrabTypeController.text,
        currentSalary: double.tryParse(currentSalaryController.text) ?? 0.0,
        currentSalaryDate: DateTime.parse(currentSalaryDateController.text),
        previousSalaryDate: DateTime.parse(previousSalaryDateController.text),
        lifeInsurance: insuranceTypeController.text,
        // bank info
        bankId: int.parse(bankController.value.id),
        bankAccountType: accTypeBankController.text,
        paymentMethod: paymentMethodController.text,
        accountNumber: accNumberBankController.text,
        birthMunicipalityId: int.parse(municipalityOfBirthController.value.id),
        performanceDepartmentId:
            int.parse(performanceDepartmentController.value.id),
        // Perfil Operativo / RRHH
        hrProfileId: int.parse(hrProfileController.value.id),
        employeeClassificationId: int.parse(classificationController.value.id),
        supervisorWorkerId: int.parse(supervisorController.value.id),
        performanceMunicipality:
            int.parse(performanceMunicipalityController.value.id),
        mintrabPerformanceRegion: mintrabPerformanceRegionController.text,
        mintrabBirthRegion: mintrabBirthRegionController.text,
        mtPosition: positionMtController.text,
        digesspPosition: digesspPositionController.text,
        positionSlot: positionSlotController.text,
        companyEmail: companyEmailController.text,
        socialSecurityCode: igssController.text,
        cvh: cvhController.text,
        // Información Personal
        firstName: firstNameController.text,
        middleName: middleNameController.text,
        lastName: lastNameController.text,
        secondLastName: secondLastNameController.text,
        marriedLastName: marriedLastNameController.text,
        birthDate: DateTime.parse(birthDateController.text),
        gender: genderController.text,
        nationality: nationalityController.value,
        identificationTypeId: int.parse(identificationTypeController.value.id),
        identificationNumber: identificationController.text,
        identificationIssueDate:
            DateTime.parse(identificationIssueDateController.text),
        identificationEndDate:
            DateTime.parse(identificationEndDateController.text),
        licenseTypeId: int.parse(licenseTypeController.value.id),
        driverLicenseNumber: licenseController.text,
        taxIdNumber: nitController.text,
        educationLevelId: int.parse(educationLevelController.value.id),
        ethnicity: ethnicityController.text,
        language: languageController.text,
        professionId: int.parse(professionController.value.id),
        // ------------------------
        email: emailController.text,
        mobile: mobileController.text,
        cityHome: cityController.text,
        address: addressController.text,
        departmentHomeId: int.parse(departmentHomeController.value.id),
        municipalityHomeId: int.parse(municipalityHomeController.value.id),
        birthCountryId: int.parse(countryOfBirthController.value.id),
        numberOfChildren: int.tryParse(numberOfChildrenController.text) ?? 0,
        emergencyContactName: emergencyNameController.text,
        emergencyPhone: emergencyContactController.text,
        residenceDepartmentId:
            int.parse(residenceDepartmentController.value.id),
        residenceMunicipalityId:
            int.parse(residenceMunicipalityController.value.id),
        referenceName1: referenceName1.text,
        referencePhone1: referencePhone1.text,
        referenceName2: referenceName2.text,
        referencePhone2: referencePhone2.text,
        referenceName3: referenceName3.text,
        referencePhone3: referencePhone3.text,
        position: null,
        semiannualPolygraphResult: double.tryParse(semiannualPolygraphResultController.text) ?? 0.0,
        dateOfLastPolygraphTest: dateOfLastPolygraphTestController.text.isEmpty ? null : DateTime.parse(dateOfLastPolygraphTestController.text),
        // images loader

        //! has left all SimpleEntity values

        );

    return employee;
  }

  Future<void> createEmployee() async {
    try {
      EmployeeModel employee = employeeValues;

      if (courseImageController.base64 != null) {
        final courseLink = await uploadFileService.uploadPhotoWebFromBase64(
            base64String: courseImageController.base64!,
            fileName: 'course.png',
            mimeType: 'image/png',
            folder: 'courses');

        employee.courses = [
          DocumentsEmployee(
            date: RxString(dateCourseController.text),
            description: RxString(descriptionCourseController.text),
            documentUrl: RxString(courseLink!),
          )
        ];
      }

      if (shootingPracticeImageController.base64 != null) {
        final shootingPracticeLink =
            await uploadFileService.uploadPhotoWebFromBase64(
                base64String: shootingPracticeImageController.base64!,
                fileName: 'shooting_practice.png',
                mimeType: 'image/png',
                folder: 'shooting_practices');

        employee.shootingPractices = [
          DocumentsEmployee(
            date: RxString(dateShootingPracticeController.text),
            description: RxString(descriptionShootingPracticeController.text),
            documentUrl: RxString(shootingPracticeLink!),
          )
        ];

        employee.shootingPractices = [
          DocumentsEmployee(
            date: RxString(dateShootingPracticeController.text),
            description: RxString(descriptionShootingPracticeController.text),
            documentUrl: RxString(shootingPracticeLink),
          )
        ];
      }

      if (criminalRecordImageController.base64 != null) {
        final criminalRecordLink =
            await uploadFileService.uploadPhotoWebFromBase64(
                base64String: criminalRecordImageController.base64!,
                fileName: 'criminal_record.png',
                mimeType: 'image/png',
                folder: 'criminal_records');

        employee.criminalRecords = [
          DocumentsEmployee(
            date: RxString(dateCriminalRecordController.text),
            description: RxString(descriptionCriminalRecordController.text),
            documentUrl: RxString(criminalRecordLink!),
          )
        ];
      }
      if (policeRecordsImageController.base64 != null) {
        final policeRecordLink =
            await uploadFileService.uploadPhotoWebFromBase64(
                base64String: policeRecordsImageController.base64!,
                fileName: 'police_record.png',
                mimeType: 'image/png',
                folder: 'police_records');

        employee.policeRecords = [
          DocumentsEmployee(
            date: RxString(datePoliceRecordsController.text),
            description: RxString(descriptionPoliceRecordsController.text),
            documentUrl: RxString(policeRecordLink!),
          )
        ];
      }

      if (vacationStatusImageController.base64 != null) {
        final vacationStatusLink =
            await uploadFileService.uploadPhotoWebFromBase64(
                base64String: vacationStatusImageController.base64!,
                fileName: 'vacation_status.png',
                mimeType: 'image/png',
                folder: 'vacation_status');

        employee.vacationStatus = [
          DocumentsEmployee(
            date: RxString(dateVacationStatusController.text),
            description: RxString(descriptionVacationStatusController.text),
            documentUrl: RxString(vacationStatusLink!),
          )
        ];
      }
      await employeeService.create(employee);

      ToastService.success(
          title: "Empleado", subTitle: "Empleado creado con éxito");
    } catch (e) {
      ToastService.error(
          title: "Empleado", subTitle: "No se pudo crear el empleado");
      print("Error creating employee: $e");
    }
    // employeeService.create()
  }

  TextEditingController selectedPosition =
      TextEditingController(text: "En proceso");
  //Información Laboral
  Rx<DropDownOption> agencyController = DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> employeeTypeController =
      DropDownOption(id: "", label: "").obs;
  TextEditingController contractTypeController = TextEditingController();
  TextEditingController contractTypeTermController = TextEditingController();
  TextEditingController contractTimeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController entryReasonController = TextEditingController();
  TextEditingController workScheduleController = TextEditingController();
  TextEditingController costCenterController = TextEditingController();
  Rx<DropDownOption> maritalStatusController =
      DropDownOption(id: "", label: "").obs;
  TextEditingController semiannualPolygraphResultController = TextEditingController();
  TextEditingController dateOfLastPolygraphTestController = TextEditingController();

  //Datos Salariales
  TextEditingController decreeBonusController = TextEditingController();
  TextEditingController payrollController = TextEditingController();
  TextEditingController payrollOccupations2989Controller =
      TextEditingController();
  TextEditingController disabilityType2989ReportController =
      TextEditingController();
  TextEditingController salaryBaseMintrabTypeController =
      TextEditingController();
  TextEditingController lifeInsuranceController = TextEditingController();
  TextEditingController currentSalaryController = TextEditingController();
  TextEditingController currentSalaryDateController = TextEditingController();
  TextEditingController previousSalaryDateController = TextEditingController();
  TextEditingController insuranceTypeController = TextEditingController();

  // Información Bancaria
  Rx<DropDownOption> bankController = DropDownOption(id: "", label: "").obs;
  TextEditingController accNumberBankController = TextEditingController();
  TextEditingController accTypeBankController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();

  //Perfil Operativo / RRHH

  Rx<DropDownOption> hrProfileController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> classificationLevelController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> classificationController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> operationalProfileController =
      DropDownOption(id: "", label: "").obs;

  RxBool isLoadingSupervisor = false.obs;
  RxList<DropDownOption> supervisors = <DropDownOption>[].obs;
  Rx<DropDownOption> supervisorController =
      DropDownOption(id: "", label: "").obs;

  RxBool isLoadingPerformanceDepartments = false.obs;
  RxBool isLoadingPerformanceMunicipalities = false.obs;
  RxList<DropDownOption> performanceDepartments = <DropDownOption>[].obs;
  RxList<DropDownOption> performanceMunicipalities = <DropDownOption>[].obs;
  Rx<DropDownOption> performanceDepartmentController =
      DropDownOption(id: "", label: "").obs;
  Rx<DropDownOption> performanceMunicipalityController =
      DropDownOption(id: "", label: "").obs;
  TextEditingController mintrabPerformanceRegionController =
      TextEditingController();
  TextEditingController mintrabBirthRegionController = TextEditingController();
  TextEditingController positionMtController = TextEditingController();
  TextEditingController digesspPositionController = TextEditingController();
  TextEditingController positionSlotController = TextEditingController();
  TextEditingController positionDesignationController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController igssController = TextEditingController();
  TextEditingController cvhController = TextEditingController();

  // personal info
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController secondLastNameController = TextEditingController();
  TextEditingController marriedLastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  RxBool nationalityController = false.obs;

  Rx<DropDownOption> identificationTypeController =
      DropDownOption(id: "", label: "").obs;
  TextEditingController identificationController = TextEditingController();
  TextEditingController identificationIssueDateController =
      TextEditingController();
  TextEditingController identificationEndDateController =
      TextEditingController();
  Rx<DropDownOption> licenseTypeController =
      DropDownOption(id: "", label: "").obs;
  TextEditingController licenseController = TextEditingController();
  TextEditingController nitController = TextEditingController();
  Rx<DropDownOption> educationLevelController =
      DropDownOption(id: "", label: "").obs;
  TextEditingController ethnicityController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  Rx<DropDownOption> professionController =
      DropDownOption(id: "", label: "").obs;

  // CONTACT AND POSITION INFO

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxBool isLoadingDepartmentHome = false.obs;
  RxList<DropDownOption> departmentsHome = <DropDownOption>[].obs;
  Rx<DropDownOption> departmentHomeController =
      DropDownOption(id: "", label: "").obs;

  RxBool isLoadingMunicipalityHome = true.obs;
  RxList<DropDownOption> municipalitiesHome = <DropDownOption>[].obs;
  Rx<DropDownOption> municipalityHomeController =
      DropDownOption(id: "", label: "").obs;

  RxBool isLoadingResidenceMunicipality = false.obs;
  RxList<DropDownOption> residenceMunicipalities = <DropDownOption>[].obs;
  Rx<DropDownOption> residenceMunicipalityController =
      DropDownOption(id: "", label: "").obs;

  RxBool isLoadingResidenceDepartment = false.obs;
  RxList<DropDownOption> residenceDepartments = <DropDownOption>[].obs;
  Rx<DropDownOption> residenceDepartmentController =
      DropDownOption(id: "", label: "").obs;

  Rx<DropDownOption> countryOfBirthController =
      DropDownOption(id: "", label: "").obs;

  RxBool isLoadingMunicipalityOfBirth = false.obs;
  RxList<DropDownOption> municipalitiesOfBirth = <DropDownOption>[].obs;
  Rx<DropDownOption> municipalityOfBirthController =
      DropDownOption(id: "", label: "").obs;

  // FAMILY INFO
  TextEditingController numberOfChildrenController = TextEditingController();
  TextEditingController emergencyNameController = TextEditingController();
  TextEditingController emergencyContactController = TextEditingController();

  // REFERENCES
  TextEditingController referenceName1 = TextEditingController();
  TextEditingController referencePhone1 = TextEditingController();
  TextEditingController referenceName2 = TextEditingController();
  TextEditingController referencePhone2 = TextEditingController();
  TextEditingController referenceName3 = TextEditingController();
  TextEditingController referencePhone3 = TextEditingController();

  // COURSES LOADED
  ImageToUpload courseImageController = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );
  TextEditingController dateCourseController = TextEditingController();
  TextEditingController descriptionCourseController = TextEditingController();

  ImageToUpload shootingPracticeImageController = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );
  TextEditingController dateShootingPracticeController =
      TextEditingController();
  TextEditingController descriptionShootingPracticeController =
      TextEditingController();

  ImageToUpload criminalRecordImageController = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );
  TextEditingController dateCriminalRecordController = TextEditingController();
  TextEditingController descriptionCriminalRecordController =
      TextEditingController();

  ImageToUpload policeRecordsImageController = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );
  TextEditingController datePoliceRecordsController = TextEditingController();
  TextEditingController descriptionPoliceRecordsController =
      TextEditingController();

  ImageToUpload vacationStatusImageController = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );
  TextEditingController dateVacationStatusController = TextEditingController();
  TextEditingController descriptionVacationStatusController =
      TextEditingController();

  RxList<DocumentsEmployee> courses = <DocumentsEmployee>[].obs;
  RxList<DocumentsEmployee> shootingPractices = <DocumentsEmployee>[].obs;
  RxList<DocumentsEmployee> criminalRecords = <DocumentsEmployee>[].obs;
  RxList<DocumentsEmployee> policeRecords = <DocumentsEmployee>[].obs;
  RxList<DocumentsEmployee> vacationStatus = <DocumentsEmployee>[].obs;


  ImageToUpload employeePhoto = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );

  @override
  void onInit() {
    super.onInit();
  }
}

class LoadDocumentsEmployee {
  ImageToUpload courseImageController = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );
  TextEditingController dateCourseController = TextEditingController();
  TextEditingController descriptionCourseController = TextEditingController();
}
