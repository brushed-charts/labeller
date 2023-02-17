import 'package:grapher/reference/contract.dart';
import 'package:grapher/reference/memory_repository.dart';
import 'package:labelling/query/graphql/gql_query.dart';
import 'package:labelling/query/market_query_contract.dart';

class ChartService {
  ChartService({required this.marketQuery, required this.referenceRepository});

  final MarketQuery marketQuery;
  final ReferenceRepositoryInterface referenceRepository;

  factory ChartService.initWithDefault() {
    return ChartService(
        marketQuery: GQLQuery.initWithDefaultValue(),
        referenceRepository: ReferenceRepositoryInMemory());
  }
}
