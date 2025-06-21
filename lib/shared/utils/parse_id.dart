String parseId(dynamic value) => value == null ? '' : value.toString().trim();

String parseValue(dynamic value) =>
    value.toString() == "null" ? '' : value.toString().trim();
