import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/query/graphql/gql_query_builder.dart';
import 'package:labelling/query/market_metadata.dart';

class GQLPriceQueryMaker implements GQLQueryBuilder {
  GQLPriceQueryMaker(this.metadata);

  final MarketMetadata metadata;
  final String _templateQuery = """
  query(\$sourceSelector: SourceSelector!) {
    {{alias}}: ohlc_price(sourceSelector:\$sourceSelector){
      datetime
      timestamp
      uniform_volume
      price {
          open
          high
          low
          close
      }
    }
}
""";

  @override
  QueryOptions build(String query, Map<String, dynamic> variables) {
    return QueryOptions(document: gql(query), variables: variables);
  }

  @override
  String makeQueryBody() {
    final queryWithAliasName =
        _templateQuery.replaceAll('{{alias}}', metadata.broker);
    return queryWithAliasName;
  }

  @override
  Map<String, dynamic> makeVariables() {
    return {
      "sourceSelector": {
        "dateFrom": metadata.dateRange.start,
        "dateTo": metadata.dateRange.end,
        "asset": metadata.assetPairs.toUpperCase(),
        "source": metadata.broker.toUpperCase(),
        "granularity": metadata.intervalInSeconds,
      }
    };
  }
}
