import 'package:mobx/mobx.dart';

part 'tables_store.g.dart';

class TablesStore = _TablesStoreBase with _$TablesStore;

abstract class _TablesStoreBase with Store {
  @observable
  ObservableList<int> tables = ObservableList<int>();

  @action
  void addTable() {
    tables.add(tables.length + 1);
  }
}
