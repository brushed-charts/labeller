import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/loading_screen.dart';

void main() {
  testWidgets("Loading screen should show a loading circle", (tester) async {
    await tester.pumpWidget(const LoadingScreen());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
