import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:labelling/toolbar/controller/source_field.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

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

  testWidgets("Toolbar source fields, update model on change", (tester) {
    var mockModel;
    verify(() => mockModel.save(any())).called(1);
  });
}
