import 'package:agents_app/models/address/address_model.dart';
import 'package:agents_app/models/billing/bill_model.dart';
import 'package:agents_app/models/common/simple_entity_model.dart';

class ClientModel {
  final String? id;
  final String? name;
  final String? email;
  final String? url;
  final String? phone;
  final SimpleEntity? group;
  final SimpleEntity? admin;
  final Billing? billing;
  final AddressModel? fiscalAddress;
  final AddressModel? paymentAddress;
  final Employee? adviser;
  final Employee? accountManager;

  ClientModel({
    this.id,
    this.name,
    this.email,
    this.url,
    this.phone,
    this.group,
    this.admin,
    this.billing,
    this.fiscalAddress,
    this.paymentAddress,
    this.adviser,
    this.accountManager,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    print("objects ============ in clientModel");

    return ClientModel(
      id: json['Id']?.toString(),
      name: json['Name']?.toString(),
      email: json['Email']?.toString(),
      url: json['Url']?.toString(),
      phone: json['Phone']?.toString(),
      group: (json['group'] != null && json['group'] is Map<String, dynamic>)
          ? SimpleEntity.fromJson(
              {"id": json['group']['id'], "name": json['group']['Name']})
          : null,
      admin: (json['admin'] != null && json['admin'] is Map<String, dynamic>)
          ? SimpleEntity.fromJson(
              {"id": json['admin']['id'], "name": json['admin']['Name']})
          : null,
      billing: json['billInfo'] != null
          ? Billing.fromNestedJson(json['billInfo'])
          : null,
      fiscalAddress: json['fiscalAddress'] != null
          ? AddressModel.fromNestedJson(json['fiscalAddress'])
          : null,
      paymentAddress: json['paymentAddress'] != null
          ? AddressModel.fromNestedJson(json['paymentAddress'])
          : null,
      adviser:
          json['ADVISER'] != null ? Employee.fromJson(json['ADVISER']) : null,
      accountManager: json['ACCOUNT_BOSS_EMPLOYEE'] != null
          ? Employee.fromJson(json['ACCOUNT_BOSS_EMPLOYEE'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'url': url,
      'phone': phone,
      'groupId': group?.id,
      'adminId': admin?.id,
      'accountBossId': accountManager?.id,
      'adviserId': adviser?.id,
      'fiscalAddress': fiscalAddress?.toJson(),
      'businessAddress': paymentAddress?.toJson(),
      "billingTypeId": billing?.billingType?.id,
      "generationTypeId": billing?.generationType?.id,
      "billingCollectorId": billing?.billCollectorId,
      // 'billing': billing.toJson(),
    };
  }
}

class Employee {
  final String? id;
  final String name;
  final String contact;
  final SimpleEntity? type;

  Employee({
    this.id,
    required this.name,
    required this.contact,
    this.type,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'].toString(),
      name: json['name'].toString(),
      contact: json['contact'] ?? '',
      type: SimpleEntity.fromJson(
          {"id": json['type']["id"], "name": json['type']["name"]}),
    );
  }
}
