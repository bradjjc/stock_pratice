import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'company_listings_action.freezed.dart';

@freezed
sealed class CompanyListingsAction with _$CompanyListingsAction {
  const factory CompanyListingsAction.refresh() = Refresh;
  const factory CompanyListingsAction.onSearchQueryChange(String query) =
      OnSearchQueryChange;
}
