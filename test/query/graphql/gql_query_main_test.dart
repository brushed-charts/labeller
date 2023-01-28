import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/query/graphql/gql_price_query_maker.dart';
import 'package:labelling/query/graphql/gql_query_main.dart';
import 'package:labelling/query/market_query_contract.dart';
import 'package:mocktail/mocktail.dart';

class MockGQLPriceQueryMaker extends Mock implements GQLPriceQueryMaker {}

class MockGQLClient extends Mock implements GraphQLClient {}

void main() {
  late GraphQLClient mockClient;
  const mockPriceQueryMaker = GQLPriceQueryMaker();

  setUp(() {
    mockClient = MockGQLClient();
  });

  test("Expect graphql market client to have link to graphQL server", () {
    final gqlQuery = GQLQuery.initWithDefaultValue();
    final queryAddress = (gqlQuery.gqlClient.link as HttpLink).uri.toString();
    expect(queryAddress, equals('http://graphql.brushed-charts.com'));
  });

  test("Test graphql query use gql price object to query price", () {
    // final MarketQuery marketQuery = GQLQuery(gqlClient: mockClient,
    // priceQueryMaker: mockPriceQueryMaker);
    // final price = await marketQuery.getJsonPrice(metadata);
  });
}
