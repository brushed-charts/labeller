import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/source_model.dart';
import 'package:labelling/observation/observer.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

class MockObserver extends Mock implements Observer {}

void main() {
  registerFallbackValue(SourceModel(MockPreferenceIO()));
  late SourceModel sourceModel;
  late MockPreferenceIO mockPreference;
  const strDateStart = '2023-01-20T10:45:00Z';
  const strDateEnd = '2023-01-21T18:45:00Z';
  final dateStart = DateTime.parse(strDateStart);
  final dateEnd = DateTime.parse(strDateEnd);

  setUp(() {
    mockPreference = MockPreferenceIO();
    when(() => mockPreference.load(any(that: equals('interval'))))
        .thenAnswer((_) => Future(() => 'test_interval'));
    when(() => mockPreference.load(any(that: equals('dateFrom'))))
        .thenAnswer((_) => Future(() => strDateStart));
    when(() => mockPreference.load(any(that: equals('dateTo'))))
        .thenAnswer((_) => Future(() => strDateEnd));
    when(() => mockPreference.load(any(that: equals('rawSource'))))
        .thenAnswer((_) => Future(() => 'TEST_BROKER:TEST_PAIR'));
    when(() => mockPreference.write(any(), any()))
        .thenAnswer((_) async => Future(() => ""));
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

  group("Source model loading ->", () {
    test("Expect it delegate loading to PreferenceIO", () async {
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

    test("Assert state is retrieved by loading preference ", () async {
      await sourceModel.refresh();
      expect(sourceModel.interval, equals('test_interval'));
      expect(sourceModel.rawSource, equals('TEST_BROKER:TEST_PAIR'));
      expect(sourceModel.dateRange.start, dateStart);
      expect(sourceModel.dateRange.end, dateEnd);
    });
  });

  group("SourceModel saving ->", () {
    test("Test it delegate to PreferenceIO", () async {
      await sourceModel.save();
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

    test("Assert SourceModel notify observers on saving", () async {
      final mockObserver = MockObserver();
      sourceModel.subscribe(mockObserver);
      await sourceModel.save();
      verify(() => mockObserver
          .onObservableEvent(any(that: isInstanceOf<SourceModel>()))).called(1);
    });
  });
}

String limitDateToMinute(DateTime dt) {
  return "${dt.year}-${dt.month}-${dt.day} ${dt.hour}:${dt.minute}";
}
