import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should test the value from transction', () {
    final transaction = Transaction(200, null);
    expect(transaction.value, 200);
  });

  test('Should test if value is less then 0', () {
    expect(() => Transaction(0, null), throwsAssertionError);
  });
}
