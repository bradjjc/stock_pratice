import 'package:hive/hive.dart';
import 'package:stroke/data/source/local/company_listing_entity.dart';

class StokeDao {
  static const companyListing = 'companyListing';

  // 데이터 추가
  Future<void> insertCompanyListing(
      List<CompanyListingEntity> companyListingEntities) async {
    final box = await Hive.openBox<CompanyListingEntity>('stoke.db');
    await box.addAll(companyListingEntities);
  }

  // 클리어
  Future clearCompanyListings() async {
    final box = await Hive.openBox<CompanyListingEntity>('stoke.db');
    box.clear();
  }

  // 검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final box = await Hive.openBox<CompanyListingEntity>('stoke.db');
    final List<CompanyListingEntity> companyListing = box.values.toList();

    return companyListing
        .where((e) =>
            e.name.toLowerCase().contains(query.toLowerCase()) ||
            query.toUpperCase() == e.symbol)
        .toList();
  }
}
