import 'package:agents_app/models/common/simple_entity_model.dart';
import 'package:get/get.dart';

class EmployeeModel {
  String? id;
  bool? nationality; //?
  String? firstName; //?
  String? lastName; //?
  String? gender;
  int? employeeTypeId;
  String? language; //?
  DateTime? birthDate;
  String identificationNumber; //?
//   String rrhhProfile;
  String driverLicenseNumber;
//   bool gunCarryPermit;
//   String administrativeDepartment;
  PositionEmployee? position;
  String socialSecurityCode; //?
//   String phone;
  String address; //? addressHome
  String email;
  String lifeInsurance; //?
//   String? referredBy;
  String emergencyContactName;
  String emergencyPhone;
//   String? emergencyMobile;
//   String accessUser;
//   bool availableForBilling;
//   bool approvedByPayments;
  String mobile;
  String? ethnicity; //?
  String mtPosition;
  int? birthCountryId;
//   String birthDepartment;
  int? birthMunicipalityId; //? -----
  String? workSchedule;
//   double baseSalary; //!!
  double decreeBonus; //?
  int? residenceDepartmentId; //?
  String payroll; //?
  String positionSlot;
  String contractType; //?
  String contractTermType; //?
  DateTime? contractTime; //?
  String? entryReason; //?
//   String workCountry;
  String accountNumber;
//   bool isPermanent;
  String? cvh; //?
  String cityHome; //?
  int? departmentHomeId; //? -----

  // Campos nuevos
  String? middleName; //?
  String? secondLastName; //?
  String? marriedLastName; //?
  String? photo;
  int? personId;
  String? fullName;
  DateTime? identificationIssueDate; //?
  DateTime? identificationEndDate; //?

  int? regionId;
  String? subRegion;
  int? hrProfileId; //? -----
  int? licenseTypeId;
  int? paymentTypeId;
  int? agencyId; //?
  int? bloodTypeId;
  int? maritalStatusId;
  int? educationLevelId; //?
  int? emergencyRelationshipId;
  int? workerStatusId;
  int? identificationTypeId; //?
  int? operationalProfileId;
  int? userId;
  int? createdById;
  int? modifiedById;
  int? schoolLevelId;
  int? academicTitleId;
  int? bankId; //? -----
  int? testWorkerId;
  int? previousCompany;
  int? jobPositionId;
  int? frequencyId;

  DateTime? hireDate;
  DateTime? terminationDate;
  String? terminationReason;

  bool? isOperationalForce;
  bool? isSent;
  bool? isScheduled;
  bool? isActive;

  String? jobPositionName;
//   String? countryOfBirth;

  double? graduationScore;

  String? field1;
  String? field2;
  String? field3;
  String? field4;

  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
//   String? shootingPracticeDate;

  String? reasonForWithdrawal;
  String? costCenter;
  String? companyEmail; //?
  DateTime? currentSalaryDate; //?
  DateTime? previousSalaryDate; //?
  String? paymentMethod;
  String? payrollOccupations2989; //?
  String? positionOrDesignation;
  String? salaryBaseMintrabType; //?
  String? digesspPosition; //?
  String? mintrabPosition;
  String? mintrabPerformanceRegion; //?
  String? mintrabBirthRegion;
  double? currentSalary; //?
  String? disabilityType2989Report;
  int? numberOfChildren;
  String? comment;
  bool? isForeigner;
  // DateTime? dpiIssueDate;
  String? taxIdNumber;
  String? referenceName1;
  String? referenceName2;
  String? referenceName3;
  String? referencePhone1;
  String? referencePhone2;
  String? referencePhone3;
  String? bankAccountType;
  int? employeeClassificationId; //? -----
  int? supervisorWorkerId; //? -----
  int? performanceDepartmentId; //? -----
  int? performanceMunicipalityId; //? -----
  int? municipalityHomeId; //? -----
  int? residenceMunicipalityId; //? -----
  int? professionId; //? -----

