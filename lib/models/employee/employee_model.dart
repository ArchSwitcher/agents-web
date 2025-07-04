import 'package:agents_app/models/common/simple_entity_model.dart';

class EmployeeModel {
  String? id;
  String firstName;
  String lastName;
  String contact;
  String sex;
  int employeeTypeId;
  String internalCode;
  String gender;
  String birthDate;
  String entryDate;
  String identificationType;
  String identificationNumber;
  String nationality;
  String operationalProfile;
  String rrhhProfile;
  bool blueCard;
  String type;
  String driverLicenseType;
  String driverLicenseNumber;
  bool gunCarryPermit;
  String administrativeDepartment;
  PositionEmployee? position;
  String socialSecurityCode;
  String phone;
  String address;
  String email;
  String paymentType;
  String company;
  String agency;
  String bloodType;
  String maritalStatus;
  bool lifeInsurance;
  String educationLevel;
  String shootingPractice;
  String graduationNote;
  String referredBy;
  String emergencyRelationship;
  String emergencyName;
  String emergencyPhone;
  String emergencyMobile;
  String accessUser;
  bool availableForBilling;
  bool approvedByPayments;
  String mobile;
  String language;
  String ethnicity;
  String mtPosition;
  String birthCountry;
  String birthDepartment;
  String birthMunicipality;
  String workSchedule;
  double baseSalary;
  double decreeBonus;
  String residenceDepartment;
  String residenceMunicipality;
  String payroll;
  String profession;
  String positionSlot;
  String contractType;
  String howHired;
  String workCountry;
  String bank;
  String accountNumber;
  bool isPermanent;
  List<NameItem> titles;
  List<NameItem> professions;

  SimpleEntity? employeeType;

