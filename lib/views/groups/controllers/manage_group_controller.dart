import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/models/group/groups_model.dart';
import 'package:agents_app/views/groups/services/group_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ManageGroupController extends GetxController {
  final nameController = TextEditingController();
  String? id;
  RxList<GroupsModel> groups = <GroupsModel>[].obs;
  RxBool isLoading = true.obs;


  Future<void> fetchGroups() async {
    try {
      final data = await GroupService.fetchGroups();
      groups.value = data;
      
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  List<DropDownOption> get dropdownOptions {
    return groups.map((group) {
      return DropDownOption(
        id: group.id.toString(),
        label: group.name,
      );
    }).toList();
  }

  Future<void> createGroup(BuildContext context) async {
    final groupCreated = await GroupService.newGroup(name);
    if (groupCreated) {
      await fetchGroups();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> editGroup(BuildContext context) async {
    final group = await GroupService.updateGroup(id.toString(), name);
    if (group) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      await fetchGroups();
    }
  }

  Future<void> delete(BuildContext context) async {
    final group = await GroupService.deleteGroup(id.toString());
    if (group) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      await fetchGroups();
    }
  }

  void setData({required String value, required String? id}) {
    print("value ============ $value");
    nameController.text = value;
    this.id = id;
  }

  void clear() {
    nameController.clear();
  }

  String get name => nameController.text;

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
