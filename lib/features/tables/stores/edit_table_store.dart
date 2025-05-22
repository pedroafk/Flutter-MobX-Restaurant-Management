// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:teste_flutter/features/customers/entities/customer.entity.dart';

part 'edit_table_store.g.dart';

class EditTableStore = _EditTableStore with _$EditTableStore;

abstract class _EditTableStore with Store {
  @observable
  int quantity = 1;

  @observable
  String tableIdentifier = '';

  @observable
  ObservableList<CustomerEntity> customers = ObservableList<CustomerEntity>();

  @action
  void setQuantity(int value) {
    quantity = value < 1 ? 1 : value;
  }

  @action
  void increment() {
    quantity++;
  }

  @action
  void decrement() {
    if (quantity > 1) quantity--;
  }

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
    if (customers.isNotEmpty) customers.removeLast();
  }

  @action
  void updateCustomerName(int index, String name) {
    customers[index] = customers[index].copyWith(name: name);
  }

  @action
  void updateCustomerPhone(int index, String phone) {
    customers[index] = customers[index].copyWith(phone: phone);
  }

  @action
  void setTableIdentifier(String value) {
    tableIdentifier = value;
  }

  @computed
  bool get isSaveEnabled {
    final hasTableIdentifier = tableIdentifier.trim().isNotEmpty;
    final allNamesFilled = customers.every((c) => c.name.trim().isNotEmpty);
    final allPhonesFilled = customers.every((c) => c.phone.trim().length == 15);
    return hasTableIdentifier && allNamesFilled && allPhonesFilled;
  }
}
