import 'package:get/get.dart';

class PaginationState<T> {
  RxList<T> items = <T>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxInt totalItems = 0.obs;
  RxInt pageSize = 10.obs;

  void clear() {
    items.clear();
    currentPage.value = 1;
    totalPages.value = 1;
    totalItems.value = 0;
  }
}