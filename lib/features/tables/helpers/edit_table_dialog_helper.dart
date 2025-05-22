import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_flutter/features/customers/entities/customer.entity.dart';
import 'package:teste_flutter/features/tables/entities/table.entity.dart';
import 'package:teste_flutter/features/tables/stores/edit_table_store.dart';

class EditTableDialogHelper {
  final TableEntity table;
  final EditTableStore editTableStore;

  late TextEditingController quantityController;
  late TextEditingController tableIdentifierController;

  List<TextEditingController> customerNameControllers = [];
  List<TextEditingController> customerPhoneControllers = [];

  late ReactionDisposer disposer;

  EditTableDialogHelper({
    required this.table,
    required this.editTableStore,
  });

  void initialize() {
    tableIdentifierController = TextEditingController(text: table.identification);

    final initialQuantity = table.customers.isNotEmpty ? table.customers.length : 1;

    quantityController = TextEditingController(text: initialQuantity.toString());

    editTableStore.setCustomers(table.customers);

    editTableStore.setQuantity(initialQuantity);

    editTableStore.setTableIdentifier(table.identification);

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

    customerNameControllers =
        table.customers.map((c) => TextEditingController(text: c.name)).toList();
    customerPhoneControllers =
        table.customers.map((c) => TextEditingController(text: c.phone)).toList();
  }

  void syncControllersWithCustomers(List<CustomerEntity> customers) {
    while (customerNameControllers.length < customers.length) {
      customerNameControllers.add(TextEditingController());
      customerPhoneControllers.add(TextEditingController());
    }
    while (customerNameControllers.length > customers.length) {
      customerNameControllers.removeLast().dispose();
      customerPhoneControllers.removeLast().dispose();
    }
    for (var i = 0; i < customers.length; i++) {
      if (customerNameControllers[i].text != customers[i].name) {
        customerNameControllers[i].text = customers[i].name;
      }
      if (customerPhoneControllers[i].text != customers[i].phone) {
        customerPhoneControllers[i].text = customers[i].phone;
      }
    }
  }

  void dispose() {
    disposer();
    quantityController.dispose();
    tableIdentifierController.dispose();
    for (final c in customerNameControllers) {
      c.dispose();
    }
    for (final c in customerPhoneControllers) {
      c.dispose();
    }
  }
}
