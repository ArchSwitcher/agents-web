class TableHelper {
  static double getTableHeight(List elements) {
    print("objects: ${elements.length}");
      if (elements.isEmpty) {
        return 0.0;
      }
      if (elements.length == 1) {
        return 0.20;
      }
        return elements.length * 0.09;
      }
}
// This function can be used to calculate the height of a table based on the number of elements.