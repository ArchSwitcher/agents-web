import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/common/generic_list_model.dart';
import 'package:agents_app/services/generic_list_service.dart';
import 'package:get/get.dart';

class GenericListController extends GetxController {
  final GenericListService genericListService = Get.put(GenericListService());

  final RxBool isLoadingEmployees = true.obs;
  final RxBool isLoadingClassification = true.obs;
  final RxBool isLoadingCity = true.obs;
  final RxBool isLoadingCountry = true.obs;
  final RxBool isLoadingZone = true.obs;
  final RxBool isLoadingBilling = true.obs;
  final RxBool isLoadingGeneration = true.obs;
  final RxBool isLoadingFactory = true.obs;
  final RxBool isLoadingAgency = true.obs;
  final RxBool isLoadingCompany = true.obs;
  final RxBool isLoadingServiceType = true.obs;
  final RxBool isLoadingShiftTime = true.obs;
  final RxBool isLoadingTransport = true.obs;
  final RxBool isLoadingClientsByGroup = true.obs;
  final RxBool isLoadingBranchByClient = true.obs;
  final RxBool isLoadingEquipmentType = true.obs;
  final RxBool isLoadingStatusType = true.obs;
  final RxBool isLoadingMunicipality = true.obs;
  final RxBool isLoadingBranchesDd = true.obs;
  final RxBool isLoadingTurns = true.obs;

  final RxList<DropDownOption> employees = <DropDownOption>[].obs;
  final RxList<DropDownOption> classification = <DropDownOption>[].obs;
  final RxList<DropDownOption> cities = <DropDownOption>[].obs;
  final RxList<DropDownOption> countries = <DropDownOption>[].obs;
  final RxList<DropDownOption> zones = <DropDownOption>[].obs;
  final RxList<DropDownOption> billingTypes = <DropDownOption>[].obs;
  final RxList<DropDownOption> generationTypes = <DropDownOption>[].obs;
  final RxList<DropDownOption> factories = <DropDownOption>[].obs;
  final RxList<DropDownOption> departments = <DropDownOption>[].obs;
  final RxList<DropDownOption> agencies = <DropDownOption>[].obs;
  final RxList<DropDownOption> companies = <DropDownOption>[].obs;
  final RxList<DropDownOption> serviceTypes = <DropDownOption>[].obs;
  final RxList<DropDownOption> shiftTimes = <DropDownOption>[].obs;
  final RxList<DropDownOption> transports = <DropDownOption>[].obs;
  final RxList<DropDownOption> clientsByGroup = <DropDownOption>[].obs;
  final RxList<DropDownOption> branchesByClient = <DropDownOption>[].obs;
  final RxList<DropDownOption> equipmentTypes = <DropDownOption>[].obs;
  final RxList<DropDownOption> statusTypes = <DropDownOption>[].obs;
  final RxList<DropDownOption> municipalities = <DropDownOption>[].obs;
  final RxList<DropDownOption> branchesDd = <DropDownOption>[].obs;
  final RxList<TurnModel> turns = <TurnModel>[].obs;

  Future<List<DropDownOption>> fetchClassification() async {
    try {
      isLoadingClassification.value = true;
      final data = await genericListService.getAll(
          "common/getAllClassification",
          (json) => GenericListModel.fromJson(json));
      classification.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return classification;
    } catch (e) {
      print("Error fetching classification: $e");
      return [];
    } finally {
      isLoadingClassification.value = false;
    }
  }

  Future<List<DropDownOption>> fetchBillingTypes() async {
    try {
      isLoadingBilling.value = true;
      final data = await genericListService.getAll("common/getAllBillingType",
          (json) => GenericListModel.fromJson(json));
      billingTypes.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return billingTypes;
    } catch (e) {
      print("Error fetching billing types: $e");
      return [];
    } finally {
      isLoadingBilling.value = false;
    }
  }

