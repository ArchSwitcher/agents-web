import 'package:agents_app/controllers/generic_list_controller.dart';
import 'package:agents_app/models/branch/contact_model.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/branches/services/contact_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  String? code;
  RxList<BranchContactModel> contacts = <BranchContactModel>[].obs;
  Rx<DropDownOption> branch = DropDownOption(id: "", label: "").obs;

  BranchContactService contactsService = BranchContactService();
  final GenericListController genericListController =
      Get.put(GenericListController());

  get contactValues {
    BranchContactModel contact = BranchContactModel(
        id: "",
        name: name.text,
        phone: phone.text,
        branchId: branch.value.id,
        status: 1);
    return contact;
  }

  Future<void> getContacts() async {
    try {
      contacts.value = await contactsService.getAll(null);
      print("objects: contacts ---- ${contacts.length}");
    } catch (e) {
      ToastService.error(
          title: "Error",
          subTitle: "No se pudieron cargar los contactos de sucursal");
      print("Error al cargar contactos: $e");
    }
  }

  Future<void> addContact() async {
    try {
      await contactsService.create(contactValues);

      clear();
      ToastService.success(
          title: "Éxito", subTitle: "Contacto agregado correctamente");
    } catch (e) {
      ToastService.error(
          title: "Error", subTitle: "No se pudo agregar el contacto");
      print("Error al agregar contacto: $e");
    }
  }

  clear() {
    name.clear();
    phone.clear();
    code = null;
    branch.value = DropDownOption(id: "", label: "");
  }
}
