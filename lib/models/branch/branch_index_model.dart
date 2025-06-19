import 'package:agents_app/models/branch/branch_address_model.dart';
import 'package:agents_app/models/branch/branch_bill_model.dart';

class BranchModel {
  String id = '';
  String codeGp;
  String branchName;
  String nit;
  double latitude;
  double longitude;

  int clientId;
  SimpleEntity? client;

  int classificationId;
  SimpleEntity? classification;

  int factoryId;
  SimpleEntity? factory;

  int accountBossId;
  SimpleEntity? accountBoss;

  int adviserId;
  SimpleEntity? adviser;

  int territoryBossId;
  SimpleEntity? territoryBoss;

  AddressBranch businessAddress;
  AddressBranch fiscalAddress;
  AddressBranch paymentAddress;
  BillInfoBranch billInfo;

  BranchModel({
    this.id = '',
    required this.codeGp,
    required this.branchName,
    required this.nit,
    required this.latitude,
    required this.longitude,
    required this.clientId,
    this.client,
    required this.classificationId,
    this.classification,
    required this.factoryId,
    this.factory,
    required this.accountBossId,
    this.accountBoss,
    required this.adviserId,
    this.adviser,
    required this.territoryBossId,
    this.territoryBoss,
    required this.businessAddress,
    required this.fiscalAddress,
    required this.paymentAddress,
    required this.billInfo,
  });

  factory BranchModel.fromJson(Map<String, dynamic> data) {
    // final data = json['data'];

    return BranchModel(
      id: data['id'].toString(),
      codeGp: data['codeGp'],
      branchName: data['branchName'],
      nit: data['nit'],
      latitude: double.parse(data['latitude']),
      longitude: double.parse(data['longitude']),
      clientId: data['client']['id'],
      client: SimpleEntity.fromJson(data['client']),
      classificationId: data['classification']['id'],
      classification: SimpleEntity.fromJson(data['classification']),
      factoryId: data['factory']['id'],
      factory: SimpleEntity.fromJson(data['factory']),
      accountBossId: data['accountBoss']['id'],
      accountBoss: SimpleEntity.fromJson(data['accountBoss']),
      adviserId: data['adviser']['id'],
      adviser: SimpleEntity.fromJson(data['adviser']),
      territoryBossId: data['territoryBoss']['id'],
      territoryBoss: SimpleEntity.fromJson(data['territoryBoss']),
      businessAddress: AddressBranch.fromNestedJson(data['businessAddress']),
      fiscalAddress: AddressBranch.fromNestedJson(data['fiscalAddress']),
      paymentAddress: AddressBranch.fromNestedJson(data['paymentAddress']),
      billInfo: BillInfoBranch.fromNestedJson(data['billInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
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



class SimpleEntity {
  final int id;
  final String name;

  SimpleEntity({required this.id, required this.name});

  factory SimpleEntity.fromJson(Map<String, dynamic> json) {
    return SimpleEntity(
      id: json['id'],
      name: json['name'],
    );
  }
}
