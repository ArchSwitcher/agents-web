class BillInfoBranch {
  int? billCollectorId;
  String billingType;
  String generationType;

  BillInfoBranch({
    this.billCollectorId,
    required this.billingType,
    required this.generationType,
  });

  factory BillInfoBranch.fromNestedJson(Map<String, dynamic> json) {
    return BillInfoBranch(
      billCollectorId: json['billCollector']?['id'],
      billingType: json['billingType']['id'].toString(),
      generationType: json['generationType']['id'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "billCollectorId": billCollectorId,
      "billingType": billingType,
      "generationType": generationType,
    };
  }
}
