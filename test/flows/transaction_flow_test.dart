import 'package:bytebank/main.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:bytebank/widget/response_dialog.dart';
import 'package:bytebank/widget/transaction_auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matcher.dart';
import '../mocks/contact_list_flow_test.mocks.dart';
import 'actions.dart';

void main() => testWidgets('Should transfer to a contact', (tester) async {
      final mockContactDao = MockContactDao();
      final transactionWebClient = MockTransactionWebClient();
      final jose = Contact(id: 1, name: 'José', accountNumber: 1111);
      when(mockContactDao.findAll()).thenAnswer((_) async => [jose]);
      when(transactionWebClient.save(any, any))
          .thenAnswer((_) async => Transaction(200, jose));
      await tester.pumpWidget(BytebankApp(
        contactDao: mockContactDao,
        transactionWebClient: transactionWebClient,
      ));

      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);

      await clickOnTheTrasferFeatureItem(tester);
      await tester.pumpAndSettle();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);

      final contactItem = find.byWidgetPredicate((widget) {
        if (widget is ContactItem) {
          return widget.contact.name == 'José' &&
              widget.contact.accountNumber == 1111;
        }
        return false;
      });
      expect(contactItem, findsOneWidget);
      await tester.tap(contactItem);
      await tester
          .pumpAndSettle(); // fazer microtrarefas até entrar no transactionForm

      final transactionForm = find.byType(TransactionForm);
      expect(transactionForm, findsOneWidget);

      final contactName = find.text('José');
      expect(contactName, findsOneWidget);
      final contactAccountNumber = find.text('1111');
      expect(contactAccountNumber, findsOneWidget);

      final textFieldValue = find
          .byWidgetPredicate((widget) => textFieldByLabelText(widget, 'Value'));
      expect(textFieldValue, findsOneWidget);
      await tester.enterText(textFieldValue, '200');

      final transferButton = find.widgetWithText(ElevatedButton, 'Transfer');
      expect(transferButton, findsOneWidget);
      await tester.tap(transferButton);
      await tester.pumpAndSettle();

      final transactionAuthDialog = find.byType(TransactionAuthDialog);
      expect(transactionAuthDialog, findsOneWidget);

      final transactionPassword =
          find.byKey(transactionAuthDialogTextFieldPasswordKey);
      expect(transactionPassword, findsOneWidget);
      await tester.enterText(transactionPassword, '1000');

      final cancelButton = find.widgetWithText(TextButton, 'Cancel');
      expect(cancelButton, findsOneWidget);
      final confirmButton = find.widgetWithText(TextButton, 'Confirm');
      expect(confirmButton, findsOneWidget);

      when(transactionWebClient.save(Transaction(200, jose), '1000'))
          .thenAnswer((_) async => Transaction(200, jose));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle();

      final sucessDialog = find.byType(SuccessDialog);
      expect(sucessDialog, findsOneWidget);

      final okButton = find.widgetWithText(TextButton, 'Ok');
      expect(okButton, findsOneWidget);
      await tester.tap(okButton);
      await tester.pumpAndSettle();

      final contactListBack = find.byType(ContactsList);
      expect(contactListBack, findsOneWidget);
    });
