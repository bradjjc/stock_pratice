import 'package:stroke/domain/model/company_info.dart';
import 'package:stroke/domain/model/company_listing.dart';
import 'package:stroke/util/result.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListing>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );

  Future<Result<CompanyInfo>> getCompanyInfo(
    String symbol,
  );
}
