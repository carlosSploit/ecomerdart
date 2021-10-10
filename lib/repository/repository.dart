abstract class Repository<T> {
  Future<List<T>> getlist(Map<String, dynamic> jsonAtri);
  // Future<T> read(Map<String, dynamic> jsonAtri);
}
