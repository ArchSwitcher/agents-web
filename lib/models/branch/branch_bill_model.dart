

import 'package:agents_app/models/common/simple_entity_model.dart';

class BillInfoBranch {
  String? billCollectorId;
  SimpleEntity? billingType;
  SimpleEntity? generationType;

  BillInfoBranch({
    this.billCollectorId,
    this.billingType,
    this.generationType,
  });

  factory BillInfoBranch.fromNestedJson(Map<String, dynamic> json) {
    return BillInfoBranch(
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
