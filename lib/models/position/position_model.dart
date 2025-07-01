import 'package:agents_app/models/address/address_model.dart';
import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/models/common/simple_entity_model.dart';
import 'package:agents_app/models/position/equipment_model.dart';

class PositionModel {
  String? id;
  String name;
  String location;
  String latitude;
  String longitude;
  String physicalAddress;
  String fiscalAddress;
  String billingAddress;
  String initDate;
  String endDate;
  String serviceQuantity;
  String scheduleQuantity;
  String servicePrice;
  String? bonus;
  String? meals;
  String? shiftValue;
  String? minimunPrice;
  String departament;
  String? remarks;
  String? document;
  String? prosena;
  String positionName;
  String paymentFrequency;
  String agencyId;
  String? transportId;
  String addressId;
  String branchId;
  String companyId;
  String serviceTypeId;
  String shiftTimeId;
  String countryService;
  String? transportationCost;
  String? adviserId;
  String? supportDocument;

  SimpleEntity? agency;
  SimpleEntity? transport;
  SimpleEntity? branch;
  SimpleEntity? company;
  SimpleEntity? shiftTime;
  SimpleEntity? serviceType;
  SimpleEntity? group;
  SimpleEntity? client;
  SimpleEntity? statusType;
  
  TurnModel? turn;
  List<EquipmentModel> equipment;
  List<SupportDocumentModel>? supportDocuments;
  AddressModel? address;

  PositionModel({
    this.id,
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.physicalAddress,
    required this.fiscalAddress,
    required this.billingAddress,
    required this.initDate,
    required this.endDate,
    required this.serviceQuantity,
    required this.scheduleQuantity,
    required this.servicePrice,
    this.bonus,
    this.meals,
    this.shiftValue,
    this.minimunPrice,
    required this.departament,
    this.remarks,
    this.document,
    this.prosena,
    required this.positionName,
    required this.paymentFrequency,
    required this.agencyId,
    this.transportId,
    required this.addressId,
    required this.branchId,
    required this.companyId,
    required this.serviceTypeId,
    required this.shiftTimeId,
    required this.countryService,
    this.transportationCost,
    this.adviserId,
    this.supportDocument,
    required this.equipment,
    this.agency,
    this.branch,
    this.company,
    this.shiftTime,
    this.serviceType,
    this.transport,
    this.group,
    this.client,
    this.turn,
    this.supportDocuments,
    this.address,
  });