  Future<List<DropDownOption>> fetchGenerationTypes() async {
    try {
      isLoadingGeneration.value = true;
      final data = await genericListService.getAll(
          "common/getAllGenerationType",
          (json) => GenericListModel.fromJson(json));
      generationTypes.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return generationTypes;
    } catch (e) {
      print("Error fetching generation types: $e");
      return [];
    } finally {
      isLoadingGeneration.value = false;
    }
  }

  // Fetch countries
  Future<List<DropDownOption>> fetchCountries() async {
    try {
      isLoadingCountry.value = true;
      final data = await genericListService.getAll(
          "common/getCountries", (json) => GenericListModel.fromJson(json));
      countries.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return countries;
    } catch (e) {
      print("Error fetching countries: $e");
      return [];
    } finally {
      isLoadingCountry.value = false;
    }
  }

  Future<List<DropDownOption>> fetchDepartments() async {
    try {
      isLoadingCity.value = true;
      final data = await genericListService.getAll(
          "common/getDepartments", (json) => GenericListModel.fromJson(json));
      departments.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return departments;
    } catch (e) {
      print("Error fetching departments: $e");
      return [];
    } finally {
      isLoadingCity.value = false;
    }
  }

  Future<List<DropDownOption>> fetchMunicipalities(String departmentId) async {
    try {
      isLoadingMunicipality.value = true;
      final data = await genericListService.getAll(
          "common/getMunicipalitiesByDepartment/$departmentId",
          (json) => GenericListModel.fromJson(json));
      municipalities.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return municipalities;
    } catch (e) {
      print("Error fetching municipalities: $e");
      return [];
    } finally {
      isLoadingMunicipality.value = false;
    }
  }

  Future<List<DropDownOption>> fetchMunicipalitiesOnly(
      String departmentId) async {
    try {
      final data = await genericListService.getAll(
          "common/getMunicipalitiesByDepartment/$departmentId",
          (json) => GenericListModel.fromJson(json));
      final munis = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return munis;
    } catch (e) {
      return [];
    }
  }

  Future<List<DropDownOption>> fetchFactories() async {
    try {
      isLoadingFactory.value = true;
      final data = await genericListService.getAll(
          "common/getAllFactories", (json) => GenericListModel.fromJson(json));
      factories.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return factories;
    } catch (e) {
      print("Error fetching factories: $e");
      return [];
    } finally {
      isLoadingFactory.value = false;
    }
  }

  Future<List<DropDownOption>> fetchZones() async {
    try {
      isLoadingZone.value = true;
      final data = await genericListService.getAll(
          "common/getAllZones", (json) => GenericListModel.fromJson(json));
      zones.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return zones;
    } catch (e) {
      print("Error fetching zones: $e");
      return [];
    } finally {
      isLoadingZone.value = false;
    }
  }

  Future<List<DropDownOption>> getAllAgency() async {
    try {
      isLoadingAgency.value = true;
      final data = await genericListService.getAll(
          "common/getAllAgency", (json) => GenericListModel.fromJson(json));
      agencies.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return agencies;
    } catch (e) {
      print("Error fetching agencies: $e");
      return [];
    } finally {
      isLoadingAgency.value = false;
    }
  }

  Future<List<DropDownOption>> getAllCompany() async {
    try {
      isLoadingCompany.value = true;
      final data = await genericListService.getAll(
          "common/getAllCompany", (json) => GenericListModel.fromJson(json));

      companies.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return companies;
    } catch (e) {
      print("Error fetching companies: $e");
      return [];
    } finally {
      isLoadingCompany.value = false;
    }
  }

  Future<List<DropDownOption>> getAllServiceType() async {
    try {
      isLoadingServiceType.value = true;
      final data = await genericListService.getAll("common/getAllServiceType",
          (json) => GenericListModel.fromJson(json));
      serviceTypes.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return serviceTypes;
    } catch (e) {
      print("Error fetching service types: $e");
      return [];
    } finally {
      isLoadingServiceType.value = false;
    }
  }

