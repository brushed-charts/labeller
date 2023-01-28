import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/date_range_model.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

void main() {
  registerFallbackValue(DateRangeModel(MockPreferenceIO()));
  final dateTimeRangeA = DateTimeRange(
    start: DateTime.utc(2023, 01, 01),
    end: DateTime.utc(2023, 01, 20),
  );
  const strDateFrom = '2023-01-23T21:15:00.000Z';
  const strDateTo = '2023-01-23T22:00:00.000Z';
  late MockPreferenceIO mockPreference;
  late ProviderContainer providerContainer;

  setUp(() {
    mockPreference = MockPreferenceIO();
    providerContainer = ProviderContainer(overrides: [
      dateRangeProvider.overrideWith((ref) => DateRangeModel(mockPreference))
    ]);
    when(() => mockPreference.load('dateFrom'))
        .thenAnswer((_) => Future(() => strDateFrom));
    when(() => mockPreference.load('dateTo'))
        .thenAnswer((_) => Future(() => strDateTo));
    when(() => mockPreference.write(
            any(that: isIn(['dateFrom', 'dateTo'])), any()))
        .thenAnswer((_) => Future.delayed(const Duration(milliseconds: 50)));
  });

  test("Test the default values of date range model", () {
    final dateRangeModel = providerContainer.read(dateRangeProvider);
    expect(DateTime.now().toUtc().difference(dateRangeModel.end),
        lessThan(const Duration(minutes: 5)));
    expect(dateRangeModel.end.difference(dateRangeModel.start).inDays,
        allOf(lessThan(10), greaterThan(2)));
  });

  group("Date range model loading ->", () {
    test("Expect loading is delegate to PreferencIO", () async {
      await providerContainer.read(dateRangeProvider.notifier).refresh();
      verify(() => mockPreference.load('dateFrom')).called(1);
      verify(() => mockPreference.load('dateTo')).called(1);
    });
    test("Assert state is retrieved by loading preference ", () async {
      await providerContainer.read(dateRangeProvider.notifier).refresh();
      expect(
        providerContainer.read(dateRangeProvider).start.toIso8601String(),
        equals(strDateFrom),
      );
      expect(
        providerContainer.read(dateRangeProvider).end.toIso8601String(),
        equals(strDateTo),
      );
    });
  });

  test(
      "Test that date range saving call PreferenceIO "
      "with good parameters", () async {
    final intervalModel = providerContainer.read(dateRangeProvider.notifier);
    intervalModel.setDateRange(dateTimeRangeA);
    await intervalModel.save();

    verify(() => mockPreference.write('dateFrom', '2023-01-01T00:00:00.000Z'))
        .called(1);
    verify(() => mockPreference.write('dateTo', '2023-01-20T00:00:00.000Z'))
        .called(1);
  });

  test("Expect setDateRange in date range model update it self its state", () {
    providerContainer
        .read(dateRangeProvider.notifier)
        .setDateRange(dateTimeRangeA);
    final editedState = providerContainer.read(dateRangeProvider);
    expect(editedState, equals(dateTimeRangeA));
  });
}
