import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/query/graphql/gql_price_query.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/market_query_contract.dart';

class GQLQuery implements MarketQuery {
  GQLQuery({required this.gqlClient, required this.priceQuery});

  final GraphQLClient gqlClient;
  final GQLPriceQuery priceQuery;

  factory GQLQuery.initWithDefaultValue() {
    final client = GraphQLClient(
      link: HttpLink('http://graphql.brushed-charts.com'),
      cache: GraphQLCache(store: InMemoryStore()),
    );
    return GQLQuery(gqlClient: client, priceQuery: const GQLPriceQuery());
  }

  @override
  Future<Map<String, dynamic>?> getJsonPrice(MarketMetadata metadata) async {
    final body = priceQuery.makeQueryBody(metadata);
    final variables = priceQuery.makeVariables(metadata);
    final queryOptions = priceQuery.build(body, variables);
    final queryResult = await gqlClient.query(queryOptions);
    return queryResult.data;
  }
}
