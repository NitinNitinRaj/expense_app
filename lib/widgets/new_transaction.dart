import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  const NewTransaction({super.key, required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;
  void _submit() {
    final title = _titleController.text;
    dynamic amount;
    try {
      amount = double.parse(_amountController.text);
    } catch (e) {
      return;
    }
    if (title.isEmpty || amount <= 0 || _pickedDate == null) {
      return;
    }
    widget.addNewTransaction(title, amount,_pickedDate);

    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _pickedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: _titleController,
              onSubmitted: (_) => _submit(),
              autofocus: true,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_pickedDate == null
                      ? "No Date Chosen!"
                      : "Picked Date : ${DateFormat.yMd().format(_pickedDate!)}"),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text(
                    "Choose Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text(
                "Add Transcation",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
