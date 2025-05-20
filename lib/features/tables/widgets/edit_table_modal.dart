import 'package:flutter/material.dart';

class EditTableModal extends StatefulWidget {
  final String initialIdentification;
  final int initialPeopleCount;
  final List<dynamic> initialCustomers;

  const EditTableModal({
    super.key,
    required this.initialIdentification,
    required this.initialPeopleCount,
    required this.initialCustomers,
  });

  @override
  State<EditTableModal> createState() => _EditTableModalState();
}

class _EditTableModalState extends State<EditTableModal> {
  late TextEditingController _identificationController;
  late TextEditingController _peopleCountController;

  int get _peopleCount => int.tryParse(_peopleCountController.text) ?? 1;
  set _peopleCount(int value) {
    _peopleCountController.text = value.toString();
    setState(() {});
  }

  late List<dynamic> _customers;
  late List<TextEditingController> _customerControllers;
  String _searchQuery = '';

  void _incrementQuantity() {
    _peopleCount = _peopleCount + 1;
  }

  void _decrementQuantity() {
    if (_peopleCount > 1) {
      _peopleCount = _peopleCount - 1;
    }
  }

  @override
  void initState() {
    super.initState();
    _identificationController = TextEditingController(text: widget.initialIdentification);
    _peopleCountController = TextEditingController(text: widget.initialPeopleCount.toString());
    _peopleCount = widget.initialPeopleCount;
    _customers = List.from(widget.initialCustomers);
    _customerControllers = List.generate(
      _peopleCount,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    _identificationController.dispose();
    for (var controller in _customerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildCustomerSection(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cliente ${index + 1}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _customers.length > index && _customers[index] != null
            ? Text(_customers[index].toString())
            : const Text('Não informado'),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pesquisar por nome ou telefone'),
        const SizedBox(height: 8),
        TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
        ),
        const SizedBox(height: 16),
        _buildSearchResults(),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  Widget _buildSearchResults() {
    final mockResults = [
      'Elieze',
      'Eliezer',
      'Eli',
    ];

    final filteredResults = mockResults
        .where((name) => name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Novo cliente'),
          onTap: () {},
        ),
        ...filteredResults.map((name) => ListTile(
              title: Text(name),
              trailing: Radio<String>(
                value: name,
                groupValue: null,
                onChanged: (value) {},
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar informações da mesa'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _identificationController,
                decoration: const InputDecoration(
                  labelText: 'Identificação da mesa',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Informação temporária para ajudar na identificação do cliente.",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 20,
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                "Clientes nesta conta",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Associe os clientes aos pedidos para salvar o pedido no histórico do cliente, pontuar no fidelidade e fazer pagamentos no fiado.",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _peopleCountController,
                      decoration: const InputDecoration(
                        labelText: 'Identificação da mesa',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IntrinsicWidth(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: _decrementQuantity,
                          child: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: _incrementQuantity,
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...List.generate(_peopleCount, (index) => _buildCustomerSection(index)),
              _buildSearchSection(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Voltar'),
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
