class TableHelper {
  static double getTableHeight(List elements) {
    if (elements.isEmpty) {
      return 0.0;
    }
    if (elements.length == 1) {
      return 0.20;
    }
    if (elements.length > 12) {
      return 0.60;
    }
    return elements.length * 0.09;
  }
}
// This function can be used to calculate the height of a table based on the number of elements.
