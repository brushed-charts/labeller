import 'market_metadata.dart';

abstract class MarketQuery {
  Future<Map<String, dynamic>> getJsonPrice(MarketMetadata metadata);
}
