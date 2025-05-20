import 'package:flutter/material.dart';

class CreateTableModal extends StatefulWidget {
  final String? initialIdentification;
  final int initialPeopleCount;
  final List<dynamic> initialCustomers;

  const CreateTableModal({
    super.key,
    this.initialIdentification,
    this.initialPeopleCount = 0,
    this.initialCustomers = const [],
  });

  @override
  State<CreateTableModal> createState() => _CreateTableModalState();
}

class _CreateTableModalState extends State<CreateTableModal> {
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late int _peopleCount;
  late List<dynamic> _customers;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialIdentification ?? '');
    _phoneNumberController = TextEditingController();
    _peopleCount = widget.initialPeopleCount;
    _customers = List.from(widget.initialCustomers);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Novo cliente'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nome + Sobrenome'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              hintText: '(55) 99999-9999',
              border: OutlineInputBorder(),
              hintStyle: TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(_peopleCount, (index) {
            final customer = index < _customers.length ? _customers[index] : null;
            if (customer == null) {
              return DropdownButtonFormField<dynamic>(
                items: [],
                onChanged: (value) {
                  setState(() {
                    if (index < _customers.length) {
                      _customers[index] = value;
                    } else {
                      _customers.add(value);
                    }
                  });
                },
                decoration: const InputDecoration(labelText: 'Selecionar cliente'),
              );
            } else {
              return ListTile(
                title: Text(customer.name),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _customers[index] = null;
                    });
                  },
                ),
              );
            }
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
