import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconSize: 30,
        icon: Icon(Icons.functions_sharp,
            color: Theme.of(context).buttonTheme.colorScheme?.primary),
        onSelected: (String selection) => onSelected(context, selection),
        itemBuilder: (context) => [
              const PopupMenuItem(value: 'MA', child: Text('MA')),
              const PopupMenuItem(value: 'EMA', child: Text('EMA')),
              const PopupMenuItem(value: 'RSI', child: Text('RSI')),
              const PopupMenuItem(value: 'MACD', child: Text('MACD')),
              const PopupMenuItem(value: 'Volume', child: Text('Volume')),
              const PopupMenuItem(
                  value: 'Stochastic', child: Text('Stochastic')),
            ]);
  }

  void onSelected(BuildContext context, String name) {
    // final fragModel = context.read<FragmentModel>();
    // fragModel.add(name);
  }
}
