import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/common/image_model.dart';
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/services/employee_dropdown_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/services/upload_file.dart';
import 'package:agents_app/views/employees/services/employee-service.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageEmployeeController extends GetxController {
  bool rrhForm = false;
  bool personalForm = false;
  bool otherForm = false;

  PositionController positionController = Get.put(PositionController());
  GenericListController genericListController =
      Get.put(GenericListController());
  // EmployeeAgentService employeeAgentService = EmployeeAgentService();
  EmployeeService employeeService = EmployeeService();
  EmployeeDropdownService employeeDropdownService = EmployeeDropdownService();
  UploadFileService uploadFileService = UploadFileService();

  String employeeId = "";
  int? personId;

  EmployeeModel get employeeValues {
    EmployeeModel employee = EmployeeModel(
        id: employeeId,
        personId: personId,
        workerStatusId: 1, // ACTIVO SHOULD BE FROM DROPDOWN BUT IN DROPDOWN SET DEFAULT TO ACTIVE
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
        performanceMunicipalityId:
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

    setEmployeeValues(String? employeeId) async{
    print("Setting employee values for ID: $employeeId");
    if (employeeId == null || employeeId.isEmpty) {
     ToastService.error(title: "Empleado", subTitle: "El ID del empleado no puede estar vacío");
      return;
    }
    final employeeData = await employeeService.getById(employeeId);

    this.employeeId = employeeId;
    personId = employeeData.personId;

    // DROPDOWNS FROM DATABASE
    performanceDepartmentController.value = DropDownOption(id: employeeData.performanceDepartment?.id ?? "", label: employeeData.performanceDepartment?.name?? "");
    performanceMunicipalities.value = await genericListController.fetchMunicipalitiesOnly(employeeData.performanceDepartment?.id ?? "0");
    performanceMunicipalityController.value = DropDownOption(id: employeeData.performanceMunicipality?.id ?? "", label: employeeData.performanceMunicipality?.name?? "");

    departmentHomeController.value = DropDownOption(id: employeeData.departmentHome?.id ?? "", label: employeeData.departmentHome?.name?? "");
    municipalitiesHome.value = await genericListController.fetchMunicipalitiesOnly(employeeData.departmentHome?.id ?? "0");
    municipalityHomeController.value = DropDownOption(id: employeeData.municipalityHome?.id ?? "", label: employeeData.municipalityHome?.name?? "");
    
    residenceDepartmentController.value = DropDownOption(id: employeeData.residenceDepartment?.id ?? "", label: employeeData.residenceDepartment?.name?? "");
    residenceMunicipalities.value = await genericListController.fetchMunicipalities(residenceDepartmentController.value.id);
    residenceMunicipalityController.value = DropDownOption(id: employeeData.residenceMunicipality?.id ?? "", label: employeeData.residenceMunicipality?.name?? "");


    countryOfBirthController.value = DropDownOption(id: employeeData.birthCountry?.id ?? "", label: employeeData.birthCountry?.name?? "");
    municipalityOfBirthController.value = DropDownOption(id: employeeData.birthMunicipality?.id ?? "", label: employeeData.birthMunicipality?.name?? "");
    identificationTypeController.value = DropDownOption(id: employeeData.identificationType?.id ?? "", label: employeeData.identificationType?.name?? "");
    licenseTypeController.value = DropDownOption(id: employeeData.licenseType?.id ?? "", label: employeeData.licenseType?.name?? "");
    educationLevelController.value = DropDownOption(id: employeeData.educationLevel?.id ?? "", label: employeeData.educationLevel?.name?? "");
    professionController.value = DropDownOption(id: employeeData.profession?.id ?? "", label: employeeData.profession?.name?? "");
    supervisorController.value = DropDownOption(id: employeeData.supervisorWorker?.id ?? "", label: employeeData.supervisorWorker?.name?? "");
    agencyController.value = DropDownOption(id: employeeData.agency?.id ?? "" , label: employeeData.agency?.name ?? "");
    employeeTypeController.value = DropDownOption(id: employeeData.employeeType?.id ?? "", label: employeeData.employeeType?.name ?? "");
    maritalStatusController.value = DropDownOption(id: employeeData.maritalStatus?.id ?? "", label: employeeData.maritalStatus?.name ?? "");
    bankController.value = DropDownOption(id: employeeData.bank?.id ?? "", label: employeeData.bank?.name ?? "");
    // NIVEL DE CLASIFICACIÓN classificationLevelController
    hrProfileController.value = DropDownOption(id: employeeData.hrProfile?.id ?? "", label: employeeData.hrProfile?.name ?? "");
    // CLASIFICACIÓN DEL PUESTO
    classificationController.value = DropDownOption(id: employeeData.employeeClassification?.id ?? "", label: employeeData.employeeClassification?.name ?? "");


    isLoadingPerformanceMunicipalities.value = false;
    isLoadingMunicipalityHome.value = false;
    isLoadingResidenceMunicipality.value = false;

    // TEXT FIELDS
    contractTypeController.text = employeeData.contractType ?? '';
    contractTypeTermController.text = employeeData.contractTermType ?? '';
    contractTimeController.text = employeeData.contractTime?.toIso8601String() ?? '';
    startDateController.text = employeeData.hireDate?.toIso8601String() ?? '';
    entryReasonController.text = employeeData.entryReason ?? '';
    workScheduleController.text = employeeData.workSchedule ?? '';
    costCenterController.text = employeeData.costCenter ?? '';
    semiannualPolygraphResultController.text = employeeData.semiannualPolygraphResult.toString();
    dateOfLastPolygraphTestController.text = employeeData.dateOfLastPolygraphTest?.toIso8601String() ?? '';
    decreeBonusController.text = employeeData.decreeBonus.toString();
    payrollController.text = employeeData.payroll ?? '';
    payrollOccupations2989Controller.text = employeeData.payrollOccupations2989 ?? '';
    disabilityType2989ReportController.text = employeeData.disabilityType2989Report ?? '';
    salaryBaseMintrabTypeController.text = employeeData.salaryBaseMintrabType ?? '';
    lifeInsuranceController.text = employeeData.lifeInsurance ?? '';
    currentSalaryController.text = employeeData.currentSalary.toString();
    currentSalaryDateController.text = employeeData.currentSalaryDate?.toIso8601String() ?? '';
    previousSalaryDateController.text = employeeData.previousSalaryDate?.toIso8601String() ?? '';
    insuranceTypeController.text = employeeData.lifeInsurance ?? '';
    accNumberBankController.text = employeeData.accountNumber ?? '';
    accTypeBankController.text = employeeData.bankAccountType ?? '';
    paymentMethodController.text = employeeData.paymentMethod ?? '';
    mintrabPerformanceRegionController.text = employeeData.mintrabPerformanceRegion ?? '';
    mintrabBirthRegionController.text = employeeData.mintrabBirthRegion ?? '';
    positionMtController.text = employeeData.mtPosition ?? '';
    digesspPositionController.text = employeeData.digesspPosition ?? '';
    positionSlotController.text = employeeData.positionSlot ?? '';
    // positionDesignationController.text = employeeData.positionDesignation ?? '';
    companyEmailController.text = employeeData.companyEmail ?? '';
    igssController.text = employeeData.socialSecurityCode ?? '';
    cvhController.text = employeeData.cvh ?? '';
    firstNameController.text = employeeData.firstName ?? '';
    middleNameController.text = employeeData.middleName ?? '';
    lastNameController.text = employeeData.lastName ?? '';
    secondLastNameController.text = employeeData.secondLastName ?? '';
    marriedLastNameController.text = employeeData.marriedLastName ?? '';
    birthDateController.text = employeeData.birthDate?.toIso8601String() ?? '';
    genderController.text = employeeData.gender ?? '';
    identificationController.text = employeeData.identificationNumber ?? '';
    identificationIssueDateController.text = employeeData.identificationIssueDate?.toIso8601String() ?? '';
    identificationEndDateController.text = employeeData.identificationEndDate?.toIso8601String() ?? '';
    licenseController.text = employeeData.driverLicenseNumber ?? '';
    nitController.text = employeeData.taxIdNumber ?? '';
    
    languageController.text = employeeData.language ?? '';
    emailController.text = employeeData.email ?? '';
    mobileController.text = employeeData.mobile ?? '';
    cityController.text = employeeData.cityHome ?? '';
    addressController.text = employeeData.address ?? '';
    numberOfChildrenController.text = employeeData.numberOfChildren?.toString() ?? '';
    emergencyNameController.text = employeeData.emergencyContactName ?? '';
    emergencyContactController.text = employeeData.emergencyPhone ?? '';
    referenceName1.text = employeeData.referenceName1 ?? '';
    referencePhone1.text = employeeData.referencePhone1 ?? '';
    referenceName2.text = employeeData.referenceName2 ?? '';
    referencePhone2.text = employeeData.referencePhone2 ?? '';
    referenceName3.text = employeeData.referenceName3 ?? '';
    referencePhone3.text = employeeData.referencePhone3 ?? '';
    ethnicityController.text = employeeData.ethnicity ?? '';

    // NOT FILL ONLY USED IN CREATE
    // dateCourseController.text = employeeData.dateCourse?.toIso8601String() ?? '';
    // descriptionCourseController.text = employeeData.descriptionCourse ?? '';
    // dateShootingPracticeController.text = employeeData.dateShootingPractice?.toIso8601String() ?? '';
    // descriptionShootingPracticeController.text = employeeData.descriptionShootingPractice ?? '';
    // dateCriminalRecordController.text = employeeData.dateCriminalRecord?.toIso8601String() ?? '';
    // descriptionCriminalRecordController.text = employeeData.descriptionCriminalRecord ?? '';
    // datePoliceRecordsController.text = employeeData.datePoliceRecords?.toIso8601String() ?? '';
    // descriptionPoliceRecordsController.text = employeeData.descriptionPoliceRecords ?? '';
    // dateVacationStatusController.text = employeeData.dateVacationStatus?.toIso8601String() ?? '';
    // descriptionVacationStatusController.text = employeeData.descriptionVacationStatus ?? '';
    
// TextEditingController dateCourseController
// TextEditingController descriptionCourseController

    print("Setting employee values for ID: END");
  }

  Future<dynamic> createImagesForEmployee() async{
    if (courseImageController.base64 != null) {
        final courseLink = await uploadFileService.uploadPhotoWebFromBase64(
            base64String: courseImageController.base64!,
            fileName: 'course.png',
            mimeType: 'image/png',
            folder: 'courses');
      print("Course link: $courseLink");
        employeeValues.courses = [
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
        print("Shooting practice link: $shootingPracticeLink");
        employeeValues.shootingPractices = [
          DocumentsEmployee(
            date: RxString(dateShootingPracticeController.text),
            description: RxString(descriptionShootingPracticeController.text),
            documentUrl: RxString(shootingPracticeLink!),
          )
        ];

        employeeValues.shootingPractices = [
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
        print("Criminal record link: $criminalRecordLink");
        employeeValues.criminalRecords = [
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
        print("Police record link: $policeRecordLink");
        employeeValues.policeRecords = [
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
        print("Vacation status link: $vacationStatusLink");
        employeeValues.vacationStatus = [
          DocumentsEmployee(
            date: RxString(dateVacationStatusController.text),
            description: RxString(descriptionVacationStatusController.text),
            documentUrl: RxString(vacationStatusLink!),
          )
        ];
      }

      if(employeePhoto.base64 != null) {
        final photoLink = await uploadFileService.uploadPhotoWebFromBase64(
            base64String: employeePhoto.base64!,
            fileName: 'employee_photo.png',
            mimeType: 'image/png',
            folder: 'employee_photos');
        print("Employee photo link: $photoLink");
        employeePhoto.updateLink(photoLink!);
      }

      return {
        courses: employeeValues.courses,
        shootingPractices: employeeValues.shootingPractices,
        criminalRecords: employeeValues.criminalRecords,
        policeRecords: employeeValues.policeRecords,
        vacationStatus: employeeValues.vacationStatus,
      };
  }

  Future<void> createEmployee() async {
    try {
      EmployeeModel employee = employeeValues;
      await createImagesForEmployee();
      print("employeeValues.photo: ${employeePhoto.link}");
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

  Future<void> updateEmployee() async {
    try {
      // EmployeeModel employee = employeeValues;
      await createImagesForEmployee();
      
      print("employeeValues.photo: ${employeePhoto.link}");
      print("vacatioNStatus: ${employeeValues.vacationStatus}");
      // await employeeService.update(employeeId,employee);

      ToastService.success(
          title: "Empleado", subTitle: "Empleado actualizado con éxito");
    } catch (e) {
      ToastService.error(
          title: "Empleado", subTitle: "No se pudo actualizar el empleado");
      print("Error updating employee: $e");
    }
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
