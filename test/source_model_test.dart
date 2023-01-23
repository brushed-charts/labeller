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
      sourceModelProvider.overrideWith((ref) => SourceModel(mockPreference))
    ]);
    when(() => mockPreference.load(any()))
        .thenAnswer((_) => Future(() => 'test_source'));
    when(() => mockPreference.write('interval', any()))
        .thenAnswer((invocation) => Future(() {}));
  });

  test("Test the default values of source model ", () {
    expect(providerContainer.read(intervalModelProvider), equals("30m"));
  });

  group("Interval model loading ->", () {
    test("Assert loading is done asynchronously at instanciation", () async {
      // Read provider to activate model instanciation (lazy)
      providerContainer.read(intervalModelProvider);
      verify(() => mockPreference.load('interval')).called(1);
    });
    test("Expect loading is delegate to PreferencIO", () async {
      await providerContainer.read(intervalModelProvider.notifier).refresh();
      // Called 2 times at init + here with refresh
      verify(() => mockPreference.load('interval')).called(2);
    });

    test("Assert state is retrieved by loading preference ", () async {
      await providerContainer.read(intervalModelProvider.notifier).refresh();
      expect(providerContainer.read(intervalModelProvider),
          equals('test_interval'));
    });
  });

  group("SourceModel saving ->", () {
    test("Test it delegate to PreferenceIO", () async {
      final intervalModel =
          providerContainer.read(intervalModelProvider.notifier);
      intervalModel.setInterval('10m');
      await intervalModel.save();
      verify(() => mockPreference.write('interval', '10m')).called(1);
    });
  });
}
