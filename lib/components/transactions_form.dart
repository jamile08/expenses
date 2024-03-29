import 'package:expenses/components/adaptativeButton.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:flutter/material.dart';

import 'adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double value, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitedForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) return;

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextFormField(
                label: 'Título',
                controller: _titleController,
                onSubmitted: (value) => _submitedForm(),
              ),
              AdaptativeTextFormField(
                label: 'Valor R\$',
                controller: _valueController,
                onSubmitted: (value) => _submitedForm(),
                keyBoardType: TextInputType.numberWithOptions(decimal: true),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitedForm(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
