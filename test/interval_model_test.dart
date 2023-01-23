import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/interval_model.dart';
import 'package:labelling/model/source_model.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

void main() {
  registerFallbackValue(SourceModel(MockPreferenceIO()));
  late MockPreferenceIO mockPreference;
  late ProviderContainer providerContainer;

  setUp(() {
    mockPreference = MockPreferenceIO();
    providerContainer = ProviderContainer(overrides: [
      intervalModelProvider.overrideWith((ref) => IntervalModel(mockPreference))
    ]);
    when(() => mockPreference.load(any()))
        .thenAnswer((_) => Future(() => 'test_interval'));
    when(() => mockPreference.write('interval', any()))
        .thenAnswer((invocation) => Future(() {}));
  });

  test("Test the default values of source model ", () {
    expect(providerContainer.read(intervalModelProvider), equals("30m"));
  });

  group("Interval model loading ->", () {
    test("Expect loading is delegate to PreferencIO", () async {
      await providerContainer.read(intervalModelProvider.notifier).refresh();
      verify(() => mockPreference.load('interval')).called(1);
    });
    test("Assert state is retrieved by loading preference ", () async {
      await providerContainer.read(intervalModelProvider.notifier).refresh();
      expect(providerContainer.read(intervalModelProvider),
          equals('test_interval'));
    });
  });

  test(
      "Test that interval model use PreferenceIO "
      "with good parameters on saving ", () async {
    final intervalModel =
        providerContainer.read(intervalModelProvider.notifier);
    intervalModel.setInterval('10m');
    await intervalModel.save();
    verify(() => mockPreference.write('interval', '10m')).called(1);
  });

  test("Expect setInterval from interval model update its state", () {
    final state = providerContainer.read(intervalModelProvider);
    expect(state, equals(IntervalModel.defaultInterval));
    providerContainer.read(intervalModelProvider.notifier).setInterval('10m');
    final editedState = providerContainer.read(intervalModelProvider);
    expect(editedState, equals('10m'));
  });
}
