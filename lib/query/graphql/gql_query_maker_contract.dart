import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/query/market_metadata.dart';

abstract class GQLQueryMaker {
  QueryOptions build(String query, Map<String, dynamic> variables);
  Map<String, dynamic> makeVariables(MarketMetadata metadata);
  String makeQueryBody(MarketMetadata metadata);
}
