import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/features/tables/stores/tables_store.dart';
import 'package:teste_flutter/features/tables/widgets/create_table_dialog.dart';
import 'package:teste_flutter/features/tables/widgets/customers_counter.widget.dart';
import 'package:teste_flutter/shared/widgets/search_input.widget.dart';
import 'package:teste_flutter/utils/extension_methos/material_extensions_methods.dart';

class TablesHeader extends StatelessWidget {
  const TablesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<TablesStore>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            Text(
              'Mesas',
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(width: 20),
            SearchInput(
              onChanged: (value) => {},
            ),
            const SizedBox(width: 20),
            Observer(
              builder: (_) => CustomersCounter(
                  label: store.tables.length == 1
                      ? '${store.tables.length} mesa'
                      : '${store.tables.length} mesas'),
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              onPressed: () {
                final tablesStore = Provider.of<TablesStore>(context, listen: false);
                showDialog(
                  context: context,
                  builder: (context) => CreateTableDialog(tablesStore: tablesStore),
                );
              },
              tooltip: 'Criar nova mesa',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
