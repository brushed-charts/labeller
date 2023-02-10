import 'package:grapher/filter/base.dart';
import 'package:grapher/filter/incoming-data.dart';
import 'package:grapher/kernel/object.dart';
import 'package:labelling/services/cache.dart';

class BlockAlreadyReceivedMap extends Filter {
  static const baseCacheKey = 'graph_cache_last_received_map_hashcode';
  final String id;
  final String cacheKey;

  BlockAlreadyReceivedMap({required this.id, GraphObject? child})
      : cacheKey = '${baseCacheKey}_$id',
        super(child);

  @override
  void onIncomingData(IncomingData input) {
    if (input.content is! Map) return;
    final inputData = input.content as Map;
    int? lastInputHashCode = CacheService.load(cacheKey);
    if (lastInputHashCode == inputData.hashCode) return;
    CacheService.save(cacheKey, inputData.hashCode);
    propagate(input);
  }
}
