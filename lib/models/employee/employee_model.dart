import 'package:agents_app/models/common/simple_entity_model.dart';

class EmployeeModel {
  String? id;
  bool? nationality;
  String? firstName;
  String? lastName;
  String? contact;
  String? sex;
  int? employeeTypeId;
  String? language;
  String? internalCode;
  // String gender;
  String? birthDate;
  String entryDate;
  String identificationNumber;
  String rrhhProfile;
  bool blueCard;
  String driverLicenseNumber;
  bool gunCarryPermit;
  String administrativeDepartment;
  PositionEmployee? position;
  String socialSecurityCode;
  String phone;
  String address;
  String email;
  bool lifeInsurance;
  String? referredBy;
  String emergencyName;
  String emergencyPhone;
  String? emergencyMobile;
  String accessUser;
  bool availableForBilling;
  bool approvedByPayments;
  String mobile;
  String? ethnicity;
  String mtPosition;
  String birthCountry;
  String birthDepartment;
  String? birthMunicipality;
  String? workSchedule;
  double baseSalary;
  double decreeBonus;
  String residenceDepartment;
  String residenceMunicipality;
  String payroll;
  String positionSlot;
  String contractType;
  String workCountry;
  String accountNumber;
  bool isPermanent;
  SimpleEntity? employeeType;
  String? cvh;

  // Campos nuevos
  String? middleName;
  String? secondLastName;
  String? marriedLastName;
  String? photo;
  int? personId;
  String? fullName;

  int? regionId;
  String? subRegion;
  int? hrProfileId;
  int? licenseTypeId;
  int? paymentTypeId;
  int? agencyId;
  int? bloodTypeId;
  int? maritalStatusId;
  int? educationLevelId;
  int? emergencyRelationshipId;
  int? workerStatusId;
  int? identificationTypeId;
  int? operationalProfileId;
  int? userId;
  int? createdById;
  int? modifiedById;
  int? schoolLevelId;
  int? academicTitleId;
  int? bankId;
  int? testWorkerId;
  int? previousCompanyId;
  int? jobPositionId;
  int? vhContractTypeId;
  int? frequencyId;

  String? hireDate;
  String? terminationDate;
  String? terminationReason;

  bool? isOperationalForce;
  bool? isSent;
  bool? isScheduled;
  bool? isActive;

  String? jobPositionName;
  String? countryOfBirth;

  double? graduationScore;

  String? field1;
  String? field2;
  String? field3;
  String? field4;

  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? shootingPracticeDate;

  String? reasonForWithdrawal;
  int? costCenterId;
  String? performanceDepartment;
  String? companyEmail;
  DateTime? currentSalaryDate;
  DateTime? previousSalaryDate;
  String? paymentMethod;
  String? performanceMunicipality;
  String? payrollOccupations2989;
  String? positionOrDesignation;
  String? digesspPosition;
  String? mintrabPosition;
  String? mintrabPerformanceRegion;
  String? mintrabBirthRegion;
  double? currentSalary;
  String? disabilityType2989Report;
  String? supervisorWorker;
  int? numberOfChildren;
  String? comment;
  bool? isForeigner;
  DateTime? dpiIssueDate;
  String? taxIdNumber;
  String? referenceName1;
  String? referenceName2;
  String? referenceName3;
  String? referencePhone1;
  String? referencePhone2;
  String? referencePhone3;

  SimpleEntity? costCenter;
  SimpleEntity? bankAccountType;
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

