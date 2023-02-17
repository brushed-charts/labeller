import 'package:flutter/widgets.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/model/chart_state.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';

class ConditionnalChartView extends StatefulWidget {
  const ConditionnalChartView({
    required this.chartModel,
    required this.noData,
    required this.onData,
    required this.loading,
    required this.error,
    Key? key,
  }) : super(key: key);

  final Widget onData;
  final Widget noData;
  final Widget loading;
  final Widget error;
  final ChartModel chartModel;

  @override
  State<StatefulWidget> createState() {
    return ConditionnalChartViewState();
  }
}

class ConditionnalChartViewState extends State<ConditionnalChartView>
    implements Observer {
  @override
  void initState() {
    widget.chartModel.stateModel.subscribe(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.chartModel.stateModel.state) {
      case ChartViewState.noData:
        return widget.noData;
      case ChartViewState.loading:
        return widget.loading;
      case ChartViewState.error:
        return widget.error;
      case ChartViewState.onData:
        return widget.onData;
      default:
        throw ArgumentError("Chart model state have an invalid view state");
    }
  }

  @override
  void onObservableEvent(Observable observable) {
    if (observable is! ChartStateModel) return;
    setState(() {
      /* Refresh on observable event */
    });
  }
}
