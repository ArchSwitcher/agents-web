import 'package:agents_app/models/address/address_model.dart';
import 'package:agents_app/models/common/simple_entity_model.dart';
import 'package:agents_app/models/document/document_model.dart';
import 'package:agents_app/models/geofence/geofence_model.dart';
import 'package:agents_app/models/schedule/schedule_days_model.dart';
import 'package:get/get.dart';

class BranchModel {
  String id = '';
  String codeGp;
  String branchName;
  String nit;
  double latitude;
  double longitude;

  String clientId;
  SimpleEntity? client;
  SimpleEntity? group;

  String classificationId;
  SimpleEntity? classification;

  String factoryId;
  SimpleEntity? factory;

  String accountBossId;
  SimpleEntity? accountBoss;



  AddressModel? businessAddress;
  List<TurnModel> turns;

  // Campos nuevos del JSON
  String initTime;
  String endTime;
  
  Geofence? geofence;
  
  bool isEnabled;
  int status;

  List<DocumentModel> documents;
  int positions;

  // Aquí puedes luego implementar contactos y nombres comerciales si es necesario

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
    required this.businessAddress,
    required this.turns,
    required this.initTime,
    required this.endTime,
    this.geofence,
    this.group,
    required this.isEnabled,
    required this.status,
    required this.documents,
    this.positions = 0,
  });

  factory BranchModel.fromJson(Map<String, dynamic> data) {
    return BranchModel(
      id: data['Id'].toString(),
      codeGp: data['Code_gp'] ?? '',
      branchName: data['Branch_name'] ?? '',
      nit: data['Nit'] ?? '',
      latitude: double.tryParse(data['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(data['longitude'].toString()) ?? 0.0,
      clientId: data['CLIENT_Id']?.toString() ?? '',
      client:
          data['CLIENT'] != null ? SimpleEntity.fromJson(data['CLIENT']) : null,
      classificationId: data['CLASSIFICATION_Id']?.toString() ?? '',
      classification: data['CLASSIFICATION'] != null
          ? SimpleEntity.fromJson(data['CLASSIFICATION'])
          : null,
      factoryId: data['FACTORY_ID']?.toString() ?? '',
      factory: data['FACTORY'] != null
          ? SimpleEntity.fromJson(data['FACTORY'])
          : null,
      accountBossId: data['ACCOUNT_BOSS_Id']?.toString() ?? '',
      accountBoss: data['ACCOUNT_BOSS'] != null
          ? SimpleEntity.fromJson(data['ACCOUNT_BOSS'])
          : null,

      businessAddress: data['ADDRESS'] != null ? AddressModel.fromNestedJson(data['ADDRESS']) : null,
      turns: (data['BRANCH_TURNs'] as List<dynamic>?)
              ?.map((item) => TurnModel.fromJson(item))
              .toList() ??
          [],
      initTime: data['init_time'] ?? '',
      endTime: data['end_time'] ?? '',

      geofence:
          data['GEOFENCE'] != null ? Geofence.fromJson(data['GEOFENCE']) : null,

      isEnabled: data['Is_enabled'] == 1,
      status: data['Status'] ?? 1,
      documents: (data['DOCUMENTs'] as List<dynamic>?)
              ?.map((item) => DocumentModel.fromJson(item))
              .toList() ??
          [],
      group: data['GROUP'] != null
          ? SimpleEntity.fromJson(data['GROUP'])
          : null,
      positions: data['POSITIONS'] ?? 0,
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
      "documentBranch": documents.map((doc) => doc.toJson()).toList(),
      "assignationDays": turns.map((turn) => turn.toJson()).toList(),
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
      isSelected: RxBool(json['isSelected'] != null)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'turn': name,
      'days': schedule.map((item) => item.toJson()).toList(),
    };
  }
}

