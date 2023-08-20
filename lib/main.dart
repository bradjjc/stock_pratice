import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke/data/repository/stoke_repository_impl.dart';
import 'package:stroke/data/source/local/company_listing_entity.dart';
import 'package:stroke/data/source/local/stoke_dao.dart';
import 'package:stroke/data/source/remote/stoke_api.dart';
import 'package:stroke/util/color_schemes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'presentation/company_listings/company_listings_screen.dart';
import 'presentation/company_listings/company_listings_view_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyListingEntityAdapter());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CompanyListingsViewModel(
            StokeRepositoryImpl(
              StokeApi(),
              StokeDao(),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 46S8W62CBGLOJG7J
      // title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const CompanyListingsScreen(),
    );
  }
}
