import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/query/graphql/gql_query.dart';
import 'package:labelling/query/market_query_contract.dart';

final marketQueryService = Provider<MarketQuery>(
    (ref) => GQLQuery.initWithDefaultValue() as MarketQuery);

class MarketQuery extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