  EmployeeModel({
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.sex,
    required this.employeeTypeId,
    required this.internalCode,
    // required this.gender,
    required this.birthDate,
    required this.entryDate,
    required this.identificationNumber,
    required this.nationality,
    required this.rrhhProfile,
    required this.blueCard,
    required this.driverLicenseNumber,
    required this.gunCarryPermit,
    required this.administrativeDepartment,
    required this.position,
    required this.socialSecurityCode,
    required this.phone,
    required this.address,
    required this.email,
    required this.lifeInsurance,
    required this.referredBy,
    required this.emergencyName,
    required this.emergencyPhone,
    required this.emergencyMobile,
    required this.accessUser,
    required this.availableForBilling,
    required this.approvedByPayments,
    required this.mobile,
    required this.language,
    required this.ethnicity,
    required this.mtPosition,
    required this.birthCountry,
    required this.birthDepartment,
    required this.birthMunicipality,
    required this.workSchedule,
    required this.baseSalary,
    required this.decreeBonus,
    required this.residenceDepartment,
    required this.residenceMunicipality,
    required this.payroll,
    required this.positionSlot,
    required this.contractType,
    required this.workCountry,
    required this.accountNumber,
    required this.isPermanent,
    required this.shootingPracticeDate,
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
    this.previousCompanyId,
    this.jobPositionId,
    this.vhContractTypeId,
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
    this.countryOfBirth,
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
    this.costCenterId,
    this.performanceDepartment,
    this.companyEmail,
    this.currentSalaryDate,
    this.previousSalaryDate,
    this.paymentMethod,
    this.performanceMunicipality,
    this.payrollOccupations2989,
    this.positionOrDesignation,
    this.digesspPosition,
    this.mintrabPosition,
    this.mintrabPerformanceRegion,
    this.mintrabBirthRegion,
    this.currentSalary,
    this.disabilityType2989Report,
    this.supervisorWorker,
    this.numberOfChildren,
    this.comment,
    this.isForeigner,
    this.dpiIssueDate,
    this.taxIdNumber,
    this.referenceName1,
    this.referenceName2,
    this.referenceName3,
    this.referencePhone1,
    this.referencePhone2,
    this.referencePhone3,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    final person = json["PERSON"] ?? {};

    return EmployeeModel(
      id: json["Id"]?.toString(),
      cvh: json["previous_cvh"],
      employeeTypeId: json["EMPLOYEE_TYPE_Id"],

      firstName: person["First_name"],
      lastName: person["Last_name"],
      middleName: person["Middle_name"],
      secondLastName: person["Second_last_name"],
      marriedLastName: person["Married_last_name"],
      fullName: json["Full_name"],
      contact: person["Contact"],
      sex: person["sex"],
      nationality: person["Nationality"] == 1 || person["Nationality"] == true,
      language: person["Language"],
      birthDate: person["Date_of_birth"],
      ethnicity: person["Ethnicity"],
      internalCode: json["Internal_code"],
      entryDate: json["Entry_date"] ?? '',
      photo: person["Photo"],
      identificationNumber: json["Identification_number"] ?? '',
      rrhhProfile: json["RRHH_profile"] ?? '',
      driverLicenseNumber: json["Driver_license_number"] ?? '',
      gunCarryPermit:
          json["Gun_carry_permit"] == 1 || json["Gun_carry_permit"] == true,
      administrativeDepartment: json["Administrative_department"] ?? '',
      socialSecurityCode: json["Social_security_code"] ?? '',
      lifeInsurance:
          json["Life_insurance"] == 1 || json["Life_insurance"] == true,
      accessUser: json["Access_user"] ?? '',
      availableForBilling: json["Available_for_billing"] == 1 ||
          json["Available_for_billing"] == true,
      approvedByPayments: json["Approved_by_payments"] == 1 ||
          json["Approved_by_payments"] == true,
      mtPosition: json["Mt_position"] ?? '',
      birthDepartment: json["Birth_department"] ?? '',
      birthMunicipality: json["Birth_municipality"] ?? '',
      workSchedule: json["Work_schedule"] ?? '',
      baseSalary: json["Base_salary"] == null
          ? 0.0
          : double.tryParse(json["Base_salary"].toString()) ?? 0.0,
      decreeBonus: json["Decree_bonus"] == null
          ? 0.0
          : double.tryParse(json["Decree_bonus"].toString()) ?? 0.0,
      residenceDepartment: json["Residence_department"] ?? '',
      residenceMunicipality: json["Residence_municipality"] ?? '',
      payroll: json["Payroll"] ?? '',
      positionSlot: json["Position_slot"]?.toString() ?? '',
      contractType: json["Contract_type"] ?? '', //! ------------------------
      workCountry: json["Work_country"] ?? '',
      accountNumber: json["Account_number"] ?? '',
      isPermanent: json["Is_permanent"] == 1 || json["Is_permanent"] == true,
      subRegion: json["Sub_region"],
      hireDate: json["hire_date"],
      terminationDate: json["termination_date"],
      terminationReason: json["termination_reason"],
      isOperationalForce: json["is_operational_force"] == true,
      isSent: json["is_sent"] == 1 || json["is_sent"] == true,
      isScheduled: json["is_scheduled"] == 1 || json["is_scheduled"] == true,
      jobPositionName: json["job_position_name"],
      address: json["address"] ?? '',
      phone: json["phone"] ?? '',
      mobile: json["mobile"] ?? '',
      email: json["email"] ?? '',
      emergencyName: json["emergency_contact_name"] ?? '',
      emergencyPhone: json["emergency_contact_phone"] ?? '',
      emergencyMobile: json["emergency_contact_mobile"] ?? '',
      referredBy: json["referred_by"] ?? '',
      blueCard: json["blue_card"] == null
          ? false
          : json["blue_card"] == 1 || json["blue_card"] == true,
      birthCountry: json["country_of_birth"] ?? '',
      graduationScore: (json["graduation_score"] as num?)?.toDouble() ?? 0.0,
      field1: json["field_1"] ?? '',
      field2: json["field_2"] ?? '',
      field3: json["field_3"] ?? '',
      field4: json["field_4"] ?? '',
      createdAt: json["created_at"] ?? '',
      updatedAt: json["updated_at"] ?? '',
      deletedAt: json["deleted_at"] ?? '',
      isActive: json["is_active"] == true,
      shootingPracticeDate: json["shooting_practice_date"],

      // nuevos campos
      reasonForWithdrawal: json["reasonForWithdrawal"],
      costCenterId: json["costCenterId"],
      performanceDepartment: json["performanceDepartment"],
      companyEmail: json["companyEmail"],
      currentSalaryDate: json["currentSalaryDate"],
      previousSalaryDate: json["previousSalaryDate"],
      paymentMethod: json["paymentMethod"],
      performanceMunicipality: json["performanceMunicipality"],
      payrollOccupations2989: json["payrollOccupations2989"],
      positionOrDesignation: json["positionOrDesignation"],
      digesspPosition: json["digesspPosition"],
      mintrabPosition: json["mintrabPosition"],
      mintrabPerformanceRegion: json["mintrabPerformanceRegion"],
      mintrabBirthRegion: json["mintrabBirthRegion"],
      currentSalary: json["currentSalary"],
      disabilityType2989Report: json["disabilityType2989Report"],
      supervisorWorker: json["supervisorWorker"],
      numberOfChildren: json["numberOfChildren"],
      comment: json["comment"],
      isForeigner: json["isForeigner"],
      dpiIssueDate: json["dpiIssueDate"],
      taxIdNumber: json["taxIdNumber"],
      referenceName1: json["referenceName1"],
      referenceName2: json["referenceName2"],
      referenceName3: json["referenceName3"],
      referencePhone1: json["referencePhone1"],
      referencePhone2: json["referencePhone2"],
      referencePhone3: json["referencePhone3"],

      // Relaciones tipo SimpleEntity
      bankAccountType: json["Bank_account_type"] != null
          ? SimpleEntity.fromJson(json["Bank_account_type"])
          : null,
      agency:
          json["AGENCY"] != null ? SimpleEntity.fromJson(json["AGENCY"]) : null,
      bank: json["BANK"] != null ? SimpleEntity.fromJson(json["BANK"]) : null,
      bloodType: json["BLOOD_TYPE"] != null
          ? SimpleEntity.fromJson(json["BLOOD_TYPE"])
          : null,
      educationLevel: json["EDUCATION_LEVEL"] != null
          ? SimpleEntity.fromJson(json["EDUCATION_LEVEL"])
          : null,
      emergencyRelationship: json["EMERGENCY_RELATIONSHIP"] != null
          ? SimpleEntity.fromJson(json["EMERGENCY_RELATIONSHIP"])
          : null,
      hrProfile: json["HR_PROFILE"] != null
          ? SimpleEntity.fromJson(json["HR_PROFILE"])
          : null,
      identificationType: json["IDENTIFICATION_TYPE"] != null
          ? SimpleEntity.fromJson(json["IDENTIFICATION_TYPE"])
          : null,
      licenseType: json["LICENSE_TYPE"] != null
          ? SimpleEntity.fromJson(json["LICENSE_TYPE"])
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

      costCenter: json["COST_CENTER"] != null
          ? SimpleEntity.fromJson(json["COST_CENTER"])
          : null,

      // Relaciones simples por ID
      agencyId: json["AGENCY_Id"],
      bankId: json["BANK_Id"],
      bloodTypeId: json["BLOOD_TYPE_Id"],
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

      personId: json["PERSON_Id"],
      userId: json["USER_Id"],
      createdById: json["Created_by_id"],
      modifiedById: json["Modified_by_id"],
      schoolLevelId: json["School_level_id"],
      academicTitleId: json["Academic_title_id"],
      testWorkerId: json["Test_worker_id"],
      previousCompanyId: json["Previous_company_id"],
      jobPositionId: json["Job_position_id"],
      vhContractTypeId: json["VH_contract_type_id"],

      // POSITION_EMPLOYEEs
      position: (json["POSITION_EMPLOYEEs"] != null &&
              json["POSITION_EMPLOYEEs"] is List &&
              json["POSITION_EMPLOYEEs"].isNotEmpty)
          ? PositionEmployee.fromJson(json["POSITION_EMPLOYEEs"][0])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position?.toJson(),
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "secondLastName": secondLastName,
        "marriedLastName": marriedLastName,
        "contact": contact,
        "sex": sex,
        "employeeTypeId": employeeTypeId,
        "internalCode": internalCode,
        "birthDate": birthDate,
        "entryDate": entryDate,
        "identificationNumber": identificationNumber,
        "nationality": nationality,
        "rrhhProfile": rrhhProfile,
        "blueCard": blueCard,
        "driverLicenseNumber": driverLicenseNumber,
        "gunCarryPermit": gunCarryPermit,
        "administrativeDepartment": administrativeDepartment,
        "socialSecurityCode": socialSecurityCode,
        "phone": phone,
        "address": address,
        "email": email,
        "agencyId": agencyId,
        "bloodTypeId": bloodTypeId,
        "lifeInsurance": lifeInsurance,
        "educationLevelId": educationLevelId,
        "graduationScore": graduationScore,
        "referredBy": referredBy,
        "emergencyContactName": emergencyName,
        "emergencyContactPhone": emergencyPhone,
        "emergencyContactMobile": emergencyMobile,
        "accessUser": accessUser,
        "availableForBilling": availableForBilling,
        "approvedByPayments": approvedByPayments,
        "mobile": mobile,
        "language": language,
        "ethnicity": ethnicity,
        "mtPosition": mtPosition,
        "birthCountry": birthCountry,
        "birthDepartment": birthDepartment,
        "birthMunicipality": birthMunicipality,
        "workSchedule": workSchedule,
        "baseSalary": baseSalary,
        "decreeBonus": decreeBonus,
        "residenceDepartment": residenceDepartment,
        "residenceMunicipality": residenceMunicipality,
        "payroll": payroll,
        "positionSlot": positionSlot,
        "contractType": contractType,
        "workCountry": workCountry,
        "bankId": bankId,
        "accountNumber": accountNumber,
        "isPermanent": isPermanent,
        "cvh": cvh,

        // Nuevos campos
        "photo": photo,
        "personId": personId,
        "fullName": fullName,
        "regionId": regionId,
        "subRegion": subRegion,
        "hrProfileId": hrProfileId,
        "licenseTypeId": licenseTypeId,
        "paymentTypeId": paymentTypeId,
        "maritalStatusId": maritalStatusId,
        "emergencyRelationshipId": emergencyRelationshipId,
        "workerStatusId": workerStatusId,
        "identificationTypeId": identificationTypeId,
        "operationalProfileId": operationalProfileId,
        "userId": userId,
        "createdById": createdById,
        "modifiedById": modifiedById,
        "schoolLevelId": schoolLevelId,
        "academicTitleId": academicTitleId,
        "testWorkerId": testWorkerId,
        "previousCompanyId": previousCompanyId,
        "jobPositionId": jobPositionId,
        "vhContractTypeId": vhContractTypeId,
        "frequencyId": frequencyId,
        "hireDate": hireDate,
        "terminationDate": terminationDate,
        "terminationReason": terminationReason,
        "isOperationalForce": isOperationalForce,
        "isSent": isSent,
        "isScheduled": isScheduled,
        "isActive": isActive,
        "jobPositionName": jobPositionName,
        "bankAccountType": bankAccountType,
        "countryOfBirth": countryOfBirth,
        "shootingPracticeDate": shootingPracticeDate,
        "field1": field1,
        "field2": field2,
        "field3": field3,
        "field4": field4,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "deletedAt": deletedAt,

        //nuevos campos
        "reasonForWithdrawal": reasonForWithdrawal,
        "costCenterId": costCenterId,
        "performanceDepartment": performanceDepartment,
        "companyEmail": companyEmail,
        "currentSalaryDate": currentSalaryDate,
        "previousSalaryDate": previousSalaryDate,
        "paymentMethod": paymentMethod,
        "performanceMunicipality": performanceMunicipality,
        "payrollOccupations2989": payrollOccupations2989,
        "positionOrDesignation": positionOrDesignation,
        "digesspPosition": digesspPosition,
        "mintrabPosition": mintrabPosition,
        "mintrabPerformanceRegion": mintrabPerformanceRegion,
        "mintrabBirthRegion": mintrabBirthRegion,
        "currentSalary": currentSalary,
        "disabilityType2989Report": disabilityType2989Report,
        "supervisorWorker": supervisorWorker,
        "numberOfChildren": numberOfChildren,
        "comment": comment,
        "isForeigner": isForeigner,
        "dpiIssueDate": dpiIssueDate,
        "taxIdNumber": taxIdNumber,
        "referenceName1": referenceName1,
        "referenceName2": referenceName2,
        "referenceName3": referenceName3,
        "referencePhone1": referencePhone1,
        "referencePhone2": referencePhone2,
        "referencePhone3": referencePhone3,
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
