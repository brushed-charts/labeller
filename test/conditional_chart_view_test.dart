import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/conditionnal_chart_view.dart';
import 'package:labelling/model/date_range_model.dart';
import 'package:labelling/model/interval_model.dart';
import 'package:labelling/model/source_model.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

void main() {
  late ProviderContainer providerContainer;
  late MockPreferenceIO mockPreference;
  late SourceModel sourceModel;
  late IntervalModel intervalModel;
  late DateRangeModel dateRangeModel;

  setUp(() {
    mockPreference = MockPreferenceIO();
    providerContainer = ProviderContainer(overrides: [
      dateRangeProvider.overrideWith((ref) => DateRangeModel(mockPreference)),
      sourceModelProvider.overrideWith((ref) => SourceModel(mockPreference)),
      intervalModelProvider.overrideWith((ref) => IntervalModel(mockPreference))
    ]);
    sourceModel = providerContainer.read(sourceModelProvider.notifier);
    intervalModel = providerContainer.read(intervalModelProvider.notifier);
    dateRangeModel = providerContainer.read(dateRangeProvider.notifier);
    when(() => mockPreference.load(any()))
        .thenAnswer((_) => Future.delayed(const Duration(milliseconds: 100)));
  });

  test(
      "Check that metadata provider is ready only after "
      "all metadata are refreshed ", () async {
    await sourceModel.refresh();
    expect(providerContainer.refresh(isChartMetadataReady), isFalse);
    await intervalModel.refresh();
    expect(providerContainer.refresh(isChartMetadataReady), isFalse);
    await dateRangeModel.refresh();
    expect(providerContainer.refresh(isChartMetadataReady), isTrue);
  });

  test("", () => null);
}
