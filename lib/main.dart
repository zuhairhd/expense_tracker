import 'package:flutter/material.dart';
import 'models/account.dart';
import 'add_entry_screen.dart';
import 'account_management_screen.dart';
import 'account_status_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Account> accounts = [
    Account(name: "Cash", balance: 0.0),
    Account(name: "Bank", balance: 0.0),
  ];

  void _addEntry(String fromAccount, String toAccount, double amount) {
    setState(() {
      accounts.firstWhere((account) => account.name == fromAccount).balance -= amount;
      accounts.firstWhere((account) => account.name == toAccount).balance += amount;
    });
  }

  void _addAccount(Account account) {
    setState(() {
      accounts.add(account);
    });
  }

  void _editAccount(Account account, String newName) {
    setState(() {
      account.name = newName;
    });
  }

  void _deleteAccount(Account account) {
    setState(() {
      accounts.remove(account);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountStatusScreen(accounts: accounts),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.manage_accounts),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountManagementScreen(
                    accounts: accounts,
                    onAddAccount: _addAccount,
                    onEditAccount: _editAccount,
                    onDeleteAccount: _deleteAccount,
                  ),
                ),
              ).then((_) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          return ListTile(
            title: Text(account.name),
            subtitle: Text('Balance: \$${account.balance.toStringAsFixed(2)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEntryScreen(accounts: accounts, onAddEntry: _addEntry),
            ),
          );
        },
        tooltip: 'Add Entry',
        child: Icon(Icons.add),
      ),
    );
  }
}
