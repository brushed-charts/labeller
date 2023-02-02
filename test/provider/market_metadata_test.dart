import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/date_range_model.dart';
import 'package:labelling/model/interval_model.dart';
import 'package:labelling/model/source_model.dart';
import 'package:labelling/provider/market_metadata.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockPreferenceIO extends Mock implements PreferenceIO {}

void main() {
  late ProviderContainer providerContainer;
  final dateTimeRangeA = DateTimeRange(
    start: DateTime.utc(2023, 01, 01),
    end: DateTime.utc(2023, 01, 20),
  );

  setUp(() {
    final mockPreference = MockPreferenceIO();
    providerContainer = ProviderContainer(overrides: [
      sourceModelProvider.overrideWith((ref) => SourceModel(mockPreference)),
      intervalModelProvider
          .overrideWith((ref) => IntervalModel(mockPreference)),
      dateRangeProvider.overrideWith((ref) => DateRangeModel(mockPreference)),
    ]);
  });

  test("Test market metadata provider return a version up to date", () {
    providerContainer.read(intervalModelProvider.notifier).setInterval("25m");
    providerContainer
        .read(sourceModelProvider.notifier)
        .setSource("BROKER_TEST:ASSET_TEST");
    providerContainer
        .read(dateRangeProvider.notifier)
        .setDateRange(dateTimeRangeA);
    final marketMetadata = providerContainer.read(marketMetadataProvider);
    expect(marketMetadata.assetPairs, equals("asset_test"));
    expect(marketMetadata.broker, equals("broker_test"));
    expect(marketMetadata.intervalInSeconds, equals(1500));
    expect(marketMetadata.dateRange, equals(dateTimeRangeA));
  });
}
