import 'package:agents_app/models/address/address_model.dart';
import 'package:agents_app/models/billing/bill_model.dart';

class ClientModel {
  final String? id;
  final String name;
  final String email;
  final String url;
  final String phone;
  final Group group;
  final Admin admin;
  final Billing billing;
  final Address fiscalAddress;
  final Address paymentAddress;

  ClientModel({
    this.id,
    required this.name,
    required this.email,
    required this.url,
    required this.phone,
    required this.group,
    required this.admin,
    required this.billing,
    required this.fiscalAddress,
    required this.paymentAddress,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'].toString(),
      name: json['Name'].toString(),
      email: json['Email'] ?? '',
      url: json['Url'] ?? '',
      phone: json['Phone'] != null ? json['Phone'].toString() : '',
      group: Group.fromJson(json['group']),
      admin: Admin.fromJson(json['admin']),
      billing: Billing.fromNestedJson(json['billing']),// verify the string
      fiscalAddress: Address.fromNestedJson(json['fiscalAddress']),
      paymentAddress: Address.fromNestedJson(json['paymentAddress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'url': url,
      'phone': phone,
      'groupId': group.id,
      'adminId': admin.id,
      'billing': billing.toJson(),
      'fiscalAddress': fiscalAddress.toJson(),
      'paymentAddress': paymentAddress.toJson(),
    };
  }
}

class Group {
  final String id;
  final String name;

  Group({required this.id, required this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'].toString(),
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
    };
  }
}

class Admin {
  final String id;
  final String name;

  Admin({required this.id, required this.name});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'].toString(),
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
    };
  }
}
