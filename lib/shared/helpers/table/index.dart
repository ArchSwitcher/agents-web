class TableHelper {
  static double getTableHeight(List elements) =>
      elements.length > 20 ? 0.60 : elements.length * 0.07;
}
// This function can be used to calculate the height of a table based on the number of elements.