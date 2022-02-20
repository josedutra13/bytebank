import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widget/centered_message.dart';
import 'package:bytebank/widget/progress.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();
  TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Transactions'),
        ),
        body: FutureBuilder<List<Transaction>>(
            future: _webClient.findAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Progress(message: 'Carregando transações');
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final List<Transaction> transactions = snapshot.data!;
                  if (transactions.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.contact!.accountNumber.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    );
                  }
                }
                return const CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );
              }
              return const CenteredMessage('Unknow error');
            })
        //
        );
  }
}
