import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/model/interval_model.dart';

class IntervalSelector extends ConsumerStatefulWidget {
  const IntervalSelector({Key? key}) : super(key: key);

  @override
  IntervalSelectorState createState() => IntervalSelectorState();
}

class IntervalSelectorState extends ConsumerState<IntervalSelector> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        onChanged: _onInterval,
        value: ref.watch(intervalModelProvider),
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
    final intervalModel = ref.read(intervalModelProvider.notifier);
    intervalModel.setInterval(interval);
    intervalModel.save();
  }
}
