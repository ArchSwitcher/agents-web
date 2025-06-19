import 'package:agents_app/models/common/dropdown_option_model.dart';
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

  final RxList<DropDownOption> employees = <DropDownOption>[].obs;
  final RxList<DropDownOption> classification = <DropDownOption>[].obs;
  final RxList<DropDownOption> cities = <DropDownOption>[].obs;
  final RxList<DropDownOption> countries = <DropDownOption>[].obs;
  final RxList<DropDownOption> zones = <DropDownOption>[].obs;
  final RxList<DropDownOption> billingTypes = <DropDownOption>[].obs;
  final RxList<DropDownOption> generationTypes = <DropDownOption>[].obs;
  final RxList<DropDownOption> factories = <DropDownOption>[].obs;
  final RxList<DropDownOption> departments = <DropDownOption>[].obs;

  Future<List<DropDownOption>> fetchClassification() async {
    try {
      isLoadingClassification.value = true;
      final data =
          await genericListService.getAll("common/getAllClassification");
      employees.value = data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
      return employees;
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
      final data = await genericListService.getAll("common/getAllBillingType");
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
      final data =
          await genericListService.getAll("common/getAllGenerationType");
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
      final data = await genericListService.getAll("common/getCountries");
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
      final data = await genericListService.getAll("common/getDepartments");
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

  Future<List<DropDownOption>> fetchFactories() async {
    try {
      isLoadingFactory.value = true;
      final data = await genericListService.getAll("common/getAllFactories");
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
      final data = await genericListService.getAll("common/getAllZones");
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
}
