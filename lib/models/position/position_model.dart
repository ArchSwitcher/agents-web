import 'package:agents_app/models/common/simple_entity_model.dart';
import 'package:agents_app/models/position/day_model.dart';
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
  String initTime;
  String endTime;
  String serviceQuantity;
  String serviceAgent;
  String scheduleQuantity;
  String servicePrice;
  String bonus;
  String meals;
  String shiftValue;
  String minimunPrice;
  String departament;
  String remarks;
  String document;
  String prosena;
  String positionName;
  String paymentFrequency;
  String agencyId;
  String transportId;
  String addressId;
  String branchId;
  String companyId;
  String serviceTypeId;
  String shiftTimeId;
  String countryService;
  String transportationCost;
  String adviserId;
  String supportDocument;

  SimpleEntity? agency;
  SimpleEntity? branch;
  SimpleEntity? company;
  SimpleEntity? shiftTime;
  SimpleEntity? serviceType;
  SimpleEntity? transport;

  List<DayModel> days;
  List<EquipmentModel> equipment;

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
    required this.initTime,
    required this.endTime,
    required this.serviceQuantity,
    required this.serviceAgent,
    required this.scheduleQuantity,
    required this.servicePrice,
    required this.bonus,
    required this.meals,
    required this.shiftValue,
    required this.minimunPrice,
    required this.departament,
    required this.remarks,
    required this.document,
    required this.prosena,
    required this.positionName,
    required this.paymentFrequency,
    required this.agencyId,
    required this.transportId,
    required this.addressId,
    required this.branchId,
    required this.companyId,
    required this.serviceTypeId,
    required this.shiftTimeId,
    required this.countryService,
    required this.transportationCost,
    required this.adviserId,
    required this.supportDocument,
    required this.days,
    required this.equipment,
    this.agency,
    this.branch,
    this.company,
    this.shiftTime,
    this.serviceType,
    this.transport,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    final p = json;

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
      initTime: str(p['Init_time']),
      endTime: str(p['End_time']),
      serviceQuantity: str(p['Service_quantity']),
      serviceAgent: str(p['Service_agent']),
      scheduleQuantity: str(p['Schedule_quantity']),
      servicePrice: str(p['Service_price']),
      bonus: str(p['Bonus']),
      meals: p['Meals'] == "1" || p['Meals'] == true ? "true" : "false",
      shiftValue: str(p['ShiftValue']),
      minimunPrice: str(p['Minimun_price']),
      departament: str(p['Departament']),
      remarks: str(p['Remarks']),
      document: str(p['Document']),
      prosena: str(p['Prosena']),
      positionName: str(p['Position_name']),
      paymentFrequency: str(p['Payment_frequency']),
      agencyId: str(p['AGENCY_Id']),
      transportId: str(p['TRANSPORT_Id']),
      addressId: str(p['ADDRESS_Id']),
      branchId: str(p['BRANCH_Id']),
      companyId: str(p['COMPANY_Id']),
      serviceTypeId: str(p['SERVICE_TYPE_Id']),
      shiftTimeId: str(p['SHIFT_TIME_Id']),
      countryService: str(p['Country_service']),
      transportationCost: str(p['Transportation_cost']),
      adviserId: str(p['BOSS_POSITIONs']?[0]?['EMPLOYEE']?['Id']),
      supportDocument: '',

      agency: p['AGENCY'] != null ? SimpleEntity.fromJson(p['AGENCY']) : null,
      branch: p['BRANCH'] != null ? SimpleEntity.fromJson(p['BRANCH']) : null,
      company: p['COMPANY'] != null ? SimpleEntity.fromJson(p['COMPANY']) : null,
      shiftTime: p['SHIFT_TIME'] != null ? SimpleEntity.fromJson(p['SHIFT_TIME']) : null,
      serviceType: p['SERVICE_TYPE'] != null ? SimpleEntity.fromJson(p['SERVICE_TYPE']) : null,
      transport: p['TRANSPORT'] != null ? SimpleEntity.fromJson(p['TRANSPORT']) : null,
      days: (p['ASIGN_DAYs'] as List?)?.map((d) => DayModel.fromJson(d)).toList() ?? [],
      equipment: (p['EQUIPMENTs'] as List?)?.map((e) => EquipmentModel.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "location": location,
      "latitude": latitude,
      "longitude": longitude,
      "physical_address": physicalAddress,
      "fiscal_address": fiscalAddress,
      "billingAddress": billingAddress,
      "init_date": initDate,
      "end_date": endDate,
      "init_time": initTime,
      "end_time": endTime,
      "service_quantity": serviceQuantity,
      "service_agent": serviceAgent,
      "schedule_quantity": scheduleQuantity,
      "service_price": servicePrice,
      "bonus": bonus,
      "meals": meals,
      "shiftValue": shiftValue,
      "minimun_price": minimunPrice,
      "departament": departament,
      "remarks": remarks,
      "document": document,
      "prosena": prosena,
      "position_name": positionName,
      "payment_frequency": paymentFrequency,
      "AGENCY_Id": agencyId,
      "TRANSPORT_Id": transportId,
      "ADDRESS_Id": addressId,
      "BRANCH_Id": branchId,
      "COMPANY_Id": companyId,
      "SERVICE_TYPE_Id": serviceTypeId,
      "SHIFT_TIME_Id": shiftTimeId,
      "country_service": countryService,
      "transportation_cost": transportationCost,
      "adviser_id": adviserId,
      "support_document": supportDocument,
      "days": days.map((e) => e.toJson()).toList(),
      "equipment": equipment.map((e) => e.toJson()).toList(),
    };
  }
}
