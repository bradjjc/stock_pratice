import 'package:flutter_test/flutter_test.dart';
import 'package:stroke/data/csv/company_listings_passer.dart';
import 'package:stroke/data/source/remote/stoke_api.dart';

void main() {
  test('네트워크 통신', () async {
    final response = await StokeApi().getListings();
    final _passer = CompanyListingsPasser();
    final remoteListings = await _passer.pass(response.body);

    expect(remoteListings[0].symbol, 'A');
    // expect(remoteListings[0].name, 'A');
    expect(remoteListings[0].exchange, 'NYSE');
  });
}
