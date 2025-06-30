import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/branch/business_model.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/branches/services/business_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BusinessController extends GetxController {
  String id = "";
  TextEditingController code = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController businessActivity = TextEditingController();
  TextEditingController location = TextEditingController(); //address
  TextEditingController emailGFace = TextEditingController();
  TextEditingController countCXC = TextEditingController();
  TextEditingController taxAmount = TextEditingController();

  RxList<BranchBusinessModel> business = <BranchBusinessModel>[].obs;
  Rx<DropDownOption> branch = DropDownOption(id: "", label: "").obs;
  LoaderController loader = Get.put(LoaderController());

  BranchBusinessService BusinessService = BranchBusinessService();

  final GenericListController genericListController =
      Get.put(GenericListController());

  get businessValues {
    BranchBusinessModel business = BranchBusinessModel(
        id: id,
        code: code.text,
        businessName: businessName.text,
        businessActivity: businessActivity.text,
        location: location.text,
        emailGFace: emailGFace.text,
        status: "1",
        countCXC: countCXC.text,
        taxAmount: taxAmount.text,
        branchId: branch.value.id);
    return business;
  }

  setBusiness(BranchBusinessModel business) {
    id = business.id;
    code.text = business.code;
    businessName.text = business.businessName;
    businessActivity.text = business.businessActivity;
    location.text = business.location;
    emailGFace.text = business.emailGFace;
    countCXC.text = business.countCXC;
    taxAmount.text = business.taxAmount;
    branch.value = DropDownOption(id: business.branchId, label: business.branch!.name);
  }

  Future<void> getBusinesses() async {
    try {
      loader.show();
      business.value = await BusinessService.getAll(null);
      print("objects: business ---- ${business[0].toJson()}");
    } catch (e) {
      ToastService.error(
          title: "Error",
          subTitle: "No se pudieron cargar los contactos de sucursal");
      print("Error al cargar contactos: $e");
    } finally {
      loader.hide();
    }
  }

  Future<void> addBusiness() async {
    try {
      await BusinessService.create(businessValues);

      clear();
      ToastService.success(
          title: "Éxito", subTitle: "Negocio agregado correctamente");
    } catch (e) {
      ToastService.error(
          title: "Error", subTitle: "No se pudo agregar el negocio");
      print("Error al agregar negocio: $e");
    }
  }

  Future<void> updateBusiness() async {
    try {
      await BusinessService.update(businessValues.id, businessValues);
      ToastService.success(
          title: "Éxito", subTitle: "Negocio actualizado correctamente");
    } catch (e) {
      ToastService.error(
          title: "Error", subTitle: "No se pudo actualizar el negocio");
      print("Error al actualizar negocio: $e");
    }
  }

  Future<void> deleteBusiness(String id) async {
    try {
      await BusinessService.delete(id);
      ToastService.success(
          title: "Éxito", subTitle: "Negocio eliminado correctamente");
    } catch (e) {
      ToastService.error(
          title: "Error", subTitle: "No se pudo eliminar el negocio");
      print("Error al eliminar negocio: $e");
    }
  }

  clear() {
    id = "";
    code.clear();
    businessName.clear();
    businessActivity.clear();
    location.clear();
    emailGFace.clear();
    countCXC.clear();
    taxAmount.clear();
    branch.value = DropDownOption(id: "", label: "");
  }
}
