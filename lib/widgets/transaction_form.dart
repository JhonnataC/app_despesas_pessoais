import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  String? _valueDropDownButton;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    void _submitForm() {
      final title = _titleController.text;
      final value = double.tryParse(_valueController.text) ?? 0.0;
      final date = _selectedDate;

      if (title.isEmpty || value <= 0 || date == null) {
        return;
      }

      widget.onSubmit(title, value, date);
    }

    // ignore: no_leading_underscores_for_local_identifiers
    void _showDatePicker() {
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

    // ignore: no_leading_underscores_for_local_identifiers
    void _showInfo() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              'Como adicionar um novo gasto?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Text(
              'É simples! O título é o que será usado para identificar o gasto, após isso é só informar o valor atribuído ao gasto, a categoria em que ele se encaixa e a data que ele ocorreu, depois é só concluir a ação e pronto!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Theme.of(context).colorScheme.background,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.background,
            surfaceTintColor: Theme.of(context).colorScheme.background,
          );
        },
      );
    }

    void _dropDownCallBack(String? value) {
      setState(() {
        _valueDropDownButton = value;
      });
      print(_valueDropDownButton);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Adicione um novo gasto',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: _showInfo,
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 17),
                floatingLabelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                ),
              ),
            ),
            TextField(
              controller: _valueController,
              onSubmitted: (_) => _submitForm(),
              style: Theme.of(context).textTheme.bodyMedium,
              onChanged: (value) {
                if (value.contains(',')) {
                  _valueController.text = value.replaceAll(',', '.');
                  _valueController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _valueController.text.length),
                  );
                }
              },
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 17),
                floatingLabelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                ),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            DropdownButton(
              items: const [
                DropdownMenuItem(value: '1', child: Text('Alimentos')),
                DropdownMenuItem(value: '2', child: Text('Faturas')),
                DropdownMenuItem(value: '3', child: Text('Transporte')),
                DropdownMenuItem(value: '4', child: Text('Moradia')),
                DropdownMenuItem(value: '5', child: Text('Outros')),
              ],
              value: _valueDropDownButton,
              onChanged: _dropDownCallBack,
              hint: const Text(
                'Selecione uma categoria',
                style: TextStyle(color: Colors.grey),
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              padding: const EdgeInsets.only(top: 15),
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              dropdownColor: Theme.of(context).colorScheme.background,
              icon: const Icon(Icons.bookmark_outline_rounded),
              iconEnabledColor: Theme.of(context).colorScheme.secondary,
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
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
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.bodySmall,
                      foregroundColor: Theme.of(context).colorScheme.secondary,
                    ),
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
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                  onPressed:
                      !(_valueDropDownButton == null) ? _submitForm : null,
                  child: const Text('Concluído'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
