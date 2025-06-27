

import 'package:agents_app/models/common/simple_entity_model.dart';

class Billing {
  String? billCollectorId;
  String? billCollectorName;
  SimpleEntity? billingType;
  SimpleEntity? generationType;

  Billing({
    this.billCollectorId,
    this.billingType,
    this.generationType,
    this.billCollectorName,
  });

  factory Billing.fromNestedJson(Map<String, dynamic> json) {
    return Billing(
      // ignore: prefer_null_aware_operators
      billCollectorId: json['billCollector']?['id'] == null ? null : json['billCollector']?['id'].toString(),
      // ignore: prefer_null_aware_operators
      billCollectorName: json['billCollector']?['name'] == null ? null : json['billCollector']?['name'].toString(),
      billingType: json['billingType'] != null
          ? SimpleEntity.fromJson(json['billingType'])
          : null,
      generationType: json['generationType'] != null
          ? SimpleEntity.fromJson(json['generationType'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "billCollectorId": billCollectorId,
      "billingType": billingType?.id.toString(),
      "generationType": generationType?.id.toString(),
    };
  }
}
