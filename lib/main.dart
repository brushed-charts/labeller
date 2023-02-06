import 'package:flutter/material.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/toolbar/toolbar.dart';

import 'chart.dart';

void main() {
  runApp(const Labeller());
}

class Labeller extends StatelessWidget {
  const Labeller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Labeller',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      home: MainView(key: key),
    );
  }
}

class MainView extends StatelessWidget {
  final chartModel = ChartModel();

  MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: chartModel.marketMetadataModel.refresh().then((_) => true),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).progressIndicatorTheme.color,
                )));
          }
          return Scaffold(
              body: Column(children: [
            ToolBar(key: key, model: chartModel),
            const Expanded(child: Chart())
          ]));
        });
  }
}

    // ], child: Column(children: [ToolBar(key: key), const Chart()])));