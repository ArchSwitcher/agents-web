import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/address/address_model.dart';
import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/common/simple_entity_model.dart';
import 'package:agents_app/models/schedule/schedule_days_model.dart';
import 'package:agents_app/services/employee_dropdown_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/branches/services/branch_service.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchController extends GetxController {
  final ManageGroupController groupController =
      Get.put(ManageGroupController());

  final ManageClientController clientController =
      Get.put(ManageClientController());

  final GenericListController genericListController =
      Get.put(GenericListController());

  final EmployeeDropdownService employeeDropdownService =
      Get.put(EmployeeDropdownService());

  final BranchService _branchService = BranchService();

  // Controllers for form fields
  final codeGpController = TextEditingController();
  final nameController = TextEditingController();
  final nitController = TextEditingController();
  final socialReasonController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();
  Rx<DropDownOption> groupId = DropDownOption(id: '', label: '').obs;

  Rx<DropDownOption> client = DropDownOption(id: '', label: '').obs;

  RxBool isLoadingAdviser = true.obs;
  RxBool isLoadingAccountBoss = true.obs;
  RxBool isLoadingBillPerson = true.obs;

  RxList<DropDownOption> advisers = <DropDownOption>[].obs;
  RxList<DropDownOption> accountBosses = <DropDownOption>[].obs;
  RxList<DropDownOption> billPersons = <DropDownOption>[].obs;

  Rx<DropDownOption> adviser = DropDownOption(id: '', label: '').obs;
  // Rx<DropDownOption> territoryManager =
  //     DropDownOption(id: '', label: 'Seleccione un gerente de territorio').obs; //! se debe de quitar
  Rx<DropDownOption> accountBoss = DropDownOption(id: '', label: '').obs;

  Rx<DropDownOption> employee = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> classification = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> city = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> country = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> zone = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> billingType = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> generationType = DropDownOption(id: '', label: '').obs;
  Rx<DropDownOption> factory = DropDownOption(id: '', label: '').obs;

  // Rx<DropDownOption> fiscalCountry =
  //     DropDownOption(id: '', label: 'Seleccione un país fiscal').obs;
  // Rx<DropDownOption> fiscalDepartment =
  //     DropDownOption(id: '', label: 'Seleccione un departamento fiscal').obs;
  // Rx<DropDownOption> fiscalZone =
  //     DropDownOption(id: '', label: 'Seleccione una zona fiscal').obs;
  // final TextEditingController fiscalAddress = TextEditingController();

  Rx<DropDownOption> physicalCountry =
      DropDownOption(id: '', label: 'Seleccione un país').obs;
  Rx<DropDownOption> physicalDepartment =
      DropDownOption(id: '', label: 'Seleccione un departamento').obs;
  Rx<DropDownOption> physicalZone =
      DropDownOption(id: '', label: 'Seleccione una zona').obs;
  Rx<DropDownOption> municipality = DropDownOption(id: '', label: '').obs;
  final TextEditingController physicalAddress = TextEditingController();

  // Rx<DropDownOption> paymentCountry =
  //     DropDownOption(id: '', label: 'Seleccione un país').obs;
  // Rx<DropDownOption> paymentDepartment =
  //     DropDownOption(id: '', label: 'Seleccione un departamento').obs;
  // Rx<DropDownOption> paymentZone =
  //     DropDownOption(id: '', label: 'Seleccione una zona').obs;
  // final TextEditingController paymentAddress = TextEditingController();

  // Reactive variables
  RxBool isLoading = true.obs;
  RxList<BranchModel> branches = <BranchModel>[].obs;

  final RxBool isLoadingClients = true.obs;
  final RxBool isLoadingGroups = true.obs;

  get branchValues {
    return BranchModel(
      codeGp: codeGpController.text,
      branchName: nameController.text,
      nit: nitController.text,
      latitude: latitudeController.text.isNotEmpty
          ? double.parse(latitudeController.text)
          : 0.0,
      longitude: longitudeController.text.isNotEmpty
          ? double.parse(longitudeController.text)
          : 0.0,
      clientId: client.value.id,
      classificationId: classification.value.id,
      factoryId: factory.value.id,
      accountBossId: accountBoss.value.id,
      adviserId: adviser.value.id,
      businessAddress: Address(
        country: physicalCountry.value.id.isNotEmpty
            ? SimpleEntity(
                id: physicalCountry.value.id, name: physicalCountry.value.label)
            : null,
        department: physicalDepartment.value.id.isNotEmpty
            ? SimpleEntity(
                id: physicalDepartment.value.id,
                name: physicalDepartment.value.label)
            : null,
        zone: physicalZone.value.id.isNotEmpty
            ? SimpleEntity(
                id: physicalZone.value.id, name: physicalZone.value.label)
            : null,
        address: physicalAddress.text,
      ),
      turns: turns.toList(),
    );
  }

  Future<List<DropDownOption>> fetchClients() async {
    try {
      isLoadingClients.value = true;
      await clientController.fetchClients();
      isLoadingClients.value = false;
      return clientController.clients.map((client) {
        return DropDownOption(
          id: client.id.toString(),
          label: client.name,
        );
      }).toList();
    } catch (e) {
      print("Error fetching clients: $e");
      return [];
    } finally {
      isLoadingClients.value = false;
    }
  }

  Future<List<DropDownOption>> fetchGroups() async {
    try {
      isLoadingGroups.value = true;
      await groupController.fetchGroups();
      return groupController.groups.map((group) {
        return DropDownOption(
          id: group.id.toString(),
          label: group.name,
        );
      }).toList();
    } catch (e) {
      print("Error fetching groups: $e");
      return [];
    } finally {
      isLoadingGroups.value = false;
    }
  }

  Future<bool> deleteBranch(String id) async {
    try {
      final success = await _branchService.delete(id);
      if (success) {
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar la sucursal: $e");
      return false;
    }
  }

  Future<void> fetchBranches() async {
    try {
      isLoading.value = true;

      final data = await _branchService.getAll(null);
      branches.value = data;
    } catch (e) {
      ToastService.error(
        title: "Sucursales",
        subTitle: "Error al cargar sucursales",
      );
      print("Error fetching branches: $e");
      //Get.snackbar("Error", "No se pudieron cargar las sucursales");
    } finally {
      isLoading.value = false;
    }
  }

  // create branch
  Future<bool> createBranch() async {
    try {
      print("objects: branch values ---- ${branchValues}");
      final success = await _branchService.create(branchValues);
      if (success) {
        ToastService.success(
          title: "Sucursal",
          subTitle: "Sucursal creada correctamente",
        );
        return true;
      }
      return false;
    } catch (e) {
      ToastService.error(
        title: "Sucursal",
        subTitle: "Error al crear sucursal: $e",
      );
      return false;
    }
  }

  // update branch
  Future<bool> updateBranch(String id, BranchModel branch) async {
    try {
      final success = await _branchService.update(id, branch);
      if (success) {
        ToastService.success(
          title: "Sucursal",
          subTitle: "Sucursal actualizada correctamente",
        );
        return true;
      }
      return false;
    } catch (e) {
      ToastService.error(
        title: "Sucursal",
        subTitle: "Error al actualizar sucursal: $e",
      );
      return false;
    }
  }

  @override
  void onClose() {
    // clean all controller
    codeGpController.dispose();
    nameController.dispose();
    nitController.dispose();
    socialReasonController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.onClose();
  }

  //shcedule
  // assign days

  final TextEditingController turnName = TextEditingController(text: "");

  final weekDays = <WeekDay>[
    WeekDay(
        id: 1,
        name: "Lunes",
        startTimeController: TextEditingController(text: "00:00"),
        endTimeController: TextEditingController(text: "00:00"),
        isSelected: false.obs),
    WeekDay(
        id: 2,
        name: "Martes",
        startTimeController: TextEditingController(text: "00:00"),
        endTimeController: TextEditingController(text: "00:00"),
        isSelected: false.obs),
    WeekDay(
        id: 3,
        name: "Miércoles",
        startTimeController: TextEditingController(text: "00:00"),
        endTimeController: TextEditingController(text: "00:00"),
        isSelected: false.obs),
    WeekDay(
        id: 4,
        name: "Jueves",
        startTimeController: TextEditingController(text: "00:00"),
        endTimeController: TextEditingController(text: "00:00"),
        isSelected: false.obs),
    WeekDay(
        id: 5,
        name: "Viernes",
        startTimeController: TextEditingController(text: "00:00"),
        endTimeController: TextEditingController(text: "00:00"),
        isSelected: false.obs),
    WeekDay(
        id: 6,
        name: "Sábado",
        startTimeController: TextEditingController(text: "00:00"),
        endTimeController: TextEditingController(text: "00:00"),
        isSelected: false.obs),
    WeekDay(
        id: 7,
        name: "Domingo",
        startTimeController: TextEditingController(text: "00:00"),
        endTimeController: TextEditingController(text: "00:00"),
        isSelected: false.obs),
  ].obs;
  final turns = <Turn>[].obs;

  void toggleWeekDay(WeekDay day) {
    day.isSelected.value = !day.isSelected.value;
    if (!day.isSelected.value) {
      day.startTimeController.text = "00:00";
      day.endTimeController.text = "00:00";
    }
  }

  List<DailySchedule> getSelectedDays() {
    return weekDays
        .where((day) => day.isSelected.value == true)
        .map((day) => DailySchedule(
            daysId: day.id,
            initTime: day.startTimeController.text,
            endTime: day.endTimeController.text))
        .toList();
  }

  // add turn
  void addTurn() {
    turns.add(Turn(name: turnName.text, schedule: getSelectedDays()));
    clearTurn();
    ToastService.success(
        title: "Turno agregado", subTitle: "Turno agregado correctamente");
  }

  void clearTurn() {
    turnName.clear();
    for (var day in weekDays) {
      day.isSelected.value = false;
      day.startTimeController.text = "00:00";
      day.endTimeController.text = "00:00";
    }
  }

  void editTurn(int index) {
    if (index < 0 || index >= turns.length) return;
    final turn = turns[index];
    turn.name = turnName.text;
    turn.schedule = getSelectedDays();
    ToastService.success(
        title: "Turno editado", subTitle: "Turno editado correctamente");
    clearTurn();
  }

  void deleteTurn(int index) {
    if (index < 0 || index >= turns.length) return;
    turns.removeAt(index);
    ToastService.success(
        title: "Turno eliminado", subTitle: "Turno eliminado correctamente");
    clearTurn();
  }

  void selectTurn(int index) {
    if (index < 0 || index >= turns.length) return;
    clearTurn();
    final turn = turns[index];
    turnName.text = turn.name;
    for (var schedule in turn.schedule) {
      final day = weekDays.firstWhere((d) => d.id == schedule.daysId);
      day.isSelected.value = true;
      day.startTimeController.text = schedule.initTime;
      day.endTimeController.text = schedule.endTime;
    }
  }
}
