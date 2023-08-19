import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:stroke/data/repository/stoke_repository_impl.dart';
import 'package:stroke/data/source/local/company_listing_entity.dart';
import 'package:stroke/data/source/local/stoke_dao.dart';
import 'package:stroke/data/source/remote/stoke_api.dart';
import 'package:stroke/presentation/company_listings/company_listings_view_model.dart';

void main() {
  test('company listings view model 생성시 데이터 확인', () async {
    Hive.init(null);
    Hive.registerAdapter(CompanyListingEntityAdapter());
    final _api = StokeApi();
    final _dao = StokeDao();
    final viewModel = CompanyListingsViewModel(StokeRepositoryImpl(_api, _dao));

    await Future.delayed(const Duration(seconds: 3));

    expect(viewModel.state.companis.isNotEmpty, true);
    // expect(viewModel.state.companis.length, isNot(equals(0)));
  });
}