  double? semiannualPolygraphResult;
  DateTime? dateOfLastPolygraphTest;

  List<DocumentsEmployee>? courses;
  List<DocumentsEmployee>? shootingPractices;
  List<DocumentsEmployee>? criminalRecords;
  List<DocumentsEmployee>? policeRecords;
  List<DocumentsEmployee>? vacationStatus;

//   SimpleEntity? costCenter;
  SimpleEntity? agency;
  SimpleEntity? bank;
  SimpleEntity? bloodType;
  SimpleEntity? educationLevel;
  SimpleEntity? emergencyRelationship;
  SimpleEntity? hrProfile;
  SimpleEntity? identificationType;
  SimpleEntity? licenseType;
  SimpleEntity? maritalStatus;
  SimpleEntity? operationalProfile;
  SimpleEntity? paymentType;
  SimpleEntity? workerStatus;
  SimpleEntity? frequency;
  SimpleEntity? region;
  SimpleEntity? performanceDepartment;
  SimpleEntity? departmentHome;
  SimpleEntity? municipalityHome;
  SimpleEntity? residenceMunicipality;
  SimpleEntity? birthMunicipality;
  SimpleEntity? birthCountry;
  SimpleEntity? profession;
  SimpleEntity? residenceDepartment;
  SimpleEntity? employeeClassification; //? -----
  SimpleEntity? supervisorWorker;
  SimpleEntity? performanceMunicipality;
  SimpleEntity? employeeType; //? -----
  bool status = true;
  // SimpleEntity? employeeClassification

