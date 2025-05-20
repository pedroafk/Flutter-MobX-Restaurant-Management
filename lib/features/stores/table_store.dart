import 'package:mobx/mobx.dart';

part 'table_store.g.dart';

class TableStore = _TableStoreBase with _$TableStore;

class CustomerEntity {
  final int id;
  final String name;
  final String phone;

  CustomerEntity({required this.id, required this.name, required this.phone});
}

abstract class _TableStoreBase with Store {
  _TableStoreBase({
    required this.id,
    required String identification,
    List<CustomerEntity>? customers,
  })  : identification = identification,
        customers = ObservableList.of(customers ?? []);

  final int id;

  @observable
  String identification;

  @observable
  ObservableList<CustomerEntity> customers;

  @computed
  int get customerCount => customers.length;

  @action
  void setIdentification(String value) {
    identification = value;
  }

  @action
  void setCustomers(List<CustomerEntity> value) {
    customers = ObservableList.of(value);
  }

  @action
  void addCustomer(CustomerEntity customer) {
    customers.add(customer);
  }

  @action
  void removeCustomer(CustomerEntity customer) {
    customers.removeWhere((c) => c.id == customer.id);
  }
}
