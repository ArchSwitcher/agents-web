import 'package:agents_app/shared/helpers/validations/string_length_validator.dart';
import 'package:agents_app/shared/resources/strings.dart';



dynamic phone_validator(String? value) => stringLengthValidator(value, 8, 8)
    ? null
    : '${Strings.numberPhoneNotValid}, dígitos ${value?.length}';
