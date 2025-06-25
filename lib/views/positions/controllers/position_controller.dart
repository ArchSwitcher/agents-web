import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/position/day_model.dart';
import 'package:agents_app/models/position/equipment_model.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/services/employee_dropdown_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/views/positions/services/position_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PositionController extends GetxController {
  final GenericListController genericListController =
      Get.put(GenericListController());

  RxBool isLoadingEmployee = true.obs;
  final EmployeeDropdownService employeeDropdownService =
      Get.put(EmployeeDropdownService());

  final ManageGroupController groupController =
      Get.put(ManageGroupController());

  final positionServices = PositionServices();

  final RxBool isLoadingPosition = false.obs;
  final RxBool isLoadingPositions = true.obs;

  final Rx<DropDownOption> group =
      DropDownOption(id: '', label: 'Seleccione un grupo').obs;
  final Rx<DropDownOption> client =
      DropDownOption(id: '', label: 'Seleccione un cliente').obs;
  final Rx<DropDownOption> branch =
      DropDownOption(id: '', label: 'Seleccione una sucursal').obs;
  final Rx<DropDownOption> adviser =
      DropDownOption(id: '', label: 'Seleccione un asesor').obs;
  final Rx<DropDownOption> company =
      DropDownOption(id: '', label: 'Seleccione una sucursal').obs;
  final Rx<DropDownOption> agency =
      DropDownOption(id: '', label: 'Seleccione un asesor').obs;
  final Rx<DropDownOption> statusType =
      DropDownOption(id: '', label: 'Seleccione un estado').obs; // statusType

  final RxList<DropDownOption> advisers = <DropDownOption>[].obs;

  final Rx<DropDownOption> serviceType =
      DropDownOption(id: '', label: 'Seleccione un tipo de servicio').obs;

