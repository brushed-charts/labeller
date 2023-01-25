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
  final source = ref.watch(sourceModelProvider);
  final interval = ref.watch(intervalModelProvider);
  final dateRange = ref.watch(dateRangeProvider);
});

class ConditionnalChartView extends ConsumerWidget {
  const ConditionnalChartView({
    required Widget onData,
    Widget? noData,
    Widget? loading,
    Widget? error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}
