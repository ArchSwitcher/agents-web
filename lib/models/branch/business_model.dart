import 'package:agents_app/models/common/simple_entity_model.dart';

class BranchBusinessModel {
  String id;
  String code;
  String businessName;
  String businessActivity;
  String location;
  String emailGFace;
  String status;
  String countCXC;
  String taxAmount;
  String branchId;
  SimpleEntity? branch;

  BranchBusinessModel({
    required this.id,
    required this.code,
    required this.businessName,
    required this.businessActivity,
    required this.location,
    required this.emailGFace,
    required this.status,
    required this.countCXC,
    required this.taxAmount,
    required this.branchId,
    this.branch,
  });

  factory BranchBusinessModel.fromJson(Map<String, dynamic> json) {
    return BranchBusinessModel(
      id: json['Id']?.toString() ?? '',
      code: json['Code']?.toString() ?? '',
      businessName: json['Bussiness_name'] ?? '',
      businessActivity: json['Business_activity'] ?? '',
      location: json['Location'] ?? '',
      emailGFace: json['Email_gface'] ?? '',
      status: json['Status'] ?? '',
      countCXC: json['Count_cxc']?.toString() ?? '',
      taxAmount: json['Tax_amount']?.toString() ?? '',
      branchId: json['BRANCH_Id']?.toString() ?? '',
      branch: json['BRANCH'] != null ? SimpleEntity.fromJson({
        "id": json['BRANCH']["Id"],
        "name": json['BRANCH']["Branch_name"],
      }) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "businessName": businessName,
      "businessActivity": businessActivity,
      "location": location,
      "emailGFace": emailGFace,
      "countCXC": countCXC,
      "taxAmount": taxAmount,
      "branchId": branchId,
    };
  }
}


