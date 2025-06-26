import 'package:agents_app/models/common/simple_entity_model.dart';

class Address {
  String? address;
  SimpleEntity? department;
  SimpleEntity? country;
  SimpleEntity? zone;
  SimpleEntity? municipality;

  Address({
    required this.address,
    required this.department,
    required this.country,
    required this.zone,
    this.municipality,
  });

  factory Address.fromNestedJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      department: json['department'] != null
          ? SimpleEntity.fromJson({"id": json['department']['id'], "name": json['department']['name']})
          : null,
      country: json['country'] != null
          ? SimpleEntity.fromJson({"id": json['country']['id'], "name": json['country']['name']})
          : null,
      zone: json['zone'] != null
          ? SimpleEntity.fromJson({"id": json['zone']['id'], "name": json['zone']['name']})
          : null,
      municipality: json['municipality'] != null
          ? SimpleEntity.fromJson({"id": json['municipality']['id'], "name": json['municipality']['name']})
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "departmentId": department?.id.toString(),
      "countryId": country?.id.toString(),
      "zone": zone?.id.toString(),
      "municipalityId": municipality?.id.toString(),
    };
  }
}
