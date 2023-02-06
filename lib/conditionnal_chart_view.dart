import 'package:flutter/widgets.dart';
import 'package:labelling/model/market_metadata_model.dart';

enum ChartViewState { noData, loading, error, onData }

class ConditionnalChartView extends StatelessWidget {
  final Widget? onData;
  final Widget noData;
  final Widget? loading;
  final Widget? error;

  const ConditionnalChartView({
    this.onData,
    required this.noData,
    this.loading,
    this.error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return noData;
    // switch (ref.watch(chartViewStateProvider)) {
    //   case value:
    //     break;
    //   default:
    // }
  }
}
