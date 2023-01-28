import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/market_query_contract.dart';

class GraphQLQuery implements MarketQuery {
  GraphQLQuery({required this.gqlClient});

  final GraphQLClient gqlClient;

  factory GraphQLQuery.initWithDefaultValue() {
    final client = GraphQLClient(
      link: HttpLink('http://graphql.brushed-charts.com'),
      cache: GraphQLCache(store: InMemoryStore()),
    );
    return GraphQLQuery(gqlClient: client);
  }

  @override
  Map<String, dynamic> getJsonPrice(MarketMetadata metadata) {
    throw UnimplementedError();
  }
}
