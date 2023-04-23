// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:labelling/chart_controller.dart';
import 'package:labelling/chart_presenter.dart';
import 'package:labelling/conditionnal_chart_view.dart';
import 'package:labelling/error_screen.dart';
import 'package:labelling/fragment/resolver/fragment_single_panel_resolver.dart';
import 'package:labelling/loading_screen.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/no_data_screen.dart';
import 'package:labelling/services/chart_service.dart';
import 'package:labelling/toolbar/toolbar.dart';
import 'package:logging/logging.dart';

/// TODO: Add ChartLayer. A chart layer automate all the process of getting the data 
/// update on change, and create a fragment
/// ChartLayer has a SourceOfChanges that is a list of observables.
/// when the observable notify the layer is updated
/// 
/// ChartLayer has a model that allow to query data required to do a request on the server
/// 
/// ChartLayer use the GrphQL query module to get the result of the processing work

// ignore: non_constant_identifier_names
String APP_PROFIL = "dev";

void main() {
  runApp(const Labeller());
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  // Logger.root.onRecord.listen((record) {
  // debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  // });
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
  final chartService = ChartService.initWithDefault();

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
            chartService: chartService,
            child: ConditionnalChartView(
                key: key,
                chartModel: chartModel,
                noData: const NoDataWidget(),
                loading: const LoadingScreen(),
                error: ErrorScreen(chartStateModel: chartModel.stateModel),
                onData: ChartPresenter(
                  fragmentModel: chartModel.fragmentModel,
                  fragmentResolver:
                      SinglePanelResolser(chartService.referenceRepository),
                ))),
      )
    ]));
  }
}
