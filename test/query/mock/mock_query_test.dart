
import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/mock/mock_query.dart';

class FakeMarketMetadata extends Fake implements MarketMetadata {}

void main() {
  test("Assert mockQuery return the price", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final query = MockQuery();
    final jsonPrice = await query.getJsonPrice(FakeMarketMetadata());
    expect(jsonPrice, isNotNull);
    expect(jsonPrice, isInstanceOf<Map<String, dynamic>>());

    expect(jsonPrice?['oanda'][0].keys,
        containsAll(['datetime', 'timestamp', 'uniform_volume', 'price']));
  });
}
