

class EmployeeModel {
  PositionModel? position;
  PersonModel? person;

  // Campos planos relacionados al empleado
  int? employeeTypeId;
  int? personId;
  String? internalCode;
  String? rrhhProfile;
  String? gunCarryPermit;
  String? addressName;
  String? socialSecurityCode;
  String? lifeInsurance;
  bool? accessUser;
  bool? availableForBilling;
  bool? approvedByPayments;
  String? workSchedule;
  double? baseSalary;
  double? decreeBonus;
  String? payroll;
  String? positionSlot;
  String? contractType;
  String? workCountry;
  String? accountNumber;
  String? subRegion;
  int? hrProfileId;
  int? paymentTypeId;
  int? agencyId;
  int? workerStatusId;
  int? operationalProfileId;
  int? userId;
  int? createdById;
  int? modifiedById;
  int? bankId;
  int? testWorkerId;
  int? previousCompanyId;
  int? jobPositionId;
  String? contractTime;
  String? previousCvh;
  String? hireDate;
  String? terminationDate;
  String? terminationReason;
  bool? isOperationalForce;
  bool? isSent;
  bool? isScheduled;
  String? jobPositionName;
  String? referredBy;
  String? bankAccountType;
  String? graduationScore;
  String? salaryBaseMintrabType;
  String? field2;
  String? field3;
  String? field4;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? isActive;
  int? frequencyId;
  int? regionId;
  String? shootingPracticeDate;
  String? reasonForWithdrawal;
  int? costCenterId;
  String? performanceDepartment;
  String? companyEmail;
  String? currentSalaryDate;
  String? previousSalaryDate;
  String? paymentMethod;
  String? performanceMunicipality;
  String? payrollOccupations2989;
  String? positionDesignation;
  String? digesspPosition;
  String? positionMt;
  String? mintrabPerformanceRegion;
  String? mintrabBirthRegion;
  double? currentSalary;
  String? disabilityType2989Report;
  int? supervisorWorkerId;
  String? entryReason;
  int? employeeClassificationId;
  int? residenceDepartmentId;
  int? birthDepartmentId;
  int? maritalStatusId;
  String? ethnicity;
  String? photoEmployee;
  String? gender;
  String? employmentStatus;

