import 'package:flutter/material.dart';

String? endTimeValidator(String? value, String? endTime) {
  if (value == null || value.isEmpty) return 'Hora obligatoria';
  if (endTime == null || endTime.isEmpty) return 'Hora de fin obligatoria';

  final inicio = TimeOfDay(
    hour: int.parse(value.split(':')[0]),
    minute: int.parse(value.split(':')[1]),
  );

  final fin = TimeOfDay(
    hour: int.parse(endTime.split(':')[0]),
    minute: int.parse(endTime.split(':')[1]),
  );

  final inicioMinutes = inicio.hour * 60 + inicio.minute;
  final finMinutes = fin.hour * 60 + fin.minute;

  if (finMinutes <= inicioMinutes) {
    return 'La hora de fin debe ser mayor a la de inicio';
  }

  return null;
}
