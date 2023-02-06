import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/conditionnal_chart_view.dart';
import 'package:labelling/model/source_model.dart';
import 'package:labelling/no_data_screen.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

void main() {
  late MockPreferenceIO mockPreference;
  late SourceModel sourceModel;

  setUp(() {});

  testWidgets(
      "Assert conditionnal chart state view display NoData screen "
      "at start", (tester) async {
    await tester.pumpWidget(const Directionality(
        textDirection: TextDirection.ltr,
        child: ConditionnalChartView(
            noData: NoDataWidget(), onData: Placeholder())));
    expect(find.byType(NoDataWidget), findsOneWidget);
  });

  // testWidgets(
  //     "Assert conditionnal chart state view "
  //     "display loading screen when query is started", (tester) {
  //   // tester.pumpWidget()
  // });
}
