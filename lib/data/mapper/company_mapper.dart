import 'package:stroke/data/source/local/company_listing_entity.dart';
import 'package:stroke/data/source/remote/dto/company_info_dto.dart';
import 'package:stroke/domain/model/company_info.dart';
import 'package:stroke/domain/model/company_listing.dart';

// dto
extension ToComapnyListing on CompanyListingEntity {
  CompanyListing toCompanyListing() {
    return CompanyListing(
      symbol: symbol,
      name: name,
      exchange: exchange,
    );
  }
}

extension ToComapnyListingEntity on CompanyListing {
  CompanyListingEntity toCompanyListingEntity() {
    return CompanyListingEntity(
      symbol: symbol,
      name: name,
      exchange: exchange,
    );
  }
}

extension ToCompanyInfo on CompanyInfoDto {
  CompanyInfo toCompanyInfo() {
    return CompanyInfo(
      symbol: symbol ?? '',
      description: description ?? '',
      name: name ?? '',
      country: country ?? '',
      industry: industry ?? '',
    );
  }
}
