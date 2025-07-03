class EmployeeModel {
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
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        contact: json["contact"] ?? '',
        sex: json["sex"] ?? '',
        employeeTypeId: json["employeeTypeId"] ?? 0,
        internalCode: json["internalCode"] ?? '',
        gender: json["gender"] ?? '',
        birthDate: json["birthDate"] ?? '',
        entryDate: json["entryDate"] ?? '',
        identificationType: json["identificationType"] ?? '',
        identificationNumber: json["identificationNumber"] ?? '',
        nationality: json["nationality"] ?? '',
        operationalProfile: json["operationalProfile"] ?? '',
        rrhhProfile: json["rrhhProfile"] ?? '',
        blueCard: json["blueCard"] ?? false,
        type: json["type"] ?? '',
        driverLicenseType: json["driverLicenseType"] ?? '',
        driverLicenseNumber: json["driverLicenseNumber"] ?? '',
        gunCarryPermit: json["gunCarryPermit"] ?? false,
        administrativeDepartment: json["administrativeDepartment"] ?? '',
        position: PositionEmployee.fromJson(json["position"] ?? {}),
        socialSecurityCode: json["socialSecurityCode"] ?? '',
        phone: json["phone"] ?? '',
        address: json["address"] ?? '',
        email: json["email"] ?? '',
        paymentType: json["paymentType"] ?? '',
        company: json["company"] ?? '',
        agency: json["agency"] ?? '',
        bloodType: json["bloodType"] ?? '',
        maritalStatus: json["maritalStatus"] ?? '',
        lifeInsurance: json["lifeInsurance"] ?? false,
        educationLevel: json["educationLevel"] ?? '',
        shootingPractice: json["shootingPractice"] ?? false,
        graduationNote: json["graduationNote"] ?? 0,
        referredBy: json["referredBy"] ?? '',
        emergencyRelationship: json["emergencyRelationship"] ?? '',
        emergencyName: json["emergencyName"] ?? '',
        emergencyPhone: json["emergencyPhone"] ?? '',
        emergencyMobile: json["emergencyMobile"] ?? '',
        accessUser: json["accessUser"] ?? '',
        availableForBilling: json["availableForBilling"] ?? false,
        approvedByPayments: json["approvedByPayments"] ?? false,
        mobile: json["mobile"] ?? '',
        language: json["language"] ?? '',
        ethnicity: json["ethnicity"] ?? '',
        mtPosition: json["mtPosition"] ?? '',
        birthCountry: json["birthCountry"] ?? '',
        birthDepartment: json["birthDepartment"] ?? '',
        birthMunicipality: json["birthMunicipality"] ?? '',
        workSchedule: json["workSchedule"] ?? '',
        baseSalary: json["baseSalary"] ?? 0,
        decreeBonus: json["decreeBonus"] ?? 0,
        residenceDepartment: json["residenceDepartment"] ?? '',
        residenceMunicipality: json["residenceMunicipality"] ?? '',
        payroll: json["payroll"] ?? '',
        profession: json["profession"] ?? '',
        positionSlot: json["positionSlot"] ?? '',
        contractType: json["contractType"] ?? '',
        howHired: json["howHired"] ?? '',
        workCountry: json["workCountry"] ?? '',
        bank: json["bank"] ?? '',
        accountNumber: json["accountNumber"] ?? '',
        isPermanent: json["isPermanent"] ?? false,
        titles: (json["titles"] as List<dynamic>?)
                ?.map((e) => NameItem.fromJson(e))
                .toList() ??
            [],
        professions: (json["professions"] as List<dynamic>?)
                ?.map((e) => NameItem.fromJson(e))
                .toList() ??
            [],
      );

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

  PositionEmployee({
    required this.positionId,
    required this.isPrincipal,
    required this.isActive,
  });

  factory PositionEmployee.fromJson(Map<String, dynamic> json) => PositionEmployee(
        positionId: json["positionId"] ?? 0,
        isPrincipal: json["isPrincipal"] ?? false,
        isActive: json["isActive"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "isPrincipal": isPrincipal,
        "isActive": isActive,
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
