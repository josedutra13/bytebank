import 'contacts.dart';

class Transaction {
  final double value;
  final Contact? contact;

  Transaction(
    this.value,
    this.contact,
  ) : assert(value > 0);

  Transaction.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        contact = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'value': value,
        'contact': contact!.toJson(),
      };
  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          contact == other.contact;

  @override
  int get hashCode => value.hashCode ^ contact.hashCode;
}
