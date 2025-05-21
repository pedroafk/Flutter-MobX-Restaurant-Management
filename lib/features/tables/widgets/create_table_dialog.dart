import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_flutter/features/tables/stores/create_table_store.dart';
import 'package:teste_flutter/features/tables/stores/tables_store.dart';
import 'package:teste_flutter/features/tables/utils/phone_utils.dart';

class CreateTableDialog extends StatefulWidget {
  const CreateTableDialog({super.key, required this.tablesStore});
  final TablesStore tablesStore;

  @override
  State<CreateTableDialog> createState() => _CreateTableDialogState();
}

class _CreateTableDialogState extends State<CreateTableDialog> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final CreateTableStore store = CreateTableStore();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Novo cliente',
                  style: TextStyle(
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
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Nome + Sobrenome',
                border: OutlineInputBorder(),
              ),
              onChanged: store.setName,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
                hintText: "(99) 99999-9999",
              ),
              onChanged: (value) {
                String formatted = formatPhone(value);
                _phoneController.value = TextEditingValue(
                  text: formatted,
                  selection: TextSelection.collapsed(offset: formatted.length),
                );
                store.setPhone(formatted);
              },
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
                      onPressed: store.name.isNotEmpty &&
                              store.phone.isNotEmpty &&
                              store.phone.length == 15
                          ? () {
                              widget.tablesStore.addTable(
                                store.name,
                                store.phone,
                              );
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: const Text(
                        'Criar',
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
    );
  }
}
