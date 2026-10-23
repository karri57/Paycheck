import 'package:clearpath_money/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows dashboard and purchase checker', (tester) async {
    await tester.pumpWidget(const ClearPathApp());
    expect(find.text('SAFE TO SPEND'), findsOneWidget);
    await tester.tap(find.text('Can I afford something?'));
    await tester.pumpAndSettle();
    expect(find.text('Can I afford it?'), findsOneWidget);
  });

  testWidgets('navigates to bills', (tester) async {
    await tester.pumpWidget(const ClearPathApp());
    await tester.tap(find.text('Bills').last);
    await tester.pumpAndSettle();
    expect(find.text('Nothing sneaks up on you.'), findsOneWidget);
  });
}
