import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/error_screen.dart';
import 'package:labelling/model/chart_state.dart';

void main() {
  late ChartStateModel stateModel;
  late Widget errorScreen;

  setUp(() {
    stateModel = ChartStateModel();
    errorScreen = Directionality(
      textDirection: TextDirection.ltr,
      child: ErrorScreen(
        chartStateModel: stateModel,
      ),
    );
  });

  testWidgets(
      "Expect error screen to be updated to display "
      "No error when state is not in error", (widgetTester) async {
    final stateModel = ChartStateModel();
    stateModel.updateState(ChartViewState.loading);
    await widgetTester.pumpWidget(errorScreen);
    expect(find.textContaining("No error occured"), findsOneWidget);
  });

  testWidgets(
      "Expect error screen to display "
      "explanation error text", (widgetTester) async {
    stateModel.updateState(ChartViewState.error, "A mock error occured");
    await widgetTester.pumpWidget(errorScreen);
    expect(find.text("A mock error occured"), findsOneWidget);
  });

  testWidgets(
      "Expect error screen to display only the error title when "
      "error state have no explication", (widgetTester) async {
    final stateModel = ChartStateModel();
    stateModel.updateState(ChartViewState.error);
    await widgetTester.pumpWidget(errorScreen);
    expect(find.text("An error occured"), findsOneWidget);
  });

  testWidgets(
      "Assert error screen is updated when "
      "model changing state", (widgetTester) async {
    stateModel.updateState(ChartViewState.loading);
    await widgetTester.pumpWidget(errorScreen);
    expect(find.textContaining("No error"), findsOneWidget);
    stateModel.updateState(ChartViewState.error, "an error mocked");
    await widgetTester.pump();
    expect(find.textContaining("an error mocked"), findsOneWidget);
  });
}
