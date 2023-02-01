import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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
    when(() => mockPreference.write('source', any()))
        .thenAnswer((invocation) => Future(() {}));
  });

  test("Test the default values of source model", () {
    expect(
        providerContainer.read(sourceModelProvider), equals("OANDA:EUR_USD"));
  });

  group("source model loading ->", () {
    test("Expect loading is delegate to PreferencIO", () async {
      await providerContainer.read(sourceModelProvider.notifier).refresh();
      verify(() => mockPreference.load('source')).called(1);
    });
    test("Assert state is retrieved by loading preference ", () async {
      await providerContainer.read(sourceModelProvider.notifier).refresh();
      expect(
        providerContainer.read(sourceModelProvider),
        equals('test_source'),
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