  EmployeeModel({
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.sex,
    required this.employeeTypeId,
    required this.internalCode,
    required this.gender,
    required this.birthDate,
    required this.entryDate,
    required this.identificationType,
    required this.identificationNumber,
    required this.nationality,
    required this.operationalProfile,
    required this.rrhhProfile,
    required this.blueCard,
    required this.type,
    required this.driverLicenseType,
    required this.driverLicenseNumber,
    required this.gunCarryPermit,
    required this.administrativeDepartment,
    required this.position,
    required this.socialSecurityCode,
    required this.phone,
    required this.address,
    required this.email,
    required this.paymentType,
    required this.company,
    required this.agency,
    required this.bloodType,
    required this.maritalStatus,
    required this.lifeInsurance,
    required this.educationLevel,
    required this.shootingPractice,
    required this.graduationNote,
    required this.referredBy,
    required this.emergencyRelationship,
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
    required this.profession,
    required this.positionSlot,
    required this.contractType,
    required this.howHired,
    required this.workCountry,
    required this.bank,
    required this.accountNumber,
    required this.isPermanent,
    required this.titles,
    required this.professions,
    this.employeeType,
    this.id,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    final person = json["PERSON"] ?? {};

    return EmployeeModel(
      id: json["Id"]?.toString(),
      firstName: person["First_name"] ?? '',
      lastName: person["Last_name"] ?? '',
      contact: person["Contact"] ?? '',
      sex: person["sex"] ?? '',
      employeeType: json["EMPLOYEE_TYPE"] != null
          ? SimpleEntity.fromJson(json["EMPLOYEE_TYPE"])
          : null,
      employeeTypeId: json["EMPLOYEE_TYPE_Id"] ?? 0,
      internalCode: json["Internal_code"] ?? '',
      gender: json["Gender"] ?? '',
      birthDate: json["Birth_date"] ?? '',
      entryDate: json["Entry_date"] ?? '',
      identificationType: json["Identification_type"] ?? '',
      identificationNumber: json["Identification_number"] ?? '',
      nationality: json["Nationality"] ?? '',
      operationalProfile: json["Operational_profile"] ?? '',
      rrhhProfile: json["RRHH_profile"] ?? '',
      blueCard: json["Blue_card"] ?? false,
      type: json["Type"] ?? '',
      driverLicenseType: json["Driver_license_type"] ?? '',
      driverLicenseNumber: json["Driver_license_number"] ?? '',
      gunCarryPermit: json["Gun_carry_permit"] ?? false,
      administrativeDepartment: json["Administrative_department"] ?? '',
      // Si no existe "position" en el JSON, puedes asignar un objeto vacío o eliminarlo si no se usa
      position: PositionEmployee.fromJson(json["position"] ?? {}),
      socialSecurityCode: json["Social_security_code"] ?? '',
      phone: json["Phone"] ?? '',
      address: json["Address"] ?? '',
      email: json["Email"] ?? '',
      paymentType: json["Payment_type"] ?? '',
      company: json["Company"] ?? '',
      agency: json["Agency"] ?? '',
      bloodType: json["Blood_type"] ?? '',
      maritalStatus: json["Marital_status"] ?? '',
      lifeInsurance: json["Life_insurance"] ?? false,
      educationLevel: json["Education_level"] ?? '',
      shootingPractice: json["Shooting_practice"] ?? '',
      graduationNote: json["Graduation_note"] ?? '',
      referredBy: json["Referred_by"] ?? '',
      emergencyRelationship: json["Emergency_relationship"] ?? '',
      emergencyName: json["Emergency_name"] ?? '',
      emergencyPhone: json["Emergency_phone"] ?? '',
      emergencyMobile: json["Emergency_mobile"] ?? '',
      accessUser: json["Access_user"] ?? '',
      availableForBilling: json["Available_for_billing"] ?? false,
      approvedByPayments: json["Approved_by_payments"] ?? false,
      mobile: json["Mobile"] ?? '',
      language: json["Language"] ?? '',
      ethnicity: json["Ethnicity"] ?? '',
      mtPosition: json["Mt_position"] ?? '',
      birthCountry: json["Birth_country"] ?? '',
      birthDepartment: json["Birth_department"] ?? '',
      birthMunicipality: json["Birth_municipality"] ?? '',
      workSchedule: json["Work_schedule"] ?? '',
      baseSalary: double.tryParse(json["Base_salary"] ?? '0') ?? 0,
      decreeBonus: double.tryParse(json["Decree_bonus"] ?? '0') ?? 0,
      residenceDepartment: json["Residence_department"] ?? '',
      residenceMunicipality: json["Residence_municipality"] ?? '',
      payroll: json["Payroll"] ?? '',
      profession: json["Profession"] ?? '',
      positionSlot: json["Position_slot"] ?? '',
      contractType: json["Contract_type"] ?? '',
      howHired: json["How_hired"] ?? '',
      workCountry: json["Work_country"] ?? '',
      bank: json["Bank"] ?? '',
      accountNumber: json["Account_number"] ?? '',
      isPermanent: (json["Is_permanent"] ?? 0) == 1,
      titles: (person["TITLEs"] as List<dynamic>?)
              ?.map((e) => NameItem.fromJson(e))
              .toList() ??
          [],
      professions: (person["PROFESSIONs"] as List<dynamic>?)
              ?.map((e) => NameItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "contact": contact,
        "sex": sex,
        "employeeTypeId": employeeTypeId,
        "internalCode": internalCode,
        "gender": gender,
        "birthDate": birthDate,
        "entryDate": entryDate,
        "identificationType": identificationType,
        "identificationNumber": identificationNumber,
        "nationality": nationality,
        "operationalProfile": operationalProfile,
        "rrhhProfile": rrhhProfile,
        "blueCard": blueCard,
        "type": type,
        "driverLicenseType": driverLicenseType,
        "driverLicenseNumber": driverLicenseNumber,
        "gunCarryPermit": gunCarryPermit,
        "administrativeDepartment": administrativeDepartment,
        "position": position?.toJson(),
        "socialSecurityCode": socialSecurityCode,
        "phone": phone,
        "address": address,
        "email": email,
        "paymentType": paymentType,
        "company": company,
        "agency": agency,
        "bloodType": bloodType,
        "maritalStatus": maritalStatus,
        "lifeInsurance": lifeInsurance,
        "educationLevel": educationLevel,
        "shootingPractice": shootingPractice,
        "graduationNote": graduationNote,
        "referredBy": referredBy,
        "emergencyRelationship": emergencyRelationship,
        "emergencyName": emergencyName,
        "emergencyPhone": emergencyPhone,
        "emergencyMobile": emergencyMobile,
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
        "profession": profession,
        "positionSlot": positionSlot,
        "contractType": contractType,
        "howHired": howHired,
        "workCountry": workCountry,
        "bank": bank,
        "accountNumber": accountNumber,
        "isPermanent": isPermanent,
        "titles": titles.map((e) => e.toJson()).toList(),
        "professions": professions.map((e) => e.toJson()).toList(),
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
        isActive: (json["Is_active"] == 1) ? true : true,
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
