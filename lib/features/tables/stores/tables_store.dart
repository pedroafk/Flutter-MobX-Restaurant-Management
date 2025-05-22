import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:teste_flutter/features/customers/entities/customer.entity.dart';
import 'package:teste_flutter/features/tables/entities/table.entity.dart';

part 'tables_store.g.dart';

// ignore: library_private_types_in_public_api
class TablesStore = _TablesStoreBase with _$TablesStore;

abstract class _TablesStoreBase with Store {
  @observable
  ObservableList<TableEntity> tables = ObservableList<TableEntity>();

  @action
  void addTable(String name, String phone) {
    final random = Random();
    final customerId = 1000 + random.nextInt(9000);
    tables.add(
      TableEntity(
        id: tables.length,
        identification: name,
        customers: [
          CustomerEntity(
            id: customerId,
            name: name,
            phone: phone,
          ),
        ],
      ),
    );
  }

  @action
  void updateTable(TableEntity updatedTable) {
    final index = tables.indexWhere((t) => t.id == updatedTable.id);
    if (index != -1) {
      tables[index] = updatedTable;
    }
  }
}
