import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/query/graphql/gql_price_query_maker.dart';
import 'package:labelling/query/market_metadata.dart';

void main() {
  test("GQL Price query maker vars are conform to input", () {

  });
  test("GQL Price query maker have the broker name in the query body", () {
    final marketMetadata = MarketMetadata(source, interval, range)
    final query = GQLPriceQueryMaker(marketMetadata).build();
    expect(query.document.toString(), contains(broker))
  });
}
