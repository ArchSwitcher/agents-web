// modal 

import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/views/positions/views/manage_position_screen.dart';
import 'package:flutter/material.dart';

void showPositionModal({
  required BuildContext context,
  required PositionModel? position,
  String? title,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return ManagePositionSection(currentS: 3, position: position, isEdit: true, isEnabled: false,);
    },
  );
}