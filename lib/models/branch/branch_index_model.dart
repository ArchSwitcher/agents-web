import 'package:agents_app/models/branch/branch_address_model.dart';
import 'package:agents_app/models/branch/branch_bill_model.dart';

class BranchModel {
  String codeGp;
  String branchName;
  String nit;
  double latitude;
  double longitude;
  int clientId;
  int classificationId;
  int factoryId;
  int accountBossId;
  int adviserId;
  int territoryBossId;
  AddressBranch businessAddress;
  AddressBranch fiscalAddress;
  AddressBranch paymentAddress;
  BillInfoBranch billInfo;

  BranchModel({
    required this.codeGp,
    required this.branchName,
    required this.nit,
    required this.latitude,
    required this.longitude,
    required this.clientId,
    required this.classificationId,
    required this.factoryId,
    required this.accountBossId,
    required this.adviserId,
    required this.territoryBossId,
    required this.businessAddress,
    required this.fiscalAddress,
    required this.paymentAddress,
    required this.billInfo,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return BranchModel(
      codeGp: data['codeGp'],
      branchName: data['branchName'],
      nit: data['nit'],
      latitude: double.parse(data['latitude']),
      longitude: double.parse(data['longitude']),
      clientId: data['client']['id'],
      classificationId: data['classification']['id'],
      factoryId: data['factory']['id'],
      accountBossId: data['accountBoss']['id'],
      adviserId: data['adviser']['id'],
      territoryBossId: data['territoryBoss']['id'],
      businessAddress: AddressBranch.fromNestedJson(data['businessAddress']),
      fiscalAddress: AddressBranch.fromNestedJson(data['fiscalAddress']),
      paymentAddress: AddressBranch.fromNestedJson(data['paymentAddress']),
      billInfo: BillInfoBranch.fromNestedJson(data['billInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "codeGp": codeGp,
      "branchName": branchName,
      "nit": nit,
      "latitude": latitude,
      "longitude": longitude,
      "clientId": clientId,
      "classificationId": classificationId,
      "factoryId": factoryId,
      "accountBossId": accountBossId,
      "adviserId": adviserId,
      "territoryBossId": territoryBossId,
      "businessAddress": businessAddress.toJson(),
      "fiscalAddress": fiscalAddress.toJson(),
      "paymentAddress": paymentAddress.toJson(),
      "billInfo": billInfo.toJson(),
    };
  }
}
