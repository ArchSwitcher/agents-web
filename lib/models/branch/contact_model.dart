import 'package:agents_app/models/common/simple_entity_model.dart';

class BranchContactModel {
  final String id;
  final String name;
  final String phone;
  final String branchId;
  final int status;
  final SimpleEntity? branch;

  BranchContactModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.branchId,
    required this.status,
    this.branch,
  });

  factory BranchContactModel.fromJson(Map<String, dynamic> json) {
    return BranchContactModel(
      id: json['Id'].toString(),
      name: json['Name'] ?? '',
      phone: json['Phone'].toString(),
      branchId: json['BRANCH_Id'].toString(),
      status: json['Status'] ?? 1,
      branch: json['BRANCH'] != null ? SimpleEntity.fromJson({"id": json['BRANCH']['Id'], "name": json['BRANCH']['branch_name']}) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'name': name,
      'phone': phone,
      'branchId': branchId,
    };
  }
}
