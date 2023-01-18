import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/source_model.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

void main() {
  late SourceModel sourceModel;
  late MockPreferenceIO mockPreference;

  setUp(() {
    mockPreference = MockPreferenceIO();
    when(() => mockPreference.load(any())).thenAnswer((_) => Future(() => ''));
    sourceModel = SourceModel(mockPreference);
  });

  test("Test the default values of source model ", () {
    final modelDateRange = sourceModel.dateRange;
    final dateDifference = modelDateRange.end.difference(modelDateRange.start);
    final shortenedEndDate = limitDateToMinute(modelDateRange.end);
    expect(sourceModel.interval, equals("30m"));
    expect(dateDifference.inDays, equals(3));
    expect(sourceModel.rawSource, equals('OANDA:EUR_USD'));
    expect(shortenedEndDate, equals(limitDateToMinute(DateTime.now().toUtc())));
  });

  group("RawSource presentation ->", () {
    test("Assert source model can present the broker", () {
      sourceModel.rawSource = "BROKER_XY:ASSET_PAIR";
      expect(sourceModel.broker, equals("broker_xy"));
    });

    test("Assert source model can present asset_pair", () {
      sourceModel.rawSource = "BROKER_XY:AN_ASSET_PAIR";
      expect(sourceModel.assetPair, equals("an_asset_pair"));
    });
  });

  group("Assert copy edition don't affect original source model ->", () {
    test("when rawSource is edited", () {
      final sourceCopy = sourceModel.copy();
      sourceCopy.rawSource = "edited_field";
      expect(sourceCopy.rawSource, isNot(equals(sourceModel.rawSource)));
    });

    test("when interval is edited", () {
      final sourceCopy = sourceModel.copy();
      sourceCopy.interval = "1s";
      expect(sourceCopy.interval, isNot(equals(sourceModel.interval)));
    });

    test("when dateRange is edited", () {
      final sourceCopy = sourceModel.copy();
      sourceCopy.dateRange =
          DateTimeRange(start: DateTime.now(), end: DateTime.now().toUtc());
      expect(sourceCopy.dateRange, isNot(equals(sourceModel.dateRange)));
    });
  });

  test("Expect SourceModel delegate loading to PreferenceIO", () async {
    when(() => mockPreference.load(any()))
        .thenAnswer((_) async => Future(() => ""));
    await sourceModel.refresh();
    final capturedParams =
        verify(() => mockPreference.load(captureAny())).captured;
    expect(
        capturedParams,
        containsAll([
          'interval',
          'dateFrom',
          'dateTo',
          'rawSource',
        ]));
  });

  test("SourceModel delegate saving to PreferenceIO", () async {
    sourceModel.save();
    final capturedParams =
        verify(() => mockPreference.write(captureAny(), any())).captured;
    expect(
        capturedParams,
        containsAll([
          'interval',
          'dateFrom',
          'dateTo',
          'rawSource',
        ]));
  });
}

String limitDateToMinute(DateTime dt) {
  return "${dt.year}-${dt.month}-${dt.day} ${dt.hour}:${dt.minute}";
}
