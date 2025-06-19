class AddressBranch {
  String address;
  String departmentId;
  String countryId;
  String zone;

  AddressBranch({
    required this.address,
    required this.departmentId,
    required this.countryId,
    required this.zone,
  });

  factory AddressBranch.fromNestedJson(Map<String, dynamic> json) {
    return AddressBranch(
      address: json['address'],
      departmentId: json['department']['id'] != null ? json['department']['id'].toString() : '',
      countryId: json['country']['id'] != null ? json['country']['id'].toString() : '',
      zone: json['zone']['id'] != null ? json['zone']['id'].toString() : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "departmentId": departmentId,
      "countryId": countryId,
      "zone": zone,
    };
  }
}
