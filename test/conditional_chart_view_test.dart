import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/conditionnal_chart_view.dart';
import 'package:labelling/error_screen.dart';
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

  testWidgets("Assert conditionnal view display input no data screen at start",
      (tester) async {
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

  testWidgets(
      "Assert conditionnal view display input loading screen "
      "and circular loading when chart state is loading", (tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: ConditionnalChartView(
            chartModel: chartModel,
            noData: const NoDataWidget(),
            error: const Placeholder(),
            onData: const Placeholder(),
            loading: const LoadingScreen())));
    chartModel.stateModel.updateState(ChartViewState.loading);
    await tester.pump();
    expect(find.byType(LoadingScreen), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      "Assert conditionnal view display input error screen "
      "with error explanation", (tester) async {
    chartModel.stateModel.updateState(ChartViewState.error);
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: ConditionnalChartView(
            chartModel: chartModel,
            noData: const NoDataWidget(),
            error: ErrorScreen(chartStateModel: chartModel.stateModel),
            onData: const Placeholder(),
            loading: const LoadingScreen())));
    expect(find.byType(ErrorScreen), findsOneWidget);
  });
}
