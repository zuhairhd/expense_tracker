import 'package:flutter/material.dart';
import 'models/account.dart';

class AccountStatusScreen extends StatelessWidget {
  final List<Account> accounts;

  AccountStatusScreen({required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Status'),
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          final isCredit = account.balance >= 0;
          return ListTile(
            title: Text(account.name),
            subtitle: Text(
              'Balance: \$${account.balance.toStringAsFixed(2)}',
              style: TextStyle(
                color: isCredit ? Colors.green : Colors.red,
              ),
            ),
            trailing: Text(
              isCredit ? 'CR' : 'DR',
              style: TextStyle(
                color: isCredit ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
