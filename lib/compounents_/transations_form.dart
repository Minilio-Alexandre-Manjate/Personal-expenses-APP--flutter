import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _valueController = TextEditingController();

  final _titleController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  // ignore: non_constant_identifier_names
  _SubmitForm() {
    final title = _titleController.text;
    final value = double.parse(_valueController.text);

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _SubmitForm(),
              decoration: const InputDecoration(
                labelText: ('Title'),
              ),
            ),
            TextField(
              controller: _valueController,
              onSubmitted: (_) => _SubmitForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: ('Value(\$)'),
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 193, 206, 217)),
                    child: Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'NO DATE HAS BEEN SELECTED!'
                            : 'SELECTED DATE: ${DateFormat('dd/MM/yy').format(_selectedDate!)}',
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Select date',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                      selectionColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _SubmitForm,
                  child: const Text(
                    'New transaction',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
