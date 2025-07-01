import 'package:agents_app/models/common/simple_entity_model.dart';

class AddressModel {
  String? address;
  SimpleEntity? department;
  SimpleEntity? country;
  SimpleEntity? zone;
  SimpleEntity? municipality;
  String? addressId;

  AddressModel({
    required this.address,
    required this.department,
    required this.country,
    required this.zone,
    this.municipality,
    this.addressId,
  });

  factory AddressModel.fromNestedJson(Map<String, dynamic> json) {
    //conditional for retrieve country sometimes came lowercase or uppercase

    String? countryName = json['country']?.toString() ??
        json['COUNTRY']?['name'].toString() ??
        '';
    String? countryId = json['country']?['Id']?.toString() ??
        json['COUNTRY']?['Id']?.toString() ??
        '';

    String? departmentName = json['department']?.toString() ??
        json['DEPARTAMENT']?['name'].toString() ??
        '';
    String? departmentId = json['department']?['Id']?.toString() ??
        json['DEPARTAMENT']?['Id']?.toString() ??
        '';

    String? municipalityName = json['municipality']?.toString() ??
        json['MUNICIPALITY']?['name'].toString() ??
        '';
    String? municipalityId = json['municipality']?['Id']?.toString() ??
        json['MUNICIPALITY']?['Id']?.toString() ??
        '';

    String? zoneName =
        json['zone']?.toString() ?? json['ZONE']?['name'].toString() ?? '';
    String? zoneId = json['zone']?['Id']?.toString() ??
        json['ZONE']?['Id']?.toString() ??
        '';

    return AddressModel(
      addressId: json['Id']?.toString(),
      address: json['address'],
      department: departmentId.isNotEmpty
          ? SimpleEntity.fromJson({"Id": departmentId, "name": departmentName})
          : null,
      country: countryId.isNotEmpty
          ? SimpleEntity.fromJson({"Id": countryId, "name": countryName})
          : null,
      zone: zoneId.isNotEmpty
          ? SimpleEntity.fromJson({"Id": zoneId, "name": zoneName})
          : null,
      municipality: municipalityId.isNotEmpty
          ? SimpleEntity.fromJson(
              {"Id": municipalityId, "name": municipalityName})
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "addressId": addressId,
      "address": address,
      "departmentId": department?.id.toString(),
      "countryId": country?.id.toString(),
      "zone": zone?.id.toString(),
      "municipalityId": municipality?.id.toString(),
    };
  }
}
