import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stroke/data/keys.dart';
import 'package:stroke/data/source/remote/dto/company_info_dto.dart';

class StokeApi {
  final http.Client _client;

  StokeApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    return await _client.get(Uri.parse(
        '$stokeBaseUrl/query?function=LISTING_STATUS&apikey=$apiKey'));
  }

  Future<CompanyInfoDto> getCompanyInfo(
      {required String symbol, String apiKey = apiKey}) async {
    final response = await _client.get(Uri.parse(
        '$stokeBaseUrl/query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey'));

    return CompanyInfoDto.fromJson(jsonDecode(response.body));
  }
}
