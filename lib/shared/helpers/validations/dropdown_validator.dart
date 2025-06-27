import 'package:agents_app/models/common/dropdown_option_model.dart';

String? notEmptyDropdownOption(DropDownOption? value, String fieldName) {
  print("Validating dropdown option: $fieldName with value: $value");
  if (value == null || value.id.isEmpty) {
    return fieldName;
  }
  return null;
}

