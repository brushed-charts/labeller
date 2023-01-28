import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/query/graphql/gql_query_builder.dart';
import 'package:labelling/services/source.dart';

class GQLPriceQueryMaker implements GQLQueryBuilder {
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
  QueryOptions build() {
    final query = _prepareQuery(SourceService.broker!);
    final vars = _makeVariables();
    return QueryOptions(document: gql(query), variables: vars);
  }

  String _prepareQuery(String broker) {
    final queryWithAliasName = _templateQuery.replaceAll('{{alias}}', broker);
    return queryWithAliasName;
  }

  Map<String, dynamic> _makeVariables() {
    return {
      "sourceSelector": {
        "dateFrom": SourceService.dateFrom,
        "dateTo": SourceService.dateTo,
        "asset": SourceService.asset?.toUpperCase(),
        "granularity": SourceService.intervalToSeconds,
        "source": SourceService.broker!.toLowerCase()
      }
    };
  }
}
