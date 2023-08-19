import 'package:stroke/domain/model/company_listing.dart';
import 'package:stroke/util/result.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListing>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );
}
