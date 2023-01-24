import 'package:firestore_figure_database/context.dart';
import 'package:firestore_figure_database/initializator.dart';
import 'package:firestore_figure_database/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grapher/reference/memory_repository.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:grapher_user_draw/figure_database_interface.dart';
import 'package:grapher_user_draw/store.dart';
import 'package:labelling/drawTools/head_and_shoulders.dart';
import 'package:labelling/figure_converter_with_tool_guess.dart';
import 'package:labelling/fragment/candle.dart';
import 'package:labelling/fragment/figure.dart';
import 'package:labelling/graph_view.dart';
import 'package:labelling/graphql/mock_close.dart';
import 'package:labelling/graphql/mock_price.dart';
import 'package:labelling/linkHub/consumer_interface.dart';
import 'package:labelling/linkHub/event.dart';
import 'package:labelling/linkHub/main.dart';
import 'package:labelling/services/appmode.dart';
import 'package:labelling/services/cache.dart';
import 'package:labelling/services/source.dart';

import 'fragment/line.dart';
import 'fragment/volume.dart';

class Chart extends ConsumerStatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  ConsumerState<Chart> createState() => _ChartState();
}

class _ChartState extends ConsumerState<Chart> implements HubConsumer {
  var currentGraph = GraphViewBuilder().noDataScreen();
  final _figureStore = FigureStore();
  final _referenceRepository = ReferenceRepositoryInMemory();
  FigureDatabaseInterface? _figureDatabase;
  FigureFragment? _figureFragment;

  @override
  void initState() {
    LinkHub.subscribe(SourceService.sourceChangedChannel, this);
    LinkHub.subscribe(AppModeService.channel, this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<void> getAppropriateView() async {
    setState(() => currentGraph = GraphViewBuilder().loadingScreen());
    try {
      // final jsonPrice = CacheService.load('price') ??
      //     await GraphqlService.fetch(PriceFetcher());
      final jsonPrice =
          CacheService.load('price') ?? await GQLMockPrice().fetch();
      CacheService.save('price', jsonPrice);

      final jsonMA =
          CacheService.load('price_close') ?? await GQLMockPriceClose().fetch();
      CacheService.save('price_close', jsonMA);

      final figureContext =
          FigureContext(SourceService.asset!, SourceService.broker!);

      final firestoreInstance = await FirestoreInit.getEmulatorInstance();
      _figureDatabase = FirestoreFigureDatabase(
          firestoreInstance, FigureConverterWithToolGuess(), figureContext);

      _figureFragment =
          FigureFragment(_figureStore, _referenceRepository, _figureDatabase!);

      setState(() =>
          currentGraph = GraphViewBuilder().priceWidget(_referenceRepository, [
            CandleFragment(jsonPrice),
            VolumeFragment(jsonPrice),
            LineFragment('price_close', jsonMA),
            _figureFragment!
          ]));
    } catch (e) {
      setState(() => currentGraph = GraphViewBuilder().errorScreen());
    }
  }

  @override
  Future<void> handleHubEvent(HubEvent event) async {
    switch (event.channel) {
      case SourceService.sourceChangedChannel:
        await getAppropriateView();
        break;
      case AppModeService.channel:
        _figureFragment?.drawTool = getDrawToolByAppMode();
        break;
    }
  }

  DrawToolInterface? getDrawToolByAppMode() {
    switch (AppModeService.mode) {
      case AppMode.headAndShoulders:
        return HeadAndShouldersDrawTool();
      default:
        return null;
    }
  }
}
