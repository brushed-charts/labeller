import 'package:flutter/material.dart';
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
      home: const MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [ToolBar(key: key), const Expanded(child: Chart())]));
  }
}

    // ], child: Column(children: [ToolBar(key: key), const Chart()])));