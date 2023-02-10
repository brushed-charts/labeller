import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/conditionnal_chart_view.dart';
import 'package:labelling/loading_screen.dart';
import 'package:labelling/no_data_screen.dart';
=======
import 'package:labelling/chart_controller.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/query/graphql/gql_query.dart';
>>>>>>> observer_subscriber
import 'package:labelling/toolbar/toolbar.dart';

void main() {
  runApp(const ProviderScope(child: Labeller()));
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
  final chartModel = ChartModel.initWithDefault();

  MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    chartModel.marketMetadataModel.refresh();
    return Scaffold(
        body: Column(children: [
      ToolBar(key: key, model: chartModel),
      Expanded(
          child: ChartController(
        chartModel: chartModel,
        marketQuery: GQLQuery.initWithDefaultValue(),
        child: Chart(),
      ))
    ]));
  }
}

    // ], child: Column(children: [ToolBar(key: key), const Chart()])));