class Contact {
  final int? id;
  final String name;
  final int accountNumber;

  Contact({required this.name, this.id, required this.accountNumber});

  @override
  String toString() {
    // TODO: implement toString
    return 'Contact{id:$id ,name: $name, accountNumber: $accountNumber}';
  }

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'accountNumber': accountNumber,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          accountNumber == other.accountNumber;

  @override
  int get hashCode => name.hashCode ^ accountNumber.hashCode;

  // static Contact? empty() {}
}
