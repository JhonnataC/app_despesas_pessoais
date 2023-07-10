import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    _submitForm() {
      final title = _titleController.text;
      final value = double.tryParse(_valueController.text) ?? 0.0;
      final date = _selectedDate;

      if (title.isEmpty || value <= 0 || date == null) {
        return;
      }

      widget.onSubmit(title, value, date);
    }

    // ignore: no_leading_underscores_for_local_identifiers
    _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      });
    }

    return Card(
      elevation: 5,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Adicione os dados da transação',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                controller: _valueController,
                onSubmitted: (_) => _submitForm(),
                onChanged: (value) {
                  if (value.contains(',')) {
                    _valueController.text = value.replaceAll(',', '.');
                    _valueController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _valueController.text.length),
                    );
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data foi selecionada!'
                            : DateFormat("d MMMM',' yyyy", 'pt_BR')
                                .format(_selectedDate!),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: const Text('Selecionar Data'),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Nova Transação'),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
