class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact({required this.name, required this.id, required this.accountNumber});

  @override
  String toString() {
    // TODO: implement toString
    return 'Contact{name: $name, accountNumber: $accountNumber}';
  }
}
