import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../mocks/dashboard_test.mocks.dart';
import '../matchers/matcher.dart';

@GenerateMocks([ContactDao])
void main() {
  final mockContactDao = MockContactDao();
  group('When Dashboard is opened', () {
    testWidgets('Should displayd a image when the app start', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Dashboard(),
      ));
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    });

    testWidgets(
        'Should display the transfer feature when the Dashboard is opened',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Dashboard(),
      ));
      final transferFeautureItem = find.byWidgetPredicate((widget) =>
          featureMatcher(widget, 'Transfer', Icons.monetization_on));

      expect(transferFeautureItem, findsOneWidget);
    });
    testWidgets(
        'Should display the transaction feed feature when the Dashboard is opened',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Dashboard(),
      ));
      final transactionFeedFeautureItem = find.byWidgetPredicate((widget) =>
          featureMatcher(widget, 'Transaction Feed', Icons.description));

      expect(transactionFeedFeautureItem, findsOneWidget);
    });
  });
}
