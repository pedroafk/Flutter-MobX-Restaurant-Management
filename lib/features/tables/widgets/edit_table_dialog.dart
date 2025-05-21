import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_flutter/features/tables/entities/table.entity.dart';
import 'package:teste_flutter/features/tables/helpers/edit_table_dialog_helper.dart';
import 'package:teste_flutter/features/tables/stores/edit_table_customers_store.dart';
import 'package:teste_flutter/features/tables/stores/edit_table_store.dart';

class EditTableDialog extends StatefulWidget {
  const EditTableDialog({super.key, required this.table});

  final TableEntity table;

  @override
  State<EditTableDialog> createState() => _EditTableDialogState();
}

class _EditTableDialogState extends State<EditTableDialog> {
  late final EditTableDialogHelper _helper;

  @override
  void initState() {
    super.initState();
    _helper = EditTableDialogHelper(
      table: widget.table,
      editTableStore: EditTableStore(),
      customersStore: EditTableCustomersStore(),
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
                    'Editar informações da mesa ${widget.table.id}',
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
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Mesa de ${widget.table.identification}',
                  border: const OutlineInputBorder(),
                ),
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
                  IconButton(
                    onPressed: () {
                      if (_helper.customersStore.customers.length > 1) {
                        setState(() {
                          _helper.customersStore.removeLastCustomer();
                          _helper.quantityController.text =
                              _helper.customersStore.customers.length.toString();
                        });
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _helper.customersStore.addCustomer();
                        _helper.quantityController.text =
                            _helper.customersStore.customers.length.toString();
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Observer(
                builder: (_) => ListView.builder(
                  itemCount: _helper.customersStore.customers.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final customer = _helper.customersStore.customers[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(text: customer.name),
                              onChanged: (value) =>
                                  _helper.customersStore.updateCustomerName(index, value),
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
                              controller: TextEditingController(text: customer.phone),
                              onChanged: (value) =>
                                  _helper.customersStore.updateCustomerPhone(index, value),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.phone_outlined),
                                labelText: 'Telefone',
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1FB76C),
                      ),
                      child: const Text(
                        'Criar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
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
