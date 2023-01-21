import 'package:flutter/material.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/toolbar/toolbar.dart';

import 'chart.dart';

void main() {
  runApp(Labeller());
}

class Labeller extends StatelessWidget {
  Labeller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Labeller',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  final chartModel = ChartModel();

  MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      ToolBar(key: key, model: chartModel),
      const Expanded(child: Chart())
    ]));
  }
}

    // ], child: Column(children: [ToolBar(key: key), const Chart()])));