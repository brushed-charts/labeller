import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/graphql/template.dart';
import 'package:labelling/services/source.dart';

class PriceFetcher with GQLTemplate {
  final String templateQuery = """
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

  QueryOptions build() {
    final query = prepareQuery(SourceService.broker!);
    final vars = makeVariables();
    return QueryOptions(document: gql(query), variables: vars);
  }

  String prepareQuery(String broker) {
    final queryWithAliasName = templateQuery.replaceAll('{{alias}}', broker);
    return queryWithAliasName;
  }

  Map<String, dynamic> makeVariables() {
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
