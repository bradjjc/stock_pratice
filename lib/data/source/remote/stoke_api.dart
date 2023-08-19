import 'package:http/http.dart' as http;
import 'package:stroke/data/keys.dart';

class StokeApi {
  final http.Client _client;

  StokeApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    return await _client.get(Uri.parse(
        '$stokeBaseUrl/query?function=LISTING_STATUS&apikey=$apiKey'));
  }
}
