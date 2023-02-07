import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:labelling/toolbar/controller/source_field.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

class MockMarketMetadataModel extends Mock implements MarketMetadataModel {
  @override
  String rawSource = "BROKER:ASSET";
}

void main() {
  testWidgets(
      "Toolbar's source field, display "
      "broker and asset pairs in the text field", (tester) async {
    final marketMetadata = MarketMetadataModel(MockPreferenceIO());
    marketMetadata.rawSource = "BROKER:ASSET_PAIR";
    await tester.pumpWidget(MaterialApp(
        home:
            Scaffold(body: SourceField(marketMetadataModel: marketMetadata))));
    expect(find.text("BROKER:ASSET_PAIR"), findsOneWidget);
  });

  testWidgets("Toolbar source fields, update model on change", (tester) async {
    final mockModel = MockMarketMetadataModel();
    when(() => mockModel.save()).thenAnswer((_) async {});
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: SourceField(
      marketMetadataModel: mockModel,
    ))));
    await tester.tap(find.byType(SourceField));
    await tester.enterText(find.byType(SourceField), 'USER_BROKER:USER_ASSET');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(find.text('USER_BROKER:USER_ASSET'), findsOneWidget);
    expect(mockModel.rawSource, equals('USER_BROKER:USER_ASSET'));
    verify(() => mockModel.save()).called(1);
  });
}
