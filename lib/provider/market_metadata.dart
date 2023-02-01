import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package'

final marketMetadataProvider = StateProvider<MarketMetadata>((ref) {
  final sourceModel = ref.watch(sourceModelProvider);
  MarketMetadata()
});
