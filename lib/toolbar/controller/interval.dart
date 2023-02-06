import 'package:flutter/material.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';

class IntervalSelector extends StatefulWidget {
  const IntervalSelector({required this.chartModel, Key? key})
      : super(key: key);

  final ChartModel chartModel;

  @override
  State<StatefulWidget> createState() => _IntervalSelector();
}

class _IntervalSelector extends State<IntervalSelector> implements Observer {
  @override
  void initState() {
    widget.chartModel.marketMetadataModel.subscribe(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        onChanged: _onInterval,
        value: widget.chartModel.marketMetadataModel.interval,
        items: <String>[
          '1s',
          '2s',
          '5s',
          '1m',
          '2m',
          '5m',
          '10m',
          '15m',
          '30m',
          '45m',
          '1h',
          '2h',
          '4h',
          '1d',
          '1w',
          '1M',
          '1y'
        ]
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList());
  }

  void _onInterval(String? interval) {
    if (interval == null) return;
    widget.chartModel.marketMetadataModel.interval = interval;
    widget.chartModel.marketMetadataModel.save();
    // print(widget.chartModel.sourceModel.interval);
  }

  @override
  void onObservableEvent(Observable observable) {
    setState(() {/* source model have changed */});
  }
}
