import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../stores/tables_store.dart';
import 'table_card.widget.dart';

class TablesList extends StatelessWidget {
  const TablesList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<TablesStore>(context);
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Observer(
            builder: (_) => Wrap(
              spacing: 10,
              runSpacing: 10,
              children: store.tables
                  .map(
                    (e) => TableCard(tableNumber: e),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
