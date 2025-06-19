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

  
  Future<List<DropDownOption>> fetchClassification() async {
    try {
      isLoadingClassification.value = true;
      final data =
          await genericListService.getAll("common/getAllClassification");
      return data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
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
      return data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
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
      return data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
    } catch (e) {
      print("Error fetching generation types: $e");
      return [];
    } finally {
      isLoadingGeneration.value = false;
    }
  }

  Future<List<DropDownOption>> fetchDepartments() async {
    try {
      isLoadingCity.value = true;
      final data = await genericListService.getAll("common/getDepartments");
      return data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
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
      return data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
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
      return data.map((item) {
        return DropDownOption(
          id: item.id.toString(),
          label: item.name,
        );
      }).toList();
    } catch (e) {
      print("Error fetching zones: $e");
      return [];
    } finally {
      isLoadingZone.value = false;
    }
  }
}
