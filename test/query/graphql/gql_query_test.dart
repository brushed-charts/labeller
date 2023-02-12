import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/query/graphql/gql_price_query.dart';
import 'package:labelling/query/graphql/gql_query.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/market_query_contract.dart';
import 'package:mocktail/mocktail.dart';

class MockGQLClient extends Mock implements GraphQLClient {}

class MockQueryOptions extends Mock implements QueryOptions {}

class MockQueryResult extends Mock implements QueryResult {
  @override
  bool get hasException => false;
}

class FakeGQLPriceQuery extends Fake implements GQLPriceQuery {
  var isBuildMethodeCalled = false;

  @override
  QueryOptions<Object?> build(String query, Map<String, dynamic> variables) {
    isBuildMethodeCalled = true;
    return QueryOptions(document: gql(""), variables: const {});
  }

  @override
  String makeQueryBody(MarketMetadata metadata) => "";

  @override
  Map<String, dynamic> makeVariables(MarketMetadata metadata) => {};
}

void main() {
  late GraphQLClient mockClient;
  final mockQueryOptions = MockQueryOptions();
  final mockQueryResult = MockQueryResult();
  final datetimeRange = DateTimeRange(
      start: DateTime.utc(2023, 01, 24, 11, 52),
      end: DateTime.utc(2023, 01, 28, 18, 31));
  final metadata = MarketMetadata("BROKER", "ASSET", 15 * 60, datetimeRange);
  final mockOutputMap = {"a key": "a_value"};
  registerFallbackValue(metadata);
  registerFallbackValue(mockQueryOptions);

  setUp(() {
    mockClient = MockGQLClient();
    when(() => mockClient.query(any()))
        .thenAnswer((_) => Future(() => mockQueryResult));
    when(() => mockQueryResult.data).thenReturn(mockOutputMap);
  });

  test("Expect graphql market client to have link to graphQL server", () {
    final gqlQuery = GQLQuery.initWithDefaultValue();
    final queryAddress = (gqlQuery.gqlClient.link as HttpLink).uri.toString();
    expect(queryAddress, equals('http://graphql.brushed-charts.com'));
  });

  test(
      "Proof that graphQL json price return data from the query result "
      "and use graphQL query maker object in input to build the query",
      () async {
    final fakePriceQuery = FakeGQLPriceQuery();
    final MarketQuery marketQuery = GQLQuery(
      gqlClient: mockClient,
      priceQuery: fakePriceQuery,
    );
    final result = await marketQuery.getJsonPrice(metadata);
    expect(result, equals(mockOutputMap));
    expect(fakePriceQuery.isBuildMethodeCalled, isTrue);
  });
}
