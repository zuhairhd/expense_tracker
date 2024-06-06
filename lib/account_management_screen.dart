import 'package:flutter/material.dart';
import 'models/account.dart';

class AccountManagementScreen extends StatefulWidget {
  final List<Account> accounts;
  final Function(Account) onAddAccount;
  final Function(Account, String) onEditAccount;
  final Function(Account) onDeleteAccount;

  AccountManagementScreen({
    required this.accounts,
    required this.onAddAccount,
    required this.onEditAccount,
    required this.onDeleteAccount,
  });

  @override
  _AccountManagementScreenState createState() => _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _accountName;
  bool _isEditing = false;
  Account? _editingAccount;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        if (_isEditing && _editingAccount != null) {
          widget.onEditAccount(_editingAccount!, _accountName!);
          _isEditing = false;
          _editingAccount = null;
        } else {
          widget.onAddAccount(Account(name: _accountName!, balance: 0.0));
        }
      });
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Accounts'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Account Name'),
                      initialValue: _isEditing ? _editingAccount?.name : '',
                      onSaved: (value) {
                        _accountName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an account name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(_isEditing ? 'Edit' : 'Add'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.accounts.length,
              itemBuilder: (context, index) {
                final account = widget.accounts[index];
                return ListTile(
                  title: Text(account.name),
                  subtitle: Text('Balance: \$${account.balance.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            _isEditing = true;
                            _editingAccount = account;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          widget.onDeleteAccount(account);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
