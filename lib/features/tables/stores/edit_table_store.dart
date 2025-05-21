import 'package:mobx/mobx.dart';

part 'edit_table_store.g.dart';

// ignore: library_private_types_in_public_api
class EditTableStore = _EditTableStore with _$EditTableStore;

abstract class _EditTableStore with Store {
  @observable
  int quantity = 1;

  @action
  void setQuantity(int value) {
    if (value < 1) {
      quantity = 1;
    } else {
      quantity = value;
    }
  }

  @action
  void increment() {
    quantity++;
  }

  @action
  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
