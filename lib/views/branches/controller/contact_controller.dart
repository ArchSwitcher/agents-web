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
        id: code!,
        name: name.text,
        phone: phone.text,
        branchId: branch.value.id,
        status: 1);
    return contact;
  }

  setContact(BranchContactModel contact) {
    name.text = contact.name;
    phone.text = contact.phone;
    code = contact.id;
    branch.value = DropDownOption(id: contact.branchId, label: contact.branch!.name);
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

  Future<void> updateContact() async {
    try {
     
      await contactsService.update(contactValues.id, contactValues);
      ToastService.success(
          title: "Éxito", subTitle: "Contacto actualizado correctamente");
    } catch (e) {
      ToastService.error(
          title: "Error", subTitle: "No se pudo actualizar el contacto");
      print("Error al actualizar contacto: $e");
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      await contactsService.delete(id);
      ToastService.success(
          title: "Éxito", subTitle: "Contacto eliminado correctamente");
    } catch (e) {
      ToastService.error(
          title: "Error", subTitle: "No se pudo eliminar el contacto");
      print("Error al eliminar contacto: $e");
    }
  }

  clear() {
    name.clear();
    phone.clear();
    code = null;
    branch.value = DropDownOption(id: "", label: "");
  }
}
