import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/graphql/template.dart';

class GraphqlService {
  static final _client = GraphQLClient(
    link: HttpLink('http://graphql.brushed-charts.com'),
    cache: GraphQLCache(store: InMemoryStore()),
  );

  static Future<dynamic> fetch(GQLTemplate template) async {
    final queryOptions = template.build();
    final queryResult = await _client.query(queryOptions);
    return queryResult.data;
  }
}
