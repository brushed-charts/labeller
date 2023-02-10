import 'package:flutter/material.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';

class IntervalSelector extends StatefulWidget {
  const IntervalSelector({required this.marketMetadataModel, Key? key})
      : super(key: key);

  final MarketMetadataModel marketMetadataModel;

  @override
  IntervalSelectorState createState() => IntervalSelectorState();
}

class _IntervalSelector extends State<IntervalSelector> implements Observer {
  @override
  void initState() {
    widget.marketMetadataModel.subscribe(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(intervalModelProvider.notifier).refresh();
    return DropdownButton<String>(
        onChanged: _onInterval,
        value: widget.marketMetadataModel.interval,
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
<<<<<<< HEAD
    final intervalModel = ref.read(intervalModelProvider.notifier);
    intervalModel.setInterval(interval);
    intervalModel.save();
=======
    widget.marketMetadataModel.interval = interval;
    widget.marketMetadataModel.save();
  }

  @override
  void onObservableEvent(Observable observable) {
    setState(() {/* source model have changed */});
>>>>>>> observer_subscriber
  }
}
