import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/query/graphql/graphql_query.dart';

void main() {
  test("Expect graphql market client to have link to graphQL server", () {
    final gqlQuery = GraphQLQuery.initWithDefaultValue();
    final queryAddress = (gqlQuery.gqlClient.link as HttpLink).uri.toString();
    expect(queryAddress, equals('http://graphql.brushed-charts.com'));
  });

  test("Test graphql query use gql price object to make the query", () {
    // expect(, matcher)
  });
}