  EmployeeModel({
    this.position,
    this.person,
    this.employeeTypeId,
    this.personId,
    this.internalCode,
    this.rrhhProfile,
    this.gunCarryPermit,
    this.addressName,
    this.socialSecurityCode,
    this.lifeInsurance,
    this.accessUser,
    this.availableForBilling,
    this.approvedByPayments,
    this.workSchedule,
    this.baseSalary,
    this.decreeBonus,
    this.payroll,
    this.positionSlot,
    this.contractType,
    this.workCountry,
    this.accountNumber,
    this.subRegion,
    this.hrProfileId,
    this.paymentTypeId,
    this.agencyId,
    this.workerStatusId,
    this.operationalProfileId,
    this.userId,
    this.createdById,
    this.modifiedById,
    this.bankId,
    this.testWorkerId,
    this.previousCompanyId,
    this.jobPositionId,
    this.contractTime,
    this.previousCvh,
    this.hireDate,
    this.terminationDate,
    this.terminationReason,
    this.isOperationalForce,
    this.isSent,
    this.isScheduled,
    this.jobPositionName,
    this.referredBy,
    this.bankAccountType,
    this.graduationScore,
    this.salaryBaseMintrabType,
    this.field2,
    this.field3,
    this.field4,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isActive,
    this.frequencyId,
    this.regionId,
    this.shootingPracticeDate,
    this.reasonForWithdrawal,
    this.costCenterId,
    this.performanceDepartment,
    this.companyEmail,
    this.currentSalaryDate,
    this.previousSalaryDate,
    this.paymentMethod,
    this.performanceMunicipality,
    this.payrollOccupations2989,
    this.positionDesignation,
    this.digesspPosition,
    this.positionMt,
    this.mintrabPerformanceRegion,
    this.mintrabBirthRegion,
    this.currentSalary,
    this.disabilityType2989Report,
    this.supervisorWorkerId,
    this.entryReason,
    this.employeeClassificationId,
    this.residenceDepartmentId,
    this.birthDepartmentId,
    this.maritalStatusId,
    this.ethnicity,
    this.photoEmployee,
    this.gender,
    this.employmentStatus,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        position: json["position"] != null ? PositionModel.fromJson(json["position"]) : null,
        person: PersonModel.fromJson(json),
        employeeTypeId: json["employeeTypeId"],
        personId: json["PERSON_Id"],
        internalCode: json["Internal_code"],
        rrhhProfile: json["RRHH_profile"],
        gunCarryPermit: json["Gun_carry_permit"],
        addressName: json["Address_name"],
        socialSecurityCode: json["Social_security_code"],
        lifeInsurance: json["Life_insurance"],
        accessUser: json["Access_user"],
        availableForBilling: json["Available_for_billing"],
        approvedByPayments: json["Approved_by_payments"],
        workSchedule: json["Work_schedule"],
        baseSalary: (json["Base_salary"] as num?)?.toDouble(),
        decreeBonus: (json["Decree_bonus"] as num?)?.toDouble(),
        payroll: json["Payroll"],
        positionSlot: json["Position_slot"],
        contractType: json["Contract_type"],
        workCountry: json["Work_country"],
        accountNumber: json["Account_number"],
        subRegion: json["Sub_region"],
        hrProfileId: json["HR_PROFILE_Id"],
        paymentTypeId: json["PAYMENT_TYPE_Id"],
        agencyId: json["AGENCY_Id"],
        workerStatusId: json["WORKER_STATUS_Id"],
        operationalProfileId: json["OPERATIONAL_PROFILE_Id"],
        userId: json["USER_Id"],
        createdById: json["CREATED_BY_Id"],
        modifiedById: json["MODIFIED_BY_Id"],
        bankId: json["BANK_Id"],
        testWorkerId: json["TEST_WORKER_Id"],
        previousCompanyId: json["PREVIOUS_COMPANY_Id"],
        jobPositionId: json["JOB_POSITION_Id"],
        contractTime: json["Contract_time"],
        previousCvh: json["previous_cvh"],
        hireDate: json["hire_date"],
        terminationDate: json["termination_date"],
        terminationReason: json["termination_reason"],
        isOperationalForce: json["is_operational_force"],
        isSent: json["is_sent"],
        isScheduled: json["is_scheduled"],
        jobPositionName: json["job_position_name"],
        referredBy: json["referred_by"],
        bankAccountType: json["bank_account_type"],
        graduationScore: json["graduation_score"],
        salaryBaseMintrabType: json["Salary_base_mintrab_type"],
        field2: json["field_2"],
        field3: json["field_3"],
        field4: json["field_4"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        isActive: json["is_active"],
        frequencyId: json["FREQUENCY_Id"],
        regionId: json["REGION_Id"],
        shootingPracticeDate: json["Shooting_practice_date"],
        reasonForWithdrawal: json["Reason_for_withdrawal"],
        costCenterId: json["COST_CENTER_Id"],
        performanceDepartment: json["Performance_department"],
        companyEmail: json["Company_email"],
        currentSalaryDate: json["Current_salary_date"],
        previousSalaryDate: json["Previous_salary_date"],
        paymentMethod: json["Payment_method"],
        performanceMunicipality: json["Performance_municipality"],
        payrollOccupations2989: json["Payroll_occupations_29_89"],
        positionDesignation: json["Position_designation"],
        digesspPosition: json["Digessp_position"],
        positionMt: json["position_mt"],
        mintrabPerformanceRegion: json["Mintrab_performance_region"],
        mintrabBirthRegion: json["Mintrab_birth_region"],
        currentSalary: (json["Current_salary"] as num?)?.toDouble(),
        disabilityType2989Report: json["Disability_type_29_89_report"],
        supervisorWorkerId: json["SUPERVISOR_WORKER_Id"],
        entryReason: json["Entry_reason"],
        employeeClassificationId: json["EMPLOYEE_CLASSIFICATION_Id"],
        residenceDepartmentId: json["RESIDENCE_DEPARTMENT_Id"],
        birthDepartmentId: json["BIRTH_DEPARTMENT_Id"],
        maritalStatusId: json["MARITAL_STATUS_Id"],
        ethnicity: json["Ethnicity"],
        photoEmployee: json["Photo_employee"],
        gender: json["Gender"],
        employmentStatus: json["Employment_status"],
      );
}


class PositionModel {
  int? positionId;
  bool? isPrincipal;
  bool? isActive;

  PositionModel({this.positionId, this.isPrincipal, this.isActive});

  factory PositionModel.fromJson(Map<String, dynamic> json) => PositionModel(
        positionId: json["positionId"],
        isPrincipal: json["isPrincipal"],
        isActive: json["isActive"],
      );
}

class PersonModel {
  String? firstName;
  String? lastName;
  String? contact;
  String? fullName;
  String? middleName;
  String? secondLastName;
  String? marriedLastName;
  String? dateOfBirth;
  String? nationality;
  String? language;
  int? languageId;
  int? ethnicityId;
  String? identificationNumber;
  String? driverLicenseNumber;
  String? email;
  String? mobile;
  String? phone;
  String? dpiIssueDate;
  String? taxIdNumber;
  String? cityHome;
  bool? isForeigner;
  String? emergencyContactName;
  String? emergencyContactPhone;
  String? emergencyContactMobile;
  String? referenceName1;
  String? referenceName2;
  String? referenceName3;
  String? referencePhone1;
  String? referencePhone2;
  String? referencePhone3;
  bool? blueCard;
  int? numberOfChildren;
  String? comment;
  int? countryOfBirthId;
  int? birthMunicipalityId;
  int? residenceMunicipalityId;
  int? licenseTypeId;
  int? identificationTypeId;
  int? educationLevelId;
  int? deparmentHomeId;
  String? addressHome;
  String? dpiEndDate;
  int? municipalityHomeId;
  int? professionId;
  String? cvh;

  PersonModel({
    this.firstName,
    this.lastName,
    this.contact,
    this.fullName,
    this.middleName,
    this.secondLastName,
    this.marriedLastName,
    this.dateOfBirth,
    this.nationality,
    this.language,
    this.languageId,
    this.ethnicityId,
    this.identificationNumber,
    this.driverLicenseNumber,
    this.email,
    this.mobile,
    this.phone,
    this.dpiIssueDate,
    this.taxIdNumber,
    this.cityHome,
    this.isForeigner,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactMobile,
    this.referenceName1,
    this.referenceName2,
    this.referenceName3,
    this.referencePhone1,
    this.referencePhone2,
    this.referencePhone3,
    this.blueCard,
    this.numberOfChildren,
    this.comment,
    this.countryOfBirthId,
    this.birthMunicipalityId,
    this.residenceMunicipalityId,
    this.licenseTypeId,
    this.identificationTypeId,
    this.educationLevelId,
    this.deparmentHomeId,
    this.addressHome,
    this.dpiEndDate,
    this.municipalityHomeId,
    this.professionId,
    this.cvh,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        firstName: json["First_name"],
        lastName: json["Last_name"],
        contact: json["Contact"],
        fullName: json["Full_name"],
        middleName: json["Middle_name"],
        secondLastName: json["Second_last_name"],
        marriedLastName: json["Married_last_name"],
        dateOfBirth: json["Date_of_birth"],
        nationality: json["Nationality"],
        language: json["Language"],
        languageId: json["LANGUAGE_Id"],
        ethnicityId: json["ETHNICITY_Id"],
        identificationNumber: json["Identification_number"],
        driverLicenseNumber: json["Driver_license_number"],
        email: json["email"],
        mobile: json["mobile"],
        phone: json["phone"],
        dpiIssueDate: json["Dpi_issue_date"],
        taxIdNumber: json["Tax_id_number"],
        cityHome: json["City_home"],
        isForeigner: json["Is_foreigner"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactPhone: json["emergency_contact_phone"],
        emergencyContactMobile: json["emergency_contact_mobile"],
        referenceName1: json["Reference_name_1"],
        referenceName2: json["Reference_name_2"],
        referenceName3: json["Reference_name_3"],
        referencePhone1: json["Reference_phone_1"],
        referencePhone2: json["Reference_phone_2"],
        referencePhone3: json["Reference_phone_3"],
        blueCard: json["blue_card"],
        numberOfChildren: json["Number_of_children"],
        comment: json["Comment"],
        countryOfBirthId: json["COUNTRY_OF_BIRTH_Id"],
        birthMunicipalityId: json["BIRTH_MUNICIPALITY_Id"],
        residenceMunicipalityId: json["RESIDENCE_MUNICIPALITY_Id"],
        licenseTypeId: json["LICENSE_TYPE_Id"],
        identificationTypeId: json["IDENTIFICATION_TYPE_Id"],
        educationLevelId: json["EDUCATION_LEVEL_Id"],
        deparmentHomeId: json["DEPARMENT_HOME_Id"],
        addressHome: json["Address_home"],
        dpiEndDate: json["Dpi_end_date"],
        municipalityHomeId: json["MUNICIPALITY_HOME_Id"],
        professionId: json["PROFESSION_Id"],
        cvh: json["CVH"],
      );
}
