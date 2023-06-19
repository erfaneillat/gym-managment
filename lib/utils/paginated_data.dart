class PaginatedData<T> {
  final T data;
  final int page;
  final int pageSize;
  PaginatedData({required this.data, required this.page, this.pageSize = 15});
}