  EmployeeModel({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.employeeTypeId,
    required this.birthDate,
    required this.identificationNumber,
    required this.nationality,
    //   required this.rrhhProfile,
    required this.driverLicenseNumber,
    //   required this.gunCarryPermit,
    //   required this.administrativeDepartment,
    required this.position,
    required this.socialSecurityCode,
    //   required this.phone,
    required this.address,
    required this.email,
    required this.lifeInsurance,
    //   required this.referredBy,
    required this.emergencyContactName,
    required this.emergencyPhone,
    //   required this.emergencyMobile,
    //   required this.accessUser,
    //   required this.availableForBilling,
    //   required this.approvedByPayments,
    required this.mobile,
    required this.language,
    required this.ethnicity,
    required this.mtPosition,
    //   required this.birthDepartment,
    required this.workSchedule,
    //   required this.baseSalary,
    required this.decreeBonus,
    required this.payroll,
    required this.positionSlot,
    required this.contractType,
    required this.contractTermType,
    required this.contractTime,
    //   required this.workCountry,
    required this.accountNumber,
    //   required this.isPermanent,
    //   required this.shootingPracticeDate,
    this.status = true,
    this.employeeClassification,
    this.residenceDepartmentId,
    this.residenceDepartment,
    required this.cityHome,
    this.performanceMunicipalityId,
    this.semiannualPolygraphResult,
    this.dateOfLastPolygraphTest,
    this.residenceMunicipalityId,
    this.professionId,
    this.profession,
    this.birthCountryId,
    this.birthCountry,
    this.birthMunicipalityId,
    this.birthMunicipality,
    this.residenceMunicipality,
    this.departmentHomeId,
    this.municipalityHomeId,
    this.municipalityHome,
    this.identificationIssueDate,
    this.identificationEndDate,
    this.supervisorWorkerId,
    this.performanceDepartmentId,
    this.entryReason,
    this.employeeClassificationId,
    this.maritalStatusId,
    this.employeeType,
    this.id,
    this.cvh,
    this.middleName,
    this.secondLastName,
    this.marriedLastName,
    this.photo,
    this.personId,
    this.fullName,
    this.regionId,
    this.subRegion,
    this.hrProfileId,
    this.licenseTypeId,
    this.paymentTypeId,
    this.agencyId,
    this.bloodTypeId,
    this.educationLevelId,
    this.emergencyRelationshipId,
    this.workerStatusId,
    this.identificationTypeId,
    this.operationalProfileId,
    this.userId,
    this.createdById,
    this.modifiedById,
    this.schoolLevelId,
    this.academicTitleId,
    this.bankId,
    this.testWorkerId,
    this.previousCompany,
    this.jobPositionId,
    this.frequencyId,
    this.hireDate,
    this.terminationDate,
    this.terminationReason,
    this.isOperationalForce,
    this.isSent,
    this.isScheduled,
    this.isActive,
    this.jobPositionName,
    this.bankAccountType,
    //   this.countryOfBirth,
    this.graduationScore,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.agency,
    this.bank,
    this.bloodType,
    this.educationLevel,
    this.emergencyRelationship,
    this.hrProfile,
    this.identificationType,
    this.licenseType,
    this.maritalStatus,
    this.operationalProfile,
    this.paymentType,
    this.workerStatus,
    this.frequency,
    this.region,
    this.costCenter,
    this.reasonForWithdrawal,
    //   this.costCenterId,
    this.performanceDepartment,
    this.companyEmail,
    this.currentSalaryDate,
    this.previousSalaryDate,
    this.paymentMethod,
    this.performanceMunicipality,
    this.payrollOccupations2989,
    this.positionOrDesignation,
    this.digesspPosition,
    this.salaryBaseMintrabType,
    this.mintrabPosition,
    this.mintrabPerformanceRegion,
    this.mintrabBirthRegion,
    this.currentSalary,
    this.disabilityType2989Report,
    this.supervisorWorker,
    this.numberOfChildren,
    this.comment,
    this.isForeigner,
    // this.dpiIssueDate,
    this.taxIdNumber,
    this.referenceName1,
    this.referenceName2,
    this.referenceName3,
    this.referencePhone1,
    this.referencePhone2,
    this.referencePhone3,
    this.departmentHome,
    this.courses,
    this.shootingPractices,
    this.criminalRecords,
    this.policeRecords,
    this.vacationStatus,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    final person = json["PERSON"] ?? {};

    return EmployeeModel(
      //person
      cityHome: person["City_home"] ?? '',
      mobile: person["mobile"] ?? '',
      email: person["email"] ?? '',
      emergencyContactName: person["emergency_contact_name"] ?? '',
      emergencyPhone: person["emergency_contact_phone"] ?? '',
      address: person["Address_home"] ?? '',

      id: json["Id"]?.toString(),
      entryReason: "${json["Entry_reason"] ?? ''}",
      status: json["Status"] == 1,
      cvh: json["previous_cvh"],
      employeeTypeId: json["EMPLOYEE_TYPE_Id"],
      dateOfLastPolygraphTest: json["Date_of_last_polygraph_test"] != null
          ? DateTime.tryParse(json["Date_of_last_polygraph_test"])
          : null,
      identificationIssueDate: person["Dpi_issue_date"] != null
          ? DateTime.tryParse(person["Dpi_issue_date"])
          : null,
      identificationEndDate: person["Dpi_end_date"] != null
          ? DateTime.tryParse(person["Dpi_end_date"])
          : null,
      contractTime: json["Contract_time"] != null
          ? DateTime.tryParse(json["Contract_time"])
          : null,
      birthDate: person["Date_of_birth"] != null
          ? DateTime.tryParse(person["Date_of_birth"])
          : null,
      hireDate: json["hire_date"] != null
          ? DateTime.tryParse(json["hire_date"])
          : null,
      terminationDate: json["termination_date"] != null
          ? DateTime.tryParse(json["termination_date"])
          : null,

      currentSalaryDate: json["Current_salary_date"] != null
          ? DateTime.tryParse(json["Current_salary_date"])
          : null,
      previousSalaryDate: json["Previous_salary_date"] != null
          ? DateTime.tryParse(json["Previous_salary_date"])
          : null,
      // dpiIssueDate: json["Dpi_issue_date"] != null
      //     ? DateTime.tryParse(json["Dpi_issue_date"])
      //     : null,
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.tryParse(json["updated_at"])
          : null,
      deletedAt: json["deleted_at"] != null
          ? DateTime.tryParse(json["deleted_at"])
          : null,

      firstName: person["First_name"],
      lastName: person["Last_name"],
      middleName: person["Middle_name"],
      secondLastName: person["Second_last_name"],
      marriedLastName: person["Married_last_name"],
      fullName: json["Full_name"],
      gender: json["Gender"],
      nationality: person["Nationality"] == 1 || person["Nationality"] == true,
      language: person["Language"] ?? "",
      ethnicity: person["Ethnicity"],
      identificationNumber: person["Identification_number"] ?? '',
      //   rrhhProfile: json["RRHH_profile"] ?? '',
      driverLicenseNumber: person["Driver_license_number"] ?? '',
      //   gunCarryPermit: json["Gun_carry_permit"] == 1 || json["Gun_carry_permit"] == true,
      //   administrativeDepartment: json["Administrative_department"] ?? '',
      socialSecurityCode: json["Social_security_code"] ?? '',
      lifeInsurance: json["Life_insurance"] ?? '',
      //   accessUser: json["Access_user"] ?? '',
      //   availableForBilling: json["Available_for_billing"] == 1 || json["Available_for_billing"] == true,
      //   approvedByPayments: json["Approved_by_payments"] == 1 || json["Approved_by_payments"] == true,
      mtPosition: json["position_mt"] ?? '',
      //   birthDepartment: json["Birth_department"] ?? '',
      workSchedule: json["Work_schedule"] ?? '',
      //   baseSalary: json["Base_salary"] == null ? 0.0 : double.tryParse(json["Base_salary"].toString()) ?? 0.0,

      payroll: json["Payroll"] ?? '',
      positionSlot: json["Position_slot"]?.toString() ?? '',
      contractType: json["Contract_type"] ?? '', //! ------------------------
      contractTermType: json["Contract_term_type"] ?? '',
      //   workCountry: json["Work_country"] ?? '',
      accountNumber: json["Account_number"] ?? '',
      //   isPermanent: json["Is_permanent"] == 1 || json["Is_permanent"] == true,
      subRegion: json["Sub_region"],

      terminationReason: json["termination_reason"],
      // isOperationalForce: json["is_operational_force"] == true,
      isSent: json["is_sent"] == 1 || json["is_sent"] == true,
      isScheduled: json["is_scheduled"] == 1 || json["is_scheduled"] == true,
      jobPositionName: json["job_position_name"],

      // //   phone: json["phone"] ?? '',

      //   emergencyMobile: json["emergency_contact_mobile"] ?? '',
      //   referredBy: json["referred_by"] ?? '',
      field1: json["field_1"] ?? '',
      field2: json["field_2"] ?? '',
      field3: json["field_3"] ?? '',
      field4: json["field_4"] ?? '',

      isActive: json["is_active"] == true,
      //   shootingPracticeDate: json["shooting_practice_date"],

      // nuevos campos
      reasonForWithdrawal: json["Reason_for_withdrawal"],
      //   costCenterId: json["costCenterId"],
      companyEmail: json["Company_email"],

      paymentMethod: json["Payment_method"],
      // performanceMunicipality: json["performanceMunicipality"],
      payrollOccupations2989: json["Payroll_occupations_29_89"],
      positionOrDesignation: json["Position_designation"],
      digesspPosition: json["Digessp_position"],
      // mintrabPosition: json["mintrabPosition"], //!
      mintrabPerformanceRegion: json["Mintrab_performance_region"],
      mintrabBirthRegion: json["Mintrab_birth_region"],

      disabilityType2989Report: json["Disability_type_29_89_report"],
      numberOfChildren: person["Number_of_children"],
      comment: json["Comment"],
      isForeigner:
          person["Is_foreigner"] == 1 ?? person["Is_foreigner"] == true,
      taxIdNumber: person["Tax_id_number"],
      referenceName1: person["Reference_name_1"],
      referenceName2: person["Reference_name_2"],
      referenceName3: person["Reference_name_3"],
      referencePhone1: person["Reference_phone_1"],
      referencePhone2: person["Reference_phone_2"],
      referencePhone3: person["Reference_phone_3"],
      bankAccountType: json["bank_account_type"], //? --- dropdown MOCK
      municipalityHomeId: json["MUNICIPALITY_HOME_Id"], //? -----
      photo: json["Photo_employee"],

      //doubles

      decreeBonus: json["Decree_bonus"] == null
          ? 0.0
          : double.tryParse(json["Decree_bonus"].toString()) ?? 0.0,

      graduationScore: json["graduation_score"] == null
          ? 0.0
          : double.tryParse(json["graduation_score"].toString()) ?? 0.0,

      currentSalary: json["Current_salary"] == null
          ? 0.0
          : double.tryParse(json["Current_salary"].toString()) ?? 0.0,

      semiannualPolygraphResult: json["Semiannual_polygraph_result"] == null
          ? 0.0
          : double.tryParse(json["Semiannual_polygraph_result"].toString()) ??
              0.0,

      // Relaciones tipo SimpleEntity
      birthMunicipality: person["BIRTH_MUNICIPALITY"] != null
          ? SimpleEntity.fromJson(person["BIRTH_MUNICIPALITY"])
          : null,
      profession: person["PROFESSION"] != null
          ? SimpleEntity.fromJson(person["PROFESSION"])
          : null,
      residenceMunicipality: person["RESIDENCE_MUNICIPALITY"] !=
              null //? --------------------------
          ? SimpleEntity.fromJson(person["RESIDENCE_MUNICIPALITY"])
          : null,
      municipalityHome:
          person["MUNICIPALITY_HOME"] != null //? --------------------------
              ? SimpleEntity.fromJson(person["MUNICIPALITY_HOME"])
              : null,
      departmentHome:
          person["DEPARMENT_HOME"] != null //? --------------------------
              ? SimpleEntity.fromJson(person["DEPARMENT_HOME"])
              : null,
      educationLevel: person["EDUCATION_LEVEL"] != null
          ? SimpleEntity.fromJson(person["EDUCATION_LEVEL"])
          : null,
      identificationType: person["IDENTIFICATION_TYPE"] != null
          ? SimpleEntity.fromJson(person["IDENTIFICATION_TYPE"])
          : null,
      licenseType: person["LICENSE_TYPE"] != null
          ? SimpleEntity.fromJson(person["LICENSE_TYPE"])
          : null,
      employeeType: json["EMPLOYEE_TYPE"] != null
          ? SimpleEntity.fromJson(json["EMPLOYEE_TYPE"])
          : null,
      performanceMunicipality: json["PERFORMANCE_MUNICIPALITY"] != null
          ? SimpleEntity.fromJson(json["PERFORMANCE_MUNICIPALITY"])
          : null,
      performanceDepartment: json["PERFORMANCE_DEPARTMENT"] != null
          ? SimpleEntity.fromJson(json["PERFORMANCE_DEPARTMENT"])
          : null,
      supervisorWorker: json["SUPERVISOR_WORKER"] != null
          ? SimpleEntity.fromJson({
              "id": json["SUPERVISOR_WORKER"]["Id"].toString(),
              "name":
                  "${json["SUPERVISOR_WORKER"]["PERSON"]["First_name"]} ${json["SUPERVISOR_WORKER"]["PERSON"]["Last_name"]}"
            })
          : null,

      employeeClassification: json["EMPLOYEE_CLASSIFICATION"] != null
          ? SimpleEntity.fromJson(json["EMPLOYEE_CLASSIFICATION"])
          : null,
      residenceDepartment: json["RESIDENCE_DEPARTMENT"] != null
          ? SimpleEntity.fromJson(json["RESIDENCE_DEPARTMENT"])
          : null,
      birthCountry:
          person["COUNTRY_OF_BIRTH"] != null //? --------------------------
              ? SimpleEntity.fromJson(person["COUNTRY_OF_BIRTH"])
              : null,
      agency:
          json["AGENCY"] != null ? SimpleEntity.fromJson(json["AGENCY"]) : null,
      bank: json["BANK"] != null ? SimpleEntity.fromJson(json["BANK"]) : null,
      // bloodType: json["BLOOD_TYPE"] != null
      //     ? SimpleEntity.fromJson(json["BLOOD_TYPE"])
      //     : null,
      emergencyRelationship: json["EMERGENCY_RELATIONSHIP"] != null
          ? SimpleEntity.fromJson(json["EMERGENCY_RELATIONSHIP"])
          : null,
      hrProfile: json["HR_PROFILE"] != null
          ? SimpleEntity.fromJson(json["HR_PROFILE"])
          : null,
      maritalStatus: json["MARITAL_STATUS"] != null
          ? SimpleEntity.fromJson(json["MARITAL_STATUS"])
          : null,
      operationalProfile: json["OPERATIONAL_PROFILE"] != null
          ? SimpleEntity.fromJson(json["OPERATIONAL_PROFILE"])
          : null,
      paymentType: json["PAYMENT_TYPE"] != null
          ? SimpleEntity.fromJson(json["PAYMENT_TYPE"])
          : null,
      workerStatus: json["WORKER_STATUS"] != null
          ? SimpleEntity.fromJson(json["WORKER_STATUS"])
          : null,
      frequency: json["FREQUENCY"] != null
          ? SimpleEntity.fromJson(json["FREQUENCY"])
          : null,
      region:
          json["REGION"] != null ? SimpleEntity.fromJson(json["REGION"]) : null,
      costCenter: json["Cost_center"],

      //   costCenter: json["COST_CENTER"] != null
      //       ? SimpleEntity.fromJson(json["COST_CENTER"])
      //       : null,

      // Relaciones simples por ID
      agencyId: json["AGENCY_Id"],
      bankId: json["BANK_Id"],
      // bloodTypeId: json["BLOOD_TYPE_Id"],
      educationLevelId: json["EDUCATION_LEVEL_Id"],
      emergencyRelationshipId: json["EMERGENCY_RELATIONSHIP_Id"],
      hrProfileId: json["HR_PROFILE_Id"],
      identificationTypeId: json["IDENTIFICATION_TYPE_Id"],
      licenseTypeId: json["LICENSE_TYPE_Id"],
      maritalStatusId: json["MARITAL_STATUS_Id"],
      operationalProfileId: json["OPERATIONAL_PROFILE_Id"],
      paymentTypeId: json["PAYMENT_TYPE_Id"],
      workerStatusId: json["WORKER_STATUS_Id"],
      frequencyId: json["FREQUENCY_Id"],
      regionId: json["REGION_Id"],
      personId: person["Id"],
      userId: json["USER_Id"],
      createdById: json["Created_by_id"],
      modifiedById: json["Modified_by_id"],
      schoolLevelId: json["School_level_id"],
      // academicTitleId: json["Academic_title_id"],
      testWorkerId: json["Test_worker_id"],
      previousCompany: json["Previous_company_id"],
      jobPositionId: json["Job_position_id"],

      // POSITION_EMPLOYEEs

      position: (json["POSITION_EMPLOYEEs"] != null &&
              json["POSITION_EMPLOYEEs"] is List &&
              json["POSITION_EMPLOYEEs"].isNotEmpty)
          ? PositionEmployee.fromJson(json["POSITION_EMPLOYEEs"][0])
          : null,
      // EMPLOYEE
      salaryBaseMintrabType: json["Salary_base_mintrab_type"] ?? '',

      vacationStatus: (json["vacationStatus"] as List<dynamic>?)
          ?.map((e) => DocumentsEmployee.fromJson({
                "date": e["Date"],
                "description": e["Description"],
                "document_url": e["Document_url"],
              }))
          .toList(),

      shootingPractices: (json["shootingPractices"] as List<dynamic>?)
          ?.map((e) => DocumentsEmployee.fromJson({
                "date": e["Date"],
                "description": e["Description"],
                "document_url": e["Document_url"],
              }))
          .toList(),

      criminalRecords: (json["criminalRecords"] as List<dynamic>?)
          ?.map((e) => DocumentsEmployee.fromJson({
                "date": e["Date"],
                "description": e["Description"],
                "document_url": e["Document_url"],
              }))
          .toList(),

      policeRecords: (json["policeRecords"] as List<dynamic>?)
          ?.map((e) => DocumentsEmployee.fromJson({
                "date": e["Date"],
                "description": e["Description"],
                "document_url": e["Document_url"],
              }))
          .toList(),

      courses: (json["courses"] as List<dynamic>?)
          ?.map((e) => DocumentsEmployee.fromJson({
                "date": e["Date"],
                "description": e["Description"],
                "document_url": e["Document_url"],
              }))
          .toList(),
          );
  }

  Map<String, dynamic> toJson() => {
        // "Status": req.body?.person.status,
        "id": id,
        "position": position?.toJson(),
        "personId": personId,
        "dateOfBirth": birthDate?.toIso8601String(),
        "dpiIssueDate": identificationIssueDate?.toIso8601String(),
        "dpiEndDate": identificationEndDate?.toIso8601String(),
        "contractTime": contractTime?.toIso8601String(),
        "hireDate": hireDate?.toIso8601String(),
        "terminationDate": terminationDate, // Este es String, este no lo toques
        "createdAt": createdAt, // Este ya es String
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,
        "currentSalaryDate": currentSalaryDate?.toIso8601String(),
        "previousSalaryDate": previousSalaryDate?.toIso8601String(),
        "dateOfLastPolygraphTest": dateOfLastPolygraphTest?.toIso8601String(),

        // "status": status,
        "firstName": firstName,
        "middleName": middleName,
        "secondLastName": secondLastName,
        "marriedLastName": marriedLastName,
        "lastName": lastName,
        "nationality": nationality,
        "language": language,
        "ethnicity": ethnicity,
        "identificationNumber": identificationNumber,
        "driverLicenseNumber": driverLicenseNumber,
        "email": email,
        "mobile": mobile,
        // "phone": phone,
        "taxIdNumber": taxIdNumber,
        "cityHome": cityHome,
        "isForeigner": isForeigner,
        "emergencyContactName": emergencyContactName,
        "emergencyContactPhone": emergencyPhone,
        "emergencyContactMobile": emergencyPhone,
        "referenceName1": referenceName1,
        "referenceName2": referenceName2,
        "referenceName3": referenceName3,
        "referencePhone1": referencePhone1,
        "referencePhone2": referencePhone2,
        "referencePhone3": referencePhone3,
        // "blueCard": blueCard,
        "numberOfChildren": numberOfChildren,
        "comment": comment,
        "countryOfBirthId": birthCountryId,
        "birthMunicipalityId": birthMunicipalityId,
        "residenceMunicipalityId": residenceMunicipalityId,
        "licenseTypeId": licenseTypeId,
        "identificationTypeId": identificationTypeId,
        "educationLevelId": educationLevelId,
        "departmentHomeId": departmentHomeId,
        "addressHome": address,
        "municipalityHomeId": municipalityHomeId,
        "professionId": professionId,
        "previousCvh": cvh,
        "semiannualPolygraphResult": semiannualPolygraphResult, // !!!!!!!!!!!
        "positionDesignation": positionOrDesignation,
        "employeeTypeId": employeeTypeId,
        "status": status,
        "socialSecurityCode": socialSecurityCode,
        "lifeInsurance": lifeInsurance,
        "decreeBonus": decreeBonus,
        "payroll": payroll,
        "positionSlot": positionSlot,
        "contractType": contractType,
        "contractTermType": contractTermType,
        "accountNumber": accountNumber,
        "subRegion": subRegion,
        "hrProfileId": hrProfileId,
        "paymentTypeId": paymentTypeId,
        "agencyId": agencyId,
        "workerStatusId": workerStatusId,
        "operationalProfileId": operationalProfileId,
        "userId": userId,
        "createdById": createdById,
        "modifiedById": modifiedById,
        "bankId": bankId,
        "testWorkerId": testWorkerId,
        "previousCompany": previousCompany,
        "jobPositionId": jobPositionId,
        "terminationReason": terminationReason,
        "isOperationalForce": isOperationalForce,
        "isSent": isSent,
        "isScheduled": isScheduled,
        "jobPositionName": jobPositionName,
        "bankAccountType": bankAccountType,
        "graduationScore": graduationScore,
        "salaryBaseMintrabType": salaryBaseMintrabType,
        "field2": field2,
        "field3": field3,
        "field4": field4,
        "isActive": isActive,
        "frequencyId": frequencyId,
        "regionId": regionId,
        "reasonForWithdrawal": reasonForWithdrawal,
        "costCenter": costCenter,
        "performanceDepartmentId": performanceDepartmentId,
        "companyEmail": companyEmail,
        "paymentMethod": paymentMethod,
        "performanceMunicipalityId": performanceMunicipalityId,
        "payrollOccupations2989": payrollOccupations2989,
        "digesspPosition": digesspPosition,
        "positionMt": mtPosition,
        "mintrabPerformanceRegion": mintrabPerformanceRegion,
        "mintrabBirthRegion": mintrabBirthRegion,
        "currentSalary": currentSalary,
        "disabilityType2989Report": disabilityType2989Report,
        "supervisorWorkerId": supervisorWorkerId,
        "entryReason": entryReason,
        "employeeClassificationId": employeeClassificationId,
        "residenceDepartmentId": residenceDepartmentId,
        "maritalStatusId": maritalStatusId,
        "gender": gender,
        "photoEmployee": photo,
        "courses": courses,
        "shootingPractices": shootingPractices,
        "criminalRecords": criminalRecords,
        "policeRecords": policeRecords,
        "vacationStatus": vacationStatus,
      };
}

class DocumentsEmployee {
  RxString? date;
  RxString? description;
  RxString? documentUrl;

  DocumentsEmployee({this.date, this.description, this.documentUrl});

  factory DocumentsEmployee.fromJson(Map<String, dynamic> json) =>
      DocumentsEmployee(
        date: (json["date"] ?? "").toString().obs,
        description: (json["description"] ?? "").toString().obs,
        documentUrl: (json["document_url"] ?? "").toString().obs,
      );

  Map<String, dynamic> toJson() => {
        "date": date?.value,
        "description": description?.value,
        "documentUrl": documentUrl?.value,
      };
}

class PositionEmployee {
  int positionId;
  bool isPrincipal;
  bool isActive;
  String? motive;

  PositionEmployee({
    required this.positionId,
    required this.isPrincipal,
    required this.isActive,
    this.motive,
  });

  factory PositionEmployee.fromJson(Map<String, dynamic> json) =>
      PositionEmployee(
        positionId: json["POSITION_Id"] ?? 0,
        isPrincipal: json["Is_principal"] == 1 ? true : false,
        isActive: (json["Is_active"] == 1) ? true : false,
        motive: json["Motive"],
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "isPrincipal": isPrincipal,
        "isActive": isActive,
        "motive": motive,
      };
}

class NameItem {
  String name;

  NameItem({required this.name});

  factory NameItem.fromJson(Map<String, dynamic> json) => NameItem(
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
