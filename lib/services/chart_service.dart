import 'package:labelling/query/graphql/gql_query.dart';
import 'package:labelling/query/market_query_contract.dart';

class ChartService {
  ChartService({required this.marketQuery});

  final MarketQuery marketQuery;

  factory ChartService.initWithDefault() {
    return ChartService(marketQuery: GQLQuery.initWithDefaultValue());
  }
}
