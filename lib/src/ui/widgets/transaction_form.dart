import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime, String) onSubmit;

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
      final categoryValue = _valueDropDownButton;

      if (title.isEmpty ||
          value <= 0 ||
          date == null ||
          categoryValue == null) {
        return;
      }

      widget.onSubmit(
        title,
        value,
        date,
        categoryValue,
      );
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gasto adicionado!'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    // ignore: no_leading_underscores_for_local_identifiers
    void _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year, DateTime.now().month),
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

    void showInfo() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              'Como adicionar um novo gasto?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Text(
              'Adicione um novo gasto preenchendo os campos abaixo com as informações correspondentes e finalize a ação. Para excluir um gasto, basta arrastá-lo para a esquerda.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodySmall,
                  foregroundColor: Theme.of(context).colorScheme.primary,
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

    void dropDownCallBack(String? value) {
      setState(() {
        _valueDropDownButton = value;
      });
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
                  'Adicione um gasto',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: showInfo,
                  icon: Icon(
                    Icons.info_outline_rounded,
                    color: Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            DropdownButton(
              items: const [
                DropdownMenuItem(value: '0', child: Text('Alimentos')),
                DropdownMenuItem(value: '1', child: Text('Faturas')),
                DropdownMenuItem(value: '2', child: Text('Transporte')),
                DropdownMenuItem(value: '3', child: Text('Moradia')),
                DropdownMenuItem(value: '4', child: Text('Outros')),
              ],
              value: _valueDropDownButton,
              onChanged: dropDownCallBack,
              hint: const Text(
                'Selecione uma categoria',
                style: TextStyle(color: Colors.grey),
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              padding: const EdgeInsets.only(top: 15),
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              dropdownColor: Theme.of(context).colorScheme.background,
              icon: Icon(
                _valueDropDownButton == null
                    ? Icons.bookmark_outline_rounded
                    : Icons.bookmark_added_rounded,
              ),
              iconEnabledColor: const Color(0XFF6365EE),
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
                      foregroundColor: const Color(0XFF6365EE),
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
                    foregroundColor: const Color(0XFF6365EE),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    disabledForegroundColor: Colors.grey,
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
