import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/conditionnal_chart_view.dart';
import 'package:labelling/loading_screen.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/model/chart_state.dart';
import 'package:labelling/no_data_screen.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

void main() {
  late ChartModel chartModel;

  setUp(() {
    chartModel = ChartModel.initWithDefault();
  });

  testWidgets(
      "Assert conditionnal chart state view display NoData screen "
      "at start", (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: ConditionnalChartView(
            chartModel: chartModel,
            noData: const NoDataWidget(),
            error: const Placeholder(),
            onData: const Placeholder(),
            loading: const LoadingScreen())));
    expect(find.byType(NoDataWidget), findsOneWidget);
  });

  testWidgets("Assert loading screen is displayed when chart state is loading",
      (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: ConditionnalChartView(
            chartModel: chartModel,
            noData: const NoDataWidget(),
            error: const Placeholder(),
            onData: const Placeholder(),
            loading: const LoadingScreen())));
    chartModel.stateModel.state = ChartViewState.loading;
    await tester.pump();
    expect(find.byType(LoadingScreen), findsOneWidget);
  });
}