// Equipment related fields
  final Rx<DropDownOption> equipmentType =
      DropDownOption(id: '', label: 'Seleccione un tipo de equipo').obs;
  final TextEditingController equipmentQuantity = TextEditingController();

  // Shift related fields

  final Rx<DropDownOption> shiftTime =
      DropDownOption(id: '', label: 'Seleccione un turno').obs;

  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  final TextEditingController serviceQuantity = TextEditingController();
  final TextEditingController scheduleQuantity = TextEditingController();

  final TextEditingController serviceAgent = TextEditingController();
  final TextEditingController bonus = TextEditingController();
  final TextEditingController transport = TextEditingController();
  final TextEditingController foodQuantity = TextEditingController();
  final TextEditingController shiftValue = TextEditingController();
  final TextEditingController minimumPrice = TextEditingController();
  final TextEditingController servicePrice = TextEditingController();

  Rx<DropDownOption> department =
      DropDownOption(id: '', label: 'Seleccione una departamento').obs;
  Rx<DropDownOption> municipality =
      DropDownOption(id: '', label: '').obs;

  TextEditingController subCity = TextEditingController();
  Rx<DropDownOption> zone =
      DropDownOption(id: '', label: 'Seleccione una zona').obs;
  TextEditingController address = TextEditingController();
  TextEditingController observations = TextEditingController();

  final RxList<EquipmentModel> equipmentList = <EquipmentModel>[].obs;

  final RxList<PositionModel> positions = <PositionModel>[].obs;

  void clearFields() {
    startTime.clear();
    endTime.clear();
    startDate.clear();
    endDate.clear();
    serviceQuantity.clear();
    scheduleQuantity.clear();
    bonus.clear();
    serviceAgent.clear();
    transport.clear();
    foodQuantity.clear();
    shiftValue.clear();
    minimumPrice.clear();
    servicePrice.clear();
    subCity.clear();
    address.clear();
    observations.clear();
    equipmentList.clear();
  }

  final weekDays = <WeekDay>[
    WeekDay(
      id: 1,
      name: "Lunes",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      id: 2,
      name: "Martes",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      id: 3,
      name: "Miércoles",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      id: 4,
      name: "Jueves",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      id: 5,
      name: "Viernes",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      id: 6,
      name: "Sábado",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
    WeekDay(
      id: 7,
      name: "Domingo",
      startTimeController: TextEditingController(text: "00:00"),
      endTimeController: TextEditingController(text: "00:00"),
      isSelected: false.obs,
    ),
  ].obs;

  void toggleWeekDay(WeekDay day) {
    day.isSelected.value = !day.isSelected.value;

    if (!day.isSelected.value) {
      day.startTimeController.text = "00:00";
      day.endTimeController.text = "00:00";
    }
  }

  List<Map<String, String>> getSelectedDays() {
    return weekDays
        .where((day) => day.isSelected.value == true)
        .map((day) => {
              "day": day.name,
              "startTime": day.startTimeController.text,
              "endTime": day.endTimeController.text,
            })
        .toList();
  }

  addEquipment(DropDownOption equipment, String quantity) {
    if (equipment.id.isEmpty || quantity.isEmpty) {
      ToastService.warning(
          title: "Advertencia",
          subTitle: "Por favor, complete todos los campos.");
      return;
    }
    ToastService.success(
        title: "Equipo", subTitle: "Equipo agregado correctamente.");

    equipmentList.add(EquipmentModel(
        quantity: int.parse(quantity),
        cost: 0,
        currency: "GTQ",
        equipmentTypeId: int.parse(equipment.id)));

    equipmentType.value =
        DropDownOption(id: '', label: 'Seleccione un tipo de equipo');
    equipmentQuantity.clear();
  }

  deleteEquipment(int index) {
    if (index < 0 || index >= equipmentList.length) {
      ToastService.warning(
          title: "Advertencia", subTitle: "Índice de equipo no válido.");
      return;
    }
    equipmentList.removeAt(index);
    ToastService.success(
        title: "Equipo", subTitle: "Equipo eliminado correctamente.");
  }

  fetchPositions() async {
    isLoadingPositions.value = true;
    try {
      positions.value = await positionServices.getAll("3");
    } catch (e) {
      ToastService.error(
        title: "Posiciones",
        subTitle: "Error al cargar posiciones: $e",
      );
    } finally {
      isLoadingPositions.value = false;
    }
  }

  Future<bool> newUpdatePosition(String? idPosition) async {
    try {
      isLoadingPosition.value = true;
      // final positionData = {
      //   "id": idPosition,
      //   "name": "posicion ${DateTime.now().toIso8601String()}",
      //   "groupId": group.value.id,
      //   "clientId": client.value.id,
      //   "branchId": branch.value.id,
      //   "adviserId": adviser.value.id,
      //   "companyId": company.value.id,
      //   "agencyId": agency.value.id,
      //   "serviceTypeId": serviceType.value.id,
      //   "shiftTimeId": shiftTime.value.id,
      //   "startTime": startTime.text,
      //   "endTime": endTime.text,
      //   "startDate": startDate.text,
      //   "endDate": endDate.text,
      //   "serviceQuantity": serviceQuantity.text,
      //   "scheduleQuantity": scheduleQuantity.text,
      //   "bonus": bonus.text,
      //   "serviceAgent": serviceAgent.text,
      //   "transport": transport.text,
      //   "foodQuantity": foodQuantity.text,
      //   "shiftValue": shiftValue.text,
      //   "minimumPrice": minimumPrice.text,
      //   "servicePrice": servicePrice.text,
      //   "departmentId": department.value.id,
      //   "subCity": subCity.text,
      //   "zoneId": zone.value.id,
      //   "address": address.text,
      //   "observations": observations.text,
      // };

      final List<DayModel> days = weekDays
          .map((day) => DayModel(
              initTime: day.startTimeController.text,
              endTime: day.endTimeController.text,
              daysId: day.id))
          .toList();

      PositionModel positionData = PositionModel(
        id: idPosition,
        branchId: branch.value.id,
        adviserId: adviser.value.id,
        companyId: company.value.id,
        agencyId: agency.value.id,
        serviceTypeId: serviceType.value.id,
        shiftTimeId: shiftTime.value.id,
        endTime: endTime.text,
        endDate: endDate.text,
        serviceQuantity: serviceQuantity.text,
        scheduleQuantity: scheduleQuantity.text,
        bonus: bonus.text, //should be nullable
        serviceAgent: serviceAgent.text,
        transportId: "1",
        shiftValue: shiftValue.text,
        minimunPrice: minimumPrice.text,
        servicePrice: servicePrice.text,
        departament: department.value.label,
        countryService: "Guatemala",
        location: subCity.text,
        paymentFrequency: shiftTime.value.label,
        transportationCost: transport.text,
        initDate: startDate.text,
        initTime: startTime.text,
        days: days,
        equipment: equipmentList,
        remarks: observations.text, //should be nullable

        //has left
        supportDocument: "https://example.com/document.pdf",
        meals: null,
        document: null,
        // valor del turno
        // precio minimo
        // foodQuantity: foodQuantity.text,
        //zoneId: zone.value.id,
        name: "posicion ${DateTime.now().toIso8601String()}",
        addressId: "12",
        latitude: "0.0",
        longitude: "0.0",
        physicalAddress: "Dirección física",
        fiscalAddress: "Dirección fiscal",
        billingAddress: "Dirección de facturación",
        positionName: "Posición de prueba",
        // groupId: group.value.id,
        // clientId: client.value.id,
      );

      final selectedDays = getSelectedDays();
      if (selectedDays.isEmpty) {
        ToastService.warning(
            title: 'Advertencia', subTitle: 'Seleccione al menos un día.');
        return false;
      }

      // PositionModel positionDataData = PositionModel.fromJson(positionData);

      final position = await positionServices.create(positionData);

      if (position) {
        ToastService.success(
            title: 'Éxito', subTitle: 'Posición creada correctamente.');
      } else {
        ToastService.error(
            title: 'Error', subTitle: 'No se pudo crear la posición.');
      }
      return position;
    } catch (e) {
      ToastService.error(
          title: 'Error', subTitle: 'Error al crear la posición: $e');
      return false;
    } finally {
      isLoadingPosition.value = false;
    }
  }

  // function to load all data for the position form should be recieve arguments PositionModel

  Future<void> loadPositionData(PositionModel position) async {
    try {
      isLoadingPosition.value = true;

      group.value = DropDownOption(
          id: position.group?.id ?? '',
          label: position.group?.name ?? '');
      print("position group: ${position.group?.name}");
      client.value = DropDownOption(
          id: position.client?.id ?? '',
          label: position.client?.name ?? '');
      branch.value = DropDownOption(
          id: position.branchId,
          label: position.branch!.name);
      adviser.value = DropDownOption(
          id: position.adviserId,
          label: position.adviser!.name);
      company.value = DropDownOption(
          id: position.companyId ,
          label: position.company!.name );
      agency.value = DropDownOption(
          id: position.agencyId ,
          label: position.agency!.name);
      serviceType.value = DropDownOption(
          id: position.serviceTypeId,
          label: position.serviceType!.name);
      shiftTime.value = DropDownOption(
          id: position.shiftTimeId,
          label: position.shiftTime!.name);

      // Load other fields
      startTime.text = position.initTime ;
      endTime.text = position.endTime ;
      startDate.text = position.initDate;
      endDate.text = position.endDate ;
      serviceQuantity.text = position.serviceQuantity.toString() ;
      scheduleQuantity.text = position.scheduleQuantity.toString() ;
      bonus.text = position.bonus.toString() ;
      serviceAgent.text = position.serviceAgent.toString() ;
      transport.text = position.transportationCost.toString() ;
      foodQuantity.text = position.meals.toString() ;
      shiftValue.text = position.shiftValue.toString() ;
      minimumPrice.text = position.minimunPrice.toString() ;
      servicePrice.text = position.servicePrice.toString() ;

      department.value = DropDownOption(
          id: "", label: position.departament);
      subCity.text = position.location;
      zone.value = DropDownOption(
          id: '',
          label:
              'Seleccione una zona'); // Assuming zone is not provided in PositionModel
      address.text = position.physicalAddress;
      observations.text = position.remarks ?? '';

      // Load equipment list
      equipmentList.clear();
      equipmentList.addAll(position.equipment);

      // Load week days
      for (var day in position.days) {
        final weekDay = weekDays.firstWhere(
          (d) => d.id == day.daysId,
          orElse: () => WeekDay(
            id: day.daysId,
            name: 'Día ${day.daysId}',
            startTimeController: TextEditingController(text: day.initTime),
            endTimeController: TextEditingController(text: day.endTime),
            isSelected: false.obs,
          ),
        );
        weekDay.startTimeController.text = day.initTime;
        weekDay.endTimeController.text = day.endTime;
        weekDay.isSelected.value = true;
      }
    } catch (e) {
      ToastService.error(
          title: 'Error',
          subTitle: 'Error al cargar los datos de la posición: $e');
    } finally {
      isLoadingPosition.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPositions();
  }
}

class WeekDay {
  final int id;
  final String name;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final RxBool isSelected;

  WeekDay({
    required this.id,
    required this.name,
    required this.startTimeController,
    required this.endTimeController,
    required this.isSelected,
  });
}
