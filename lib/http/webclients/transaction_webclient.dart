import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
// URL para requisições

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(const Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson.map((e) => Transaction.fromJson(e)).toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseUrl,
        headers: {'Content-Type': 'application/json', 'password': '1000'},
        body: transactionJson);

    final json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}
