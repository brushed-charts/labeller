import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/conditionnal_chart_view.dart';
import 'package:labelling/loading_screen.dart';
import 'package:labelling/no_data_screen.dart';
import 'package:labelling/toolbar/toolbar.dart';

import 'chart.dart';

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
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      ToolBar(key: key),
      Expanded(
          child: ConditionnalChartView(
        key: key,
        noData: const NoDataWidget(),
        loading: const LoadingScreen(),
        error: Container(),
        onData: Container(),
      ))
    ]));
  }
}

    // ], child: Column(children: [ToolBar(key: key), const Chart()])));