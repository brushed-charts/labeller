import 'package:graphql_flutter/graphql_flutter.dart';

abstract class GQLQueryBuilder {
  QueryOptions build(String query, Map<String, dynamic> variables);
  Map<String, dynamic> makeVariables();
  String makeQueryBody();
}