  factory PositionModel.fromJson(Map<String, dynamic> p) {
    String str(dynamic v) => v == null ? '' : v.toString();

    return PositionModel(
      id: str(p['Id']),
      name: str(p['Name']),
      location: str(p['Location']),
      latitude: str(p['Latitude']),
      longitude: str(p['Longitude']),
      physicalAddress: str(p['Physical_address']),
      fiscalAddress: str(p['Fiscal_address']),
      billingAddress: str(p['BillingAddress']),
      initDate: str(p['Init_date']),
      endDate: str(p['End_date']),
      serviceQuantity: str(p['Service_quantity']),
      scheduleQuantity: str(p['Schedule_quantity']),
      servicePrice: str(p['Service_price']),
      bonus: p['Bonus'] != null ? str(p['Bonus']) : null,
      meals: p['Meals'] != null
          ? (p['Meals'] == "1" || p['Meals'] == true ? "true" : "false")
          : null,
      shiftValue: p['ShiftValue'] != null ? str(p['ShiftValue']) : null,
      minimunPrice: p['Minimun_price'] != null ? str(p['Minimun_price']) : null,
      departament: str(p['Departament']),
      remarks: p['Remarks'] != null ? str(p['Remarks']) : null,
      document: p['Document'] != null ? str(p['Document']) : "",
      prosena: str(p['Prosena']),
      positionName: str(p['Position_name']),
      paymentFrequency: str(p['Payment_frequency']),
      agencyId: str(p['AGENCY_Id']),
      transportId: p['TRANSPORT_Id'] != null ? str(p['TRANSPORT_Id']) : null,
      addressId: str(p['ADDRESS_Id']),
      branchId: str(p['BRANCH_Id']),
      companyId: str(p['COMPANY_Id']),
      serviceTypeId: str(p['SERVICE_TYPE_Id']),
      shiftTimeId: str(p['SHIFT_TIME_Id']),
      countryService: str(p['Country_service']),
      transportationCost: p['Transportation_cost'] != null
          ? str(p['Transportation_cost'])
          : null,
      adviserId: str(p['BOSS_POSITIONs']?[0]?['EMPLOYEE']?['Id']),
      agency: p['AGENCY'] != null
          ? SimpleEntity.fromJson({
              "id": p['AGENCY']['Id'],
              "name": p['AGENCY']['Name'],
            })
          : null,
      branch: p['BRANCH'] != null
          ? SimpleEntity.fromJson({
              "id": p['BRANCH']['Id'],
              "name": p['BRANCH']['Branch_name'],
            })
          : null,
      company: p['COMPANY'] != null
          ? SimpleEntity.fromJson({
              "id": p['COMPANY']['Id'],
              "name": p['COMPANY']['Name'],
            })
          : null,
      shiftTime: p['SHIFT_TIME'] != null
          ? SimpleEntity.fromJson({
              "id": p['SHIFT_TIME']['Id'],
              "name": p['SHIFT_TIME']['Name'],
            })
          : null,
      serviceType: p['SERVICE_TYPE'] != null
          ? SimpleEntity.fromJson({
              "id": p['SERVICE_TYPE']['Id'],
              "name": p['SERVICE_TYPE']['Name'],
            })
          : null,
      transport: p['TRANSPORT'] != null
          ? SimpleEntity.fromJson({
              "id": p['TRANSPORT']['Id'],
              "name": p['TRANSPORT']['Name'],
            })
          : null,
      group: p['GROUP'] != null
          ? SimpleEntity.fromJson({
              "id": p['GROUP']['Id'],
              "name": p['GROUP']['Name'],
            })
          : null,
      client: p['CLIENT'] != null
          ? SimpleEntity.fromJson({
              "id": p['CLIENT']['Id'],
              "name": p['CLIENT']['Name'],
            })
          : null,
      turn: p['TURN'] != null ? TurnModel.fromJson(p['TURN']) : null,
      address: p['ADDRESS'] != null
          ? AddressModel.fromNestedJson(p['ADDRESS'])
          : null,
      supportDocuments: (p['SUPPORT_DOCUMENTs'] as List?)
              ?.map((e) => SupportDocumentModel.fromJson(e))
              .toList() ??
          [],
      equipment: (p['EQUIPMENTs'] as List?)
              ?.map((e) => EquipmentModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "location": location,
      "latitude": double.tryParse(latitude) ?? 0.0,
      "longitude": double.tryParse(longitude) ?? 0.0,
      "physicalAddress": physicalAddress,
      "fiscalAddress": fiscalAddress,
      "billingAddress": billingAddress,
      "initDate": initDate,
      "endDate": endDate,
      "serviceQuantity": int.tryParse(serviceQuantity) ?? 0,
      "scheduleQuantity": int.tryParse(scheduleQuantity) ?? 0,
      "bonus": double.tryParse(bonus ?? "0") ?? 0.0,
      "meals": meals ?? "",
      "shiftValue": int.tryParse(shiftValue ?? "0") ?? 0,
      "minimunPrice": double.tryParse(minimunPrice ?? "0") ?? 0.0,
      "servicePrice": double.tryParse(servicePrice) ?? 0.0,
      "departament": departament,
      "remarks": remarks,
      "document": document,
      "positionName": positionName,
      "paymentFrequency": paymentFrequency,
      "agencyId": int.tryParse(agencyId) ?? 0,
      "transportId": transportId != null ? int.tryParse(transportId!) : null,
      "addressId": int.tryParse(addressId) ?? 0,
      "branchId": int.tryParse(branchId) ?? 0,
      "companyId": int.tryParse(companyId) ?? 0,
      "serviceTypeId": int.tryParse(serviceTypeId) ?? 0,
      "shiftTimeId": int.tryParse(shiftTimeId) ?? 0,
      "countryService": countryService,
      "transportationCost": double.tryParse(transportationCost ?? "0") ?? 0.0,
      "turnId": turn?.id != null ? int.tryParse(turn!.id!) : null,
      "request": {
        "dataTime":
            DateTime.now().toString().split('.').first.replaceFirst('T', ' '),
      },
      "equipment": equipment.map((e) => e.toJson()).toList(),
      "supportDocument": supportDocument ?? "-",
    };
  }
}


class SupportDocumentModel {
  final String id;
  final String url;

  SupportDocumentModel({
    required this.id,
    required this.url,
  });

  factory SupportDocumentModel.fromJson(Map<String, dynamic> json) {
    return SupportDocumentModel(
      id: json['Id']?.toString() ?? json['id']?.toString() ?? '',
      url: json['Url']?.toString() ?? json['url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": int.tryParse(id) ?? 0,
      "url": url,
    };
  }
}


/*
OPCIONALES
bonus	String?
meals	String?
shiftValue	String?
minimunPrice	String?
remarks	String?
document	String?
prosena	String?
transportationCost	String?
supportDocument	String?
 */