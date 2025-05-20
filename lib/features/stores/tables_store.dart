import 'package:mobx/mobx.dart';
import 'table_store.dart';

part 'tables_store.g.dart';

class TablesStore = _TablesStoreBase with _$TablesStore;

abstract class _TablesStoreBase with Store {
  @observable
  ObservableList<TableStore> tables = ObservableList<TableStore>();

  @computed
  int get totalTables => tables.length;

  @action
  void addTable(TableStore table) {
    tables.add(table);
  }

  @action
  void editTable(int index, TableStore table) {
    if (index >= 0 && index < tables.length) {
      tables[index] = table;
    }
  }

  @action
  void removeTable(TableStore table) {
    tables.remove(table);
  }
}
