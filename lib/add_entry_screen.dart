import 'package:flutter/material.dart';
import 'models/account.dart';

class AddEntryScreen extends StatefulWidget {
  final List<Account> accounts;
  final Function(String, String, double) onAddEntry;

  AddEntryScreen({required this.accounts, required this.onAddEntry});

  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _fromAccount;
  String? _toAccount;
  double? _amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Entry'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _fromAccount,
                hint: Text('From Account'),
                items: widget.accounts.map((account) {
                  return DropdownMenuItem<String>(
                    value: account.name,
                    child: Text(account.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _fromAccount = value;
                  });
                },
                validator: (value) => value == null ? 'Please select an account' : null,
              ),
              DropdownButtonFormField<String>(
                value: _toAccount,
                hint: Text('To Account'),
                items: widget.accounts.map((account) {
                  return DropdownMenuItem<String>(
                    value: account.name,
                    child: Text(account.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _toAccount = value;
                  });
                },
                validator: (value) => value == null ? 'Please select an account' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _amount = double.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onAddEntry(_fromAccount!, _toAccount!, _amount!);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
