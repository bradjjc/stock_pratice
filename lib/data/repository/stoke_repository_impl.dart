import 'package:stroke/data/csv/company_listings_passer.dart';
import 'package:stroke/data/mapper/company_mapper.dart';
import 'package:stroke/data/source/local/stoke_dao.dart';
import 'package:stroke/data/source/remote/stoke_api.dart';
import 'package:stroke/domain/model/company_info.dart';
import 'package:stroke/domain/model/company_listing.dart';
import 'package:stroke/domain/repository/stoke_repository.dart';
import 'package:stroke/util/result.dart';

class StokeRepositoryImpl implements StockRepository {
  final StokeApi _api;
  final StokeDao _dao;
  final _passer = CompanyListingsPasser();

  StokeRepositoryImpl(this._api, this._dao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(
      bool fetchFromRemote, String query) async {
    // 캐시에서 찾는다
    final localListings = await _dao.searchCompanyListing(query);

    // 없다면 리모트에서
    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // 캐시
    if (shouldJustLoadFromCache) {
      return Result.success(
          localListings.map((e) => e.toCompanyListing()).toList());
    }

    // 리모트
    try {
      final response = await _api.getListings();
      final remoteListings = await _passer.pass(response.body);

      // 캐싱 비우고
      await _dao.clearCompanyListings();

      // 캐싱 추가
      await _dao.insertCompanyListing(
          remoteListings.map((e) => e.toCompanyListingEntity()).toList());

      return Result.success(remoteListings);
    } catch (e) {
      return Result.error(Exception('데이터 로드 실패'));
    }
  }

  @override
  Future<Result<CompanyInfo>> getCompanyInfo(String symbol) async {
    try {
      final dto = await _api.getCompanyInfo(symbol: symbol);
      return Result.success(dto.toCompanyInfo());
    } catch (e) {
      return Result.error(Exception('회사정보 로드 실패: $e'));
    }
  }
}
