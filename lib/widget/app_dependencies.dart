import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;
  @override
  final Widget child;
  const AppDependencies(
      {required this.contactDao,
      required this.transactionWebClient,
      required this.child})
      : super(child: child);

  static AppDependencies of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>()!;
  }

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    // TODO: implement updateShouldNotify
    return contactDao != oldWidget.contactDao ||
        transactionWebClient != oldWidget.transactionWebClient;
  }
}
