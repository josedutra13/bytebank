import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mocks/contact_list_flow_test.mocks.dart';
import '../matchers/matcher.dart';
import 'actions.dart';

@GenerateMocks([ContactDao, TransactionWebClient])
void main() => testWidgets('Should save a contact', (tester) async {
      final mockContactDao = MockContactDao();
      final transactionWebClient = MockTransactionWebClient();

      when(mockContactDao.findAll()).thenAnswer((_) async => []);
      when(mockContactDao.save(any)).thenAnswer((_) async => 1);
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

      final fabNewContact =
          find.widgetWithIcon(FloatingActionButton, Icons.add);
      expect(fabNewContact, findsOneWidget);
      await tester.tap(fabNewContact);
      await tester.pumpAndSettle();

      final contactForm = find.byType(ContactForm);
      expect(contactForm, findsOneWidget);

      final nameTextField = find.byWidgetPredicate((widget) {
        return textFieldByLabelText(widget, 'Full name');
      });

      expect(nameTextField, findsOneWidget);
      await tester.enterText(nameTextField, 'José');

      final accountTextField = find.byWidgetPredicate((widget) {
        return textFieldByLabelText(widget, 'Account number');
      });

      expect(accountTextField, findsOneWidget);
      await tester.enterText(accountTextField, '1111');

      final createButton = find.widgetWithText(ElevatedButton, 'Create');
      expect(createButton, findsOneWidget);
      await tester.tap(createButton);
      await tester.pumpAndSettle();

      verify(mockContactDao
          .save(Contact(id: 0, name: 'José', accountNumber: 1111)));

      final contactListBack = find.byType(ContactsList);
      expect(contactListBack, findsOneWidget);

      verify(mockContactDao.findAll()).called(2);
    });
