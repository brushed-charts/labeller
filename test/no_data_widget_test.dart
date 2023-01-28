import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/no_data_screen.dart';

void main() {
  testWidgets("NoData screen should only display the text 'noData' in center",
      (tester) async {
    await tester.pumpWidget(const Directionality(
        textDirection: TextDirection.ltr, child: NoDataWidget()));
    final textNoData = find.text("There is no data");
    expect(textNoData, findsOneWidget);
  });
}
