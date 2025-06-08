import 'package:flutter/material.dart';

class SidebarStateProvider with ChangeNotifier {
  String? _expandedGroup;

  String? get expandedGroup => _expandedGroup;

  void setExpandedGroup(String? group) {
    _expandedGroup = group;
    notifyListeners();
  }
}