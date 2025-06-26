import 'package:agents_app/models/address/address_model.dart';
import 'package:agents_app/models/common/simple_entity_model.dart';
import 'package:agents_app/models/schedule/schedule_days_model.dart';

class BranchModel {
  String id = '';
  String codeGp;
  String branchName;
  String nit;
  double latitude;
  double longitude;

  String clientId;
  SimpleEntity? client;

  String classificationId;
  SimpleEntity? classification;

  String factoryId;
  SimpleEntity? factory;

  String accountBossId;
  SimpleEntity? accountBoss;

  String adviserId;
  SimpleEntity? adviser;

  Address businessAddress;

  final List<Turn> turns;


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
    required this.businessAddress,
    required this.turns,
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
      clientId: data['client']['id'] != null ? data['client']['id'].toString() : '',
      client: SimpleEntity.fromJson(data['client']),
      classificationId: data['classification']['id'] != null ? data['classification']['id'].toString() : '',
      classification: SimpleEntity.fromJson(data['classification']),
      factoryId: data['factory']['id'] != null ? data['factory']['id'].toString() : '',
      factory: SimpleEntity.fromJson(data['factory']),
      accountBossId: data['accountBoss']['id'] != null ? data['accountBoss']['id'].toString() : '',
      accountBoss: SimpleEntity.fromJson(data['accountBoss']),
      adviserId: data['adviser']['id'] != null ? data['adviser']['id'].toString() : '',
      adviser: SimpleEntity.fromJson(data['adviser']),
      businessAddress: Address.fromNestedJson(data['businessAddress']),
      turns: (data['turns'] as List<dynamic>)
          .map((item) => Turn.fromJson(item as Map<String, dynamic>))
          .toList(),
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
      "businessAddress": businessAddress.toJson(),
      "turns": turns.map((item) => item.toJson()).toList(),
    };
  }
}



class Turn {
   String? id;
   String name;
   List<DailySchedule> schedule;

  Turn({
    this.id,
    required this.name,
    required this.schedule,
  });

  factory Turn.fromJson(Map<String, dynamic> json) {
    return Turn(
      id: json['id'].toString(),
      name: json['Name'].toString(),
      schedule: (json['schedule'] as List<dynamic>)
          .map((item) => DailySchedule.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'schedule': schedule.map((item) => item.toJson()).toList(),
    };
  }
}
