import 'package:csv/csv.dart';
import 'package:stroke/data/csv/csv_passer.dart';
import 'package:stroke/domain/model/company_listing.dart';

class CompanyListingsPasser implements CsvPasser<CompanyListing> {
  @override
  Future<List<CompanyListing>> pass(String csvString) async {
    List<List<dynamic>> csvValues =
        const CsvToListConverter().convert(csvString);
    csvValues.removeAt(0);
    return csvValues
        .map((e) {
          final symbol = e[0] ?? '';
          final name = e[1] ?? '';
          final exchange = e[2] ?? '';
          return CompanyListing(
            symbol: symbol,
            name: name,
            exchange: exchange,
          );
        })
        .where((e) =>
            e.symbol.isNotEmpty && e.name.isNotEmpty && e.exchange.isNotEmpty)
        .toList();
  }
}
