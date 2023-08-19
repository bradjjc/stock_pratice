import 'package:flutter/material.dart';
import 'package:stroke/domain/repository/stoke_repository.dart';
import 'package:stroke/presentation/company_listings/company_listings_state.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = CompanyListingsState();
  CompanyListingsState get state => _state;

  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  Future _getCompanyListings({
    bool fetchFromRemote = false,
    String query = '',
  }) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(
      success: (listings) {
        _state = state.copyWith(
          companis: listings,
        );
      },
      error: (e) {
        // TODO : error 처리
        print('리모트 에러: $e');
      },
    );

    _state = state.copyWith(
      isLoading: false,
    );
    notifyListeners();
  }
}