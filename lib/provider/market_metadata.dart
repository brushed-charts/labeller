import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/model/date_range_model.dart';
import 'package:labelling/model/interval_model.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/model/source_model.dart';

final marketMetadataProvider = StateProvider<MarketMetadata>((ref) {
  final sourceModel = ref.watch(sourceModelProvider.notifier);
  final intervalModel = ref.watch(intervalModelProvider.notifier);
  final dateRangeModel = ref.watch(dateRangeProvider.notifier);
  return MarketMetadata(sourceModel.broker, sourceModel.assetPair,
      intervalModel.intervalToSeconds, dateRangeModel.getDateRange);
});
