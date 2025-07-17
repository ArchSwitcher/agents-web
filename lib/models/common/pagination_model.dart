class PaginationModel<T> {
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;
  final List<T> items;

  PaginationModel({
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    this.items = const [],
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'] as int,
      pageSize: json['limit'] as int,
      totalItems: json['total'] as int,
      totalPages: json['totalPages'] as int,
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => item as T)
          .toList() ?? [],
    );
  }

}
