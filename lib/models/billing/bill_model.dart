

import 'package:agents_app/models/common/simple_entity_model.dart';

class Billing {
  String? billCollectorId;
  SimpleEntity? billingType;
  SimpleEntity? generationType;

  Billing({
    this.billCollectorId,
    this.billingType,
    this.generationType,
  });

  factory Billing.fromNestedJson(Map<String, dynamic> json) {
    return Billing(
      billCollectorId: json['billCollector']?['id'],
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
