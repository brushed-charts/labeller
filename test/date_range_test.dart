import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/date_range_model.dart';
import 'package:labelling/model/source_model.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

void main() {
  registerFallbackValue(DateRangeModel(MockPreferenceIO()));
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

  group("date range model loading ->", () {
    test("Expect loading is delegate to PreferencIO", () async {
      await providerContainer.read(dateRangeProvider.notifier).load();
      verify(() => mockPreference.load('dateFrom')).called(1);
      verify(() => mockPreference.load('dateTo')).called(1);
    });
    test("Assert state is retrieved by loading preference ", () async { continue here
      await providerContainer.read(dateRangeProvider.notifier).load();
      expect(
        providerContainer.read(dateRangeProvider.notifier),
        equals(''),
      );
    });
  });

  test(
      "Test that source model saving call PreferenceIO "
      "with good parameters", () async {
    final intervalModel = providerContainer.read(sourceModelProvider.notifier);
    intervalModel.setSource('A_BROKER:TEST_PAIR');
    await intervalModel.save();
    verify(() => mockPreference.write('source', 'A_BROKER:TEST_PAIR'))
        .called(1);
  });

  test("Expect setSource from source model update its state", () {
    final state = providerContainer.read(sourceModelProvider);
    expect(state, equals(SourceModel.defaultSource));
    providerContainer.read(sourceModelProvider.notifier).setSource('BR:PAIR');
    final editedState = providerContainer.read(sourceModelProvider);
    expect(editedState, equals('BR:PAIR'));
  });
}
