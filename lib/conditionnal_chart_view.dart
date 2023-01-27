import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/model/date_range_model.dart';
import 'package:labelling/model/interval_model.dart';
import 'package:labelling/model/source_model.dart';

enum ChartViewState { noData, loading, error, onData }

final isChartMetadataReady = Provider<bool>((ref) {
  final source = ref.read(sourceModelProvider.notifier);
  final interval = ref.read(intervalModelProvider.notifier);
  final dateRange = ref.read(dateRangeProvider.notifier);
  if (!source.isLoaded || !interval.isLoaded || !dateRange.isLoaded) {
    return false;
  }
  return true;
});

final chartViewStateProvider = Provider((ref) {
  final isModelsLoaded = ref.watch(isChartMetadataReady);
  if (!isModelsLoaded) return ChartViewState.noData;
  return ChartViewState.loading;
});

class ConditionnalChartView extends ConsumerWidget {
  final Widget? onData;
  final Widget noData;
  final Widget? loading;
  final Widget? error;

  const ConditionnalChartView({
    this.onData,
    required this.noData,
    this.loading,
    this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return noData;
  }
}
