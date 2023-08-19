abstract class CsvPasser<T> {
  Future<List<T>> pass(String csvString);
}
