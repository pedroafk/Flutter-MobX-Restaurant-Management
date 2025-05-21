import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_flutter/features/tables/entities/table.entity.dart';
import 'package:teste_flutter/features/tables/stores/edit_table_customers_store.dart';
import 'package:teste_flutter/features/tables/stores/edit_table_store.dart';

class EditTableDialogHelper {
  final TableEntity table;
  final EditTableStore editTableStore;
  final EditTableCustomersStore customersStore;

  late TextEditingController quantityController;
  late ReactionDisposer disposer;

  EditTableDialogHelper({
    required this.table,
    required this.editTableStore,
    required this.customersStore,
  });

  void initialize() {
    customersStore.setCustomers(table.customers);

    final initialQuantity = table.customers.isNotEmpty ? table.customers.length : 1;

    editTableStore.setQuantity(initialQuantity);

    quantityController = TextEditingController(text: initialQuantity.toString());

    quantityController.addListener(() {
      final value = int.tryParse(quantityController.text) ?? 1;
      editTableStore.setQuantity(value);
    });
    disposer = reaction<int>(
      (_) => editTableStore.quantity,
      (value) {
        if (quantityController.text != value.toString()) {
          quantityController.text = value.toString();
        }
      },
    );
  }

  void dispose() {
    disposer();
    quantityController.dispose();
  }
}
