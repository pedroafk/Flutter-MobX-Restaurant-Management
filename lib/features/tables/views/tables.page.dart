import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/features/tables/stores/tables_store.dart';
import 'package:teste_flutter/features/tables/widgets/tables_header.widget.dart';
import 'package:teste_flutter/features/tables/widgets/tables_list.widget.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<TablesStore>(
      create: (_) => TablesStore(),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TablesHeader(),
          Divider(),
          TablesList(),
        ],
      ),
    );
  }
}
