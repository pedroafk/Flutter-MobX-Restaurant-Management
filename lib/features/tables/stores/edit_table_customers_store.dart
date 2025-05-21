import 'package:mobx/mobx.dart';
import 'package:teste_flutter/features/customers/entities/customer.entity.dart';

part 'edit_table_customers_store.g.dart';

// ignore: library_private_types_in_public_api
class EditTableCustomersStore = _EditTableCustomersStoreBase with _$EditTableCustomersStore;

abstract class _EditTableCustomersStoreBase with Store {
  @observable
  ObservableList<CustomerEntity> customers = ObservableList<CustomerEntity>();

  @action
  void setCustomers(List<CustomerEntity> initial) {
    customers = ObservableList<CustomerEntity>.of(initial);
  }

  @action
  void addCustomer() {
    customers.add(
      CustomerEntity(
        id: customers.length + 1,
        name: '',
        phone: '',
      ),
    );
  }

  @action
  void removeLastCustomer() {
    if (customers.isNotEmpty) {
      customers.removeLast();
    }
  }

  @action
  void updateCustomerName(int index, String name) {
    customers[index] = customers[index].copyWith(name: name);
  }

  @action
  void updateCustomerPhone(int index, String phone) {
    customers[index] = customers[index].copyWith(phone: phone);
  }
}