  Future<List<DropDownOption>> getAllShiftTime() async {
    try {
      isLoadingShiftTime.value = true;
      final data = await genericListService.getAll(
          "common/getAllShiftTime", (json) => GenericListModel.fromJson(json));
      shiftTimes.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return shiftTimes;
    } catch (e) {
      print("Error fetching shift times: $e");
      return [];
    } finally {
      isLoadingShiftTime.value = false;
    }
  }

  Future<List<DropDownOption>> getAllTransport() async {
    try {
      isLoadingTransport.value = true;
      final data = await genericListService.getAll(
          "common/getAllTransport", (json) => GenericListModel.fromJson(json));
      transports.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return transports;
    } catch (e) {
      print("Error fetching transports: $e");
      return [];
    } finally {
      isLoadingTransport.value = false;
    }
  }

  Future<List<DropDownOption>> fetchClientsByGroupId(String groupId) async {
    try {
      isLoadingClientsByGroup.value = true;
      final data = await genericListService.getAll(
          "client/getClientsByGroup/$groupId",
          (json) => GenericListModel.fromJson(json));

      clientsByGroup.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return clientsByGroup;
    } catch (e) {
      print("Error fetching clients branches: $e");
      return [];
    } finally {
      isLoadingClientsByGroup.value = false;
    }
  }

  Future<List<DropDownOption>> fetchBranchByClientId(String clientId) async {
    try {
      isLoadingBranchByClient.value = true;
      final data = await genericListService.getAll(
          "branch/branchByClient/$clientId",
          (json) => GenericListModel.fromJson(json));

      branchesByClient.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return branchesByClient;
    } catch (e) {
      print("Error fetching clients branches: $e");
      return [];
    } finally {
      isLoadingBranchByClient.value = false;
    }
  }

  Future<List<DropDownOption>> getAllEquipmentType() async {
    try {
      isLoadingEquipmentType.value = true;
      final data = await genericListService.getAll(
          "common/equipmentType", (json) => GenericListModel.fromJson(json));
      equipmentTypes.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return equipmentTypes;
    } catch (e) {
      print("Error fetching equipment types: $e");
      return [];
    } finally {
      isLoadingEquipmentType.value = false;
    }
  }

  Future<List<DropDownOption>> getAllStatusType() async {
    try {
      isLoadingStatusType.value = true;
      final data = await genericListService.getAll(
          "common/getAllStatusType", (json) => GenericListModel.fromJson(json));
      statusTypes.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return statusTypes;
    } catch (e) {
      print("Error fetching status types: $e");
      return [];
    } finally {
      isLoadingStatusType.value = false;
    }
  }

  Future<List<DropDownOption>> getAllBranchesDd() async {
    try {
      isLoadingBranchesDd.value = true;
      final data = await genericListService.getAll(
          "branch/only", (json) => GenericListModel.fromJson(json));
      branchesDd.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return branchesDd;
    } catch (e) {
      print("Error fetching branches: $e");
      return [];
    } finally {
      isLoadingBranchesDd.value = false;
    }
  }

  Future<List<TurnModel>> fetchTurnsByBranch(String branchId) async {
    try {
      isLoadingTurns.value = true;
      final data = await genericListService.getAll(
          "common/listTurnBranchId/$branchId",
          (json) => TurnModel.fromJson(json));
      turns.value = data;
      return data;
    } catch (e) {
      print("Error fetching assign days: $e");
      return [];
    } finally {
      isLoadingTurns.value = false;
    }
  }

  //clean clientsByGroup
  void cleanClientsByGroup() {
    clientsByGroup.value = [];
  }

  //clean branchesByClient
  void cleanBranchesByClient() {
    branchesByClient.value = [];
  }

  void cleanMunicipalities() {
    municipalities.value = [];
  }
}
