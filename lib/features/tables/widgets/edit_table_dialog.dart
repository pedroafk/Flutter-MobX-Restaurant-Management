import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_flutter/features/tables/entities/table.entity.dart';
import 'package:teste_flutter/features/tables/stores/edit_table_store.dart';

class EditTableDialog extends StatefulWidget {
  const EditTableDialog({super.key, required this.table});

  final TableEntity table;

  @override
  State<EditTableDialog> createState() => _EditTableDialogState();
}

class _EditTableDialogState extends State<EditTableDialog> {
  TextEditingController _quantityController = TextEditingController();
  final EditTableStore store = EditTableStore();

  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    final initialQuantity = widget.table.customers.isNotEmpty ? widget.table.customers.length : 1;
    store.setQuantity(initialQuantity);
    _quantityController = TextEditingController(text: initialQuantity.toString());

    _quantityController.addListener(() {
      final value = int.tryParse(_quantityController.text) ?? 1;
      store.setQuantity(value);
    });

    _disposer = reaction<int>(
      (_) => store.quantity,
      (value) {
        if (_quantityController.text != value.toString()) {
          _quantityController.text = value.toString();
        }
      },
    );
  }

  @override
  void dispose() {
    _disposer();
    _quantityController.dispose();
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
                      controller: _quantityController,
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
                      int currentValue = int.tryParse(_quantityController.text) ?? 1;
                      if (currentValue > 1) {
                        _quantityController.text = (currentValue - 1).toString();
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      _quantityController.text =
                          (int.parse(_quantityController.text) + 1).toString();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Observer(
                builder: (_) => ListView.builder(
                  itemCount: store.quantity,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person_outlined),
                                labelText: widget.table.customers[index].name,
                                border: const OutlineInputBorder(),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone_outlined),
                                labelText: widget.table.customers[index].phone,
                                border: const OutlineInputBorder(),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
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
