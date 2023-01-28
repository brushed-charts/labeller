import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/query/market_metadata.dart';
import 'package:labelling/query/market_query_contract.dart';

class GQLQuery implements MarketQuery {
  GQLQuery({required this.gqlClient});

  final GraphQLClient gqlClient;

  factory GQLQuery.initWithDefaultValue() {
    final client = GraphQLClient(
      link: HttpLink('http://graphql.brushed-charts.com'),
      cache: GraphQLCache(store: InMemoryStore()),
    );
    return GQLQuery(gqlClient: client);
  }

  @override
  Future<Map<String, dynamic>> getJsonPrice(MarketMetadata metadata) async {
    return Future(() => <String, dynamic>{});
  }
}
