import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grapher/kernel/kernel.dart';
import 'package:grapher/kernel/widget.dart';
import 'package:grapher/interaction/widget.dart';
import 'package:labelling/fragment/concat.dart';
import 'package:labelling/fragment/candle.dart';
import 'package:labelling/fragment/volume.dart';
import 'package:labelling/grapherExtension/axed_graph.dart';
import 'package:labelling/grapherExtension/centered_text.dart';
import 'package:labelling/grapherExtension/fragment_to_graph_object.dart';
import 'package:labelling/graphql/mock_price.dart';
import 'package:labelling/linkHub/consumer_interface.dart';
import 'package:labelling/linkHub/event.dart';
import 'package:labelling/linkHub/main.dart';
import 'package:labelling/services/appmode.dart';
import 'package:labelling/services/source.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> implements HubConsumer {
  var currentGraph = noDataScreen();

  @override
  void initState() {
    LinkHub.subscribe(SourceService.sourceChangedChannel, this);
    LinkHub.subscribe(AppModeService.channel, this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return currentGraph;
  }

  Future<void> getAppropriateView() async {
    setState(() => currentGraph = loadingScreen());
    try {
      // final jsonPrice = await GraphqlService.fetch(PriceFetcher());
      // print(jsonPrice);
      final jsonPrice = await GQLMockPrice().fetch();
      setState(() => currentGraph = priceWidget(jsonPrice));
    } catch (e) {
      setState(() => currentGraph = errorScreen());
    }
  }

  static Widget noDataScreen() {
    return Graph(
        key: UniqueKey(),
        kernel: GraphKernel(child: CenteredText('There is no data')));
  }

  static Widget loadingScreen() {
    return Graph(
        key: UniqueKey(),
        kernel: GraphKernel(child: CenteredText('Loading... Please wait')));
  }

  static Widget errorScreen() {
    return Graph(
        key: UniqueKey(),
        kernel: GraphKernel(
            child: CenteredText('There is an error during the loading')));
  }

  static Widget priceWidget(Map<String, dynamic> jsonInput) {
    return GraphFullInteraction(
        kernel: GraphKernel(
            child: AxedGraph(
                graph: FragmentToGraphObject(
                    fragment: ConcatFragments(children: [
      CandleFragment(jsonInput),
      VolumeFragment(jsonInput),
    ])))));
  }

  @override
  Future handleHubEvent(HubEvent event) async {
    await getAppropriateView();
  }
}
