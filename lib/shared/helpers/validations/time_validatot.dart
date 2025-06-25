// write a validator for time 00:00 to 23:59 should be return null if valid or error message string if invalid

String? validateTime(String? value) {
  if (value == null || value.isEmpty) {
    return 'Time cannot be empty';
  }

  final timePattern = RegExp(r'^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$');
  if (!timePattern.hasMatch(value)) {
    return '00:00 A 23:59';
  }

  return null; // Return null if the time is valid
}