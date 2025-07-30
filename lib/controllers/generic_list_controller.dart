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
  final RxBool isLoadingLicense = true.obs;
  final RxBool isLoadingEmployeeType = true.obs;
  final RxBool isLoadingJobFrequency = true.obs;
  final RxBool isLoadingHrProfile = true.obs;
  final RxBool isLoadingPaymentType = true.obs;
  final RxBool isLoadingBloodType = true.obs;
  final RxBool isLoadingMaritalStatus = true.obs;
  final RxBool isLoadingRelationShip = true.obs;
  final RxBool isLoadingWorkerStatus = true.obs;
  final RxBool isLoadingBank = true.obs;
  final RxBool isLoadingIdentificationType = true.obs;
  final RxBool isLoadingOperationalProfile = true.obs;
  final RxBool isLoadingRegion = true.obs;
  final RxBool isLoadingEducation = true.obs;
  final RxBool isLoadingEmployeeClassification = true.obs;
  final RxBool isLoadingProfessions = true.obs;

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

  final RxList<DropDownOption> license = <DropDownOption>[].obs;
  final RxList<DropDownOption> employeeType = <DropDownOption>[].obs;
  final RxList<DropDownOption> jobFrequency = <DropDownOption>[].obs;
  final RxList<DropDownOption> hrProfile = <DropDownOption>[].obs;
  final RxList<DropDownOption> paymentType = <DropDownOption>[].obs;
  final RxList<DropDownOption> bloodType = <DropDownOption>[].obs;
  final RxList<DropDownOption> maritalStatus = <DropDownOption>[].obs;
  final RxList<DropDownOption> relationShip = <DropDownOption>[].obs;
  final RxList<DropDownOption> workerStatus = <DropDownOption>[].obs;
  final RxList<DropDownOption> bank = <DropDownOption>[].obs;
  final RxList<DropDownOption> identificationType = <DropDownOption>[].obs;
  final RxList<DropDownOption> operationalProfile = <DropDownOption>[].obs;
  final RxList<DropDownOption> region = <DropDownOption>[].obs;
  final RxList<DropDownOption> education = <DropDownOption>[].obs;
  final RxList<DropDownOption> employeeClassifications = <DropDownOption>[].obs;
  final RxList<DropDownOption> professions = <DropDownOption>[].obs;

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
      print("fetchTurnsByBranch Fetching turns for branch: $branchId");
      isLoadingTurns.value = true;
      final data = await genericListService.getAll(
          "common/listTurnBranchId/$branchId",
          (json) => TurnModel.fromJson(json));
      turns.value = data;
      return data;
    } catch (e) {
      print("fetchTurnsByBranch Error fetching assign days: $e");
      return [];
    } finally {
      isLoadingTurns.value = false;
    }
  }

  Future<List<DropDownOption>> fetchLicense() async {
    isLoadingLicense.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getLicense", (json) => GenericListModel.fromJson(json));
      license.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return license;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingLicense.value = false;
    }
  }

  Future<List<DropDownOption>> fetchEmployeeType() async {
    isLoadingEmployeeType.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getEmployeeType", (json) => GenericListModel.fromJson(json));
      employeeType.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return employeeType;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingEmployeeType.value = false;
    }
  }

  Future<List<DropDownOption>> fetchJobFrequency() async {
    isLoadingJobFrequency.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getJobFrequency", (json) => GenericListModel.fromJson(json));
      jobFrequency.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return jobFrequency;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingJobFrequency.value = false;
    }
  }

  Future<List<DropDownOption>> fetchHrProfile() async {
    isLoadingHrProfile.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getHrProfile", (json) => GenericListModel.fromJson(json));
      hrProfile.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return hrProfile;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingHrProfile.value = false;
    }
  }

  Future<List<DropDownOption>> fetchPaymentType() async {
    isLoadingPaymentType.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getPaymentType", (json) => GenericListModel.fromJson(json));
      paymentType.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return paymentType;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingPaymentType.value = false;
    }
  }

  Future<List<DropDownOption>> fetchBloodType() async {
    isLoadingBloodType.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getBloodType", (json) => GenericListModel.fromJson(json));
      bloodType.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return bloodType;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingBloodType.value = false;
    }
  }

  Future<List<DropDownOption>> fetchMaritalStatus() async {
    isLoadingMaritalStatus.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getMaritalStatus", (json) => GenericListModel.fromJson(json));
      maritalStatus.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return maritalStatus;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingMaritalStatus.value = false;
    }
  }

  Future<List<DropDownOption>> fetchRelationShip() async {
    isLoadingRelationShip.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getRelationShip", (json) => GenericListModel.fromJson(json));
      relationShip.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return relationShip;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingRelationShip.value = false;
    }
  }

  Future<List<DropDownOption>> fetchWorkerStatus() async {
    isLoadingWorkerStatus.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getWorkerStatus", (json) => GenericListModel.fromJson(json));
      workerStatus.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return workerStatus;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingWorkerStatus.value = false;
    }
  }

  Future<List<DropDownOption>> fetchBank() async {
    isLoadingBank.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getBank", (json) => GenericListModel.fromJson(json));
      bank.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return bank;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingBank.value = false;
    }
  }

  Future<List<DropDownOption>> fetchIdentificationType() async {
    isLoadingIdentificationType.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getIdentificationType",
          (json) => GenericListModel.fromJson(json));
      identificationType.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return identificationType;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingIdentificationType.value = false;
    }
  }

  Future<List<DropDownOption>> fetchOperationalProfile() async {
    isLoadingOperationalProfile.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getOperationalProfile",
          (json) => GenericListModel.fromJson(json));
      operationalProfile.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return operationalProfile;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingOperationalProfile.value = false;
    }
  }

  Future<List<DropDownOption>> fetchRegion() async {
    isLoadingRegion.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getRegion", (json) => GenericListModel.fromJson(json));
      region.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return region;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingRegion.value = false;
    }
  }

  Future<List<DropDownOption>> fetchEductionLevel() async {
    isLoadingEducation.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getEducation", (json) => GenericListModel.fromJson(json));
      education.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return region;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingEducation.value = false;
    }
  }

  Future<List<DropDownOption>> fetchEmployeeClassifications() async {
    isLoadingEmployeeClassification.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getEmployeeClassification", (json) => GenericListModel.fromJson(json));
      employeeClassifications.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return region;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingEmployeeClassification.value = false;
    }
  }

  Future<List<DropDownOption>> fetchProfessions() async {
    isLoadingProfessions.value = true;
    try {
      final data = await genericListService.getAll(
          "common/getProfession", (json) => GenericListModel.fromJson(json));
      professions.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return region;
    } catch (e) {
      print("Error fetching license: $e");
      return [];
    } finally {
      isLoadingProfessions.value = false;
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

  void setLoadings(bool value) {
    isLoadingEmployees.value = value;
    isLoadingClassification.value = value;
    isLoadingCity.value = value;
    isLoadingCountry.value = value;
    isLoadingZone.value = value;
    isLoadingBilling.value = value;
    isLoadingGeneration.value = value;
    isLoadingFactory.value = value;
    isLoadingAgency.value = value;
    isLoadingCompany.value = value;
    isLoadingServiceType.value = value;
    isLoadingShiftTime.value = value;
    isLoadingTransport.value = value;
    isLoadingClientsByGroup.value = value;
    isLoadingBranchByClient.value = value;
    isLoadingEquipmentType.value = value;
    isLoadingStatusType.value = value;
    isLoadingMunicipality.value = value;
    isLoadingBranchesDd.value = value;
    isLoadingTurns.value = value;
    isLoadingLicense.value = value;
    isLoadingEmployeeType.value = value;
    isLoadingJobFrequency.value = value;
    isLoadingHrProfile.value = value;
    isLoadingPaymentType.value = value;
    isLoadingBloodType.value = value;
    isLoadingMaritalStatus.value = value;
    isLoadingRelationShip.value = value;
    isLoadingWorkerStatus.value = value;
    isLoadingBank.value = value;
    isLoadingIdentificationType.value = value;
    isLoadingOperationalProfile.value = value;
    isLoadingRegion.value = value;
    isLoadingEducation.value = value;
    isLoadingEmployeeClassification.value = value;
    isLoadingProfessions.value = value;
  }
}
