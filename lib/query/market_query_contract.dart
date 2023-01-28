import 'package:labelling/query/market_metadata.dart';

abstract class MarketQuery {
  Map<String, dynamic> getJsonPrice(MarketMetadata metadata);
}
