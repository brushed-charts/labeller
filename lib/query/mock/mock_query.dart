import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/market_query_contract.dart';

class MockQuery implements MarketQuery {
  @override
  Future<Map<String, dynamic>?> getJsonPrice(MarketMetadata metadata) async {
    final ohlcvSource =
        await rootBundle.loadString('assets/mock/oanda_ohlcv.json');
    return jsonDecode(ohlcvSource);
  }
}
