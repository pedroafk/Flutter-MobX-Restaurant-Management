import 'package:mobx/mobx.dart';

part 'create_table_store.g.dart';

class CreateTableStore = _CreateTableStoreBase with _$CreateTableStore;

abstract class _CreateTableStoreBase with Store {
  @observable
  String name = '';

  @observable
  String phone = '';

  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setPhone(String value) {
    phone = value;
  }
}
