import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/features/tables/entities/table.entity.dart';
import 'package:teste_flutter/features/tables/stores/tables_store.dart';
import 'package:teste_flutter/features/tables/widgets/customers_counter.widget.dart';
import 'package:teste_flutter/features/tables/widgets/edit_table_dialog.dart';
import 'package:teste_flutter/utils/extension_methos/material_extensions_methods.dart';

const double _innerPadding = 1.0;
const double _topPadding = 5.0;

class TableCard extends StatelessWidget {
  const TableCard({
    super.key,
    required this.table,
  });

  final TableEntity table;

  @override
  Widget build(BuildContext context) {
    final tablesStore = Provider.of<TablesStore>(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(_innerPadding, _topPadding, _innerPadding, _innerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.appColors.lightGreen,
      ),
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(('Mesa ${table.id + 1}').toUpperCase(),
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: context.appColors.green, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: _innerPadding),
          Card(
            elevation: 1,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () async {
                final updatedTable = await showDialog(
                  context: context,
                  builder: (context) => EditTableDialog(tableEntity: table),
                );

                if (updatedTable != null) {
                  tablesStore.updateTable(updatedTable);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  CustomersCounter(
                    label: table.customers.length <= 1
                        ? 'Total de ${table.customers.length} cliente'
                        : 'Total de ${table.customers.length} clientes',
                    iconWidth: 16,
                    color: context.appColors.darkGrey,
                    textStyle:
                        context.textTheme.bodySmall?.copyWith(color: context.appColors.darkGrey),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
