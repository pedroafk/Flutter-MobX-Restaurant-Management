import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_flutter/features/tables/entities/table.entity.dart';
import 'package:teste_flutter/features/tables/helpers/edit_table_dialog_helper.dart';
import 'package:teste_flutter/features/tables/stores/edit_table_store.dart';
import 'package:teste_flutter/features/tables/stores/tables_store.dart';
import 'package:teste_flutter/features/tables/utils/phone_utils.dart';

class EditTableDialog extends StatefulWidget {
  const EditTableDialog({super.key, required this.tableEntity});

  final TableEntity tableEntity;

  @override
  State<EditTableDialog> createState() => _EditTableDialogState();
}

class _EditTableDialogState extends State<EditTableDialog> {
  late final EditTableDialogHelper _helper;
  final tablesStore = TablesStore();

  @override
  void initState() {
    super.initState();
    _helper = EditTableDialogHelper(
      table: widget.tableEntity,
      editTableStore: EditTableStore(),
    );
    _helper.initialize();
  }

  @override
  void dispose() {
    _helper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Editar informações de ${widget.tableEntity.identification}',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _helper.tableIdentifierController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Identificação da mesa',
                  border: OutlineInputBorder(),
                ),
                onChanged: _helper.editTableStore.setTableIdentifier,
              ),
              const SizedBox(height: 10),
              const Text(
                "Informação temporária para ajudar na identificação do cliente",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const Divider(
                height: 40,
                thickness: 4,
                color: Colors.black26,
              ),
              const SizedBox(height: 20),
              const Text("Clientes nesta conta"),
              const SizedBox(height: 10),
              const Text(
                "Associe os clientes aos pedidos para salvar o pedido no histórico do cliente, pontuar no fidelidade e fazer pagamentos no fiado.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _helper.quantityController,
                      enabled: false,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Quantidade de pessoas',
                        border: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Observer(
                    builder: (_) => IconButton(
                      onPressed: () {
                        if (_helper.editTableStore.customers.length > 1) {
                          _helper.editTableStore.removeLastCustomer();
                          _helper.quantityController.text =
                              _helper.editTableStore.customers.length.toString();
                        }
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Observer(
                    builder: (_) => IconButton(
                      onPressed: () {
                        _helper.editTableStore.addCustomer();
                        _helper.quantityController.text =
                            _helper.editTableStore.customers.length.toString();
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Observer(
                builder: (_) {
                  _helper.syncControllersWithCustomers(_helper.editTableStore.customers);
                  return ListView.builder(
                    itemCount: _helper.editTableStore.customers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _helper.customerNameControllers[index],
                                onChanged: (value) =>
                                    _helper.editTableStore.updateCustomerName(index, value),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person_outlined),
                                  labelText: 'Nome',
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                  controller: _helper.customerPhoneControllers[index],
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone_outlined),
                                    labelText: 'Telefone',
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                                  ),
                                  onChanged: (value) {
                                    String formatted = formatPhone(value);
                                    _helper.customerPhoneControllers[index].value =
                                        TextEditingValue(
                                      text: formatted,
                                      selection: TextSelection.collapsed(offset: formatted.length),
                                    );
                                    _helper.editTableStore.updateCustomerPhone(index, formatted);
                                  }),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Pesquisar cliente',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      child: const Text(
                        'Voltar',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Observer(
                    builder: (_) => SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1FB76C),
                        ),
                        onPressed: _helper.editTableStore.isSaveEnabled
                            ? () {
                                final updatedTable = widget.tableEntity.copyWith(
                                  customers: _helper.editTableStore.customers,
                                  identification: _helper.editTableStore.tableIdentifier,
                                );
                                Navigator.of(context).pop(updatedTable);
                              }
                            : null,
                        child: const Text(
                          'Salvar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
