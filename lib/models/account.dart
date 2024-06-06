class Account {
  String name;
  double balance;

  Account({required this.name, required this.balance});
}

class Entry {
  String fromAccount;
  String toAccount;
  double amount;

  Entry({required this.fromAccount, required this.toAccount, required this.amount});
}
