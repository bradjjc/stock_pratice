import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stroke/presentation/company_listings/company_listings_action.dart';
import 'package:stroke/presentation/company_listings/company_listings_view_model.dart';

class CompanyListingsScreen extends StatelessWidget {
  const CompanyListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CompanyListingsViewModel>();
    final state = viewModel.state;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (query) {
                  viewModel.onAction(
                    CompanyListingsAction.onSearchQueryChange(query),
                  );
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  label: Text('검색..'),
                  // labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  viewModel.onAction(
                    const CompanyListingsAction.refresh(),
                  );
                },
                child: ListView.builder(
                  itemCount: state.companis.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(state.companis[index].name),
                        ),
                        Divider(color: Theme.of(context).colorScheme.secondary),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
