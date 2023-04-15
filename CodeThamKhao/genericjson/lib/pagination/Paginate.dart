class Paginate<T> {
  int totalPages;
  int pageNumber;
  int pageSize;
  int count;
  List<T> items;

  Paginate(
      {required this.totalPages,
        required this.pageNumber,
        required this.pageSize,
        required this.count,
        required this.items});

  factory Paginate.fromJson(Map<String, dynamic> json, Function fromJsonModel) {
    final items = json['data'].cast<Map<String, dynamic>>();
    return Paginate<T>(
      totalPages: json['totalPages'],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      count: json['count'],
      items: List<T>.from(items.map((itemsJson) => fromJsonModel(itemsJson))),
    );
  }
}