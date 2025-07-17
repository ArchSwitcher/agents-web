import 'package:agents_app/models/address/address_model.dart';
import 'package:agents_app/models/common/simple_entity_model.dart';
import 'package:agents_app/models/document/document_model.dart';
import 'package:agents_app/models/geofence/geofence_model.dart';
import 'package:agents_app/models/schedule/schedule_days_model.dart';
import 'package:get/get.dart';

class BranchModel {
  String? id;
  String? codeGp;
  String? branchName;
  String? nit;
  double? latitude;
  double? longitude;

  String? clientId;
  SimpleEntity? client;
  SimpleEntity? group;

  String? classificationId;
  SimpleEntity? classification;

  String? factoryId;
  SimpleEntity? factory;

  String? accountBossId;
  SimpleEntity? accountBoss;

  AddressModel? businessAddress;
  List<TurnModel>? turns;

  String? initTime;
  String? endTime;
  Geofence? geofence;

  bool? isEnabled;
  int? status;

  List<DocumentModel>? documents;
  int? positions;

  BranchModel({
    this.id,
    this.codeGp,
    this.branchName,
    this.nit,
    this.latitude,
    this.longitude,
    this.clientId,
    this.client,
    this.classificationId,
    this.classification,
    this.factoryId,
    this.factory,
    this.accountBossId,
    this.accountBoss,
    this.businessAddress,
    this.turns,
    this.initTime,
    this.endTime,
    this.geofence,
    this.group,
    this.isEnabled,
    this.status,
    this.documents,
    this.positions,
  });

 factory BranchModel.fromJson(Map<String, dynamic> data) {
  return BranchModel(
    id: data['Id']?.toString() ?? '',
    codeGp: data['Code_gp']?.toString() ?? '',
    branchName: data['Branch_name']?.toString() ?? '',
    nit: data['Nit']?.toString() ?? '',
    latitude: double.tryParse(data['latitude']?.toString() ?? '') ?? 0.0,
    longitude: double.tryParse(data['longitude']?.toString() ?? '') ?? 0.0,
    clientId: data['CLIENT_Id']?.toString() ?? '',
    client: (data['CLIENT'] is Map<String, dynamic>)
        ? SimpleEntity.fromJson(data['CLIENT'])
        : null,
    classificationId: data['CLASSIFICATION_Id']?.toString() ?? '',
    classification: (data['CLASSIFICATION'] is Map<String, dynamic>)
        ? SimpleEntity.fromJson(data['CLASSIFICATION'])
        : null,
    factoryId: data['FACTORY_ID']?.toString() ?? '',
    factory: (data['FACTORY'] is Map<String, dynamic>)
        ? SimpleEntity.fromJson(data['FACTORY'])
        : null,
    accountBossId: data['ACCOUNT_BOSS_Id']?.toString() ?? '',
    accountBoss: (data['ACCOUNT_BOSS'] is Map<String, dynamic>)
        ? SimpleEntity.fromJson(data['ACCOUNT_BOSS'])
        : null,
    businessAddress: (data['ADDRESS'] is Map<String, dynamic>)
        ? AddressModel.fromNestedJson(data['ADDRESS'])
        : null,
    turns: (data['BRANCH_TURNs'] is List)
        ? (data['BRANCH_TURNs'] as List)
            .map((item) => TurnModel.fromJson(item))
            .toList()
        : [],
    initTime: data['init_time']?.toString() ?? '',
    endTime: data['end_time']?.toString() ?? '',
    geofence: (data['GEOFENCE'] is Map<String, dynamic>)
        ? Geofence.fromJson(data['GEOFENCE'])
        : null,
    isEnabled: data['Is_enabled'] == 1 || data['Is_enabled'] == true,
    status: (data['Status'] is int)
        ? data['Status']
        : int.tryParse(data['Status']?.toString() ?? '') ?? 1,
    group: (data['GROUP'] is Map<String, dynamic>)
        ? SimpleEntity.fromJson(data['GROUP'])
        : null,
    positions: (data['POSITIONS'] is int)
        ? data['POSITIONS']
        : int.tryParse(data['POSITIONS']?.toString() ?? '') ?? 0,
  );
}


  Map<String, dynamic> toJson() {
    return {
      "branchName": branchName,
      "nit": nit,
      "codeGp": codeGp,
      "clientId": clientId,
      "classificationId": classificationId,
      "factoryId": factoryId,
      "latitude": latitude,
      "longitude": longitude,
      "isEnabled": isEnabled,
      "initTime": initTime,
      "endTime": endTime,
      "paymentAddress": businessAddress?.toJson(),
      "geofence": geofence?.toJson(),
      "documentBranch": documents?.map((doc) => doc.toJson()).toList(),
      "assignationDays": turns?.map((turn) => turn.toJson()).toList(),
    };
  }
}

class TurnModel {
  String? id;
  String name;
  List<DailySchedule> schedule;
  RxBool isSelected = true.obs;

  TurnModel({
    this.id,
    required this.name,
    required this.schedule,
    RxBool? isSelected,
  }) : isSelected = isSelected ?? true.obs;

  factory TurnModel.fromJson(Map<String, dynamic> json) {
    return TurnModel(
        id: json['Id'].toString(),
        name: json['Name'].toString(),
        schedule: (json['ASIGN_DAYs'] as List<dynamic>)
            .map((item) => DailySchedule.fromJson(item as Map<String, dynamic>))
            .toList(),
        isSelected: RxBool(json['isSelected'] != null));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'turn': name,
      'days': schedule.map((item) => item.toJson()).toList(),
    };
  }
}
