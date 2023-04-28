import 'package:grapher/drawUnit/drawunit.dart';
import 'package:grapher/factory/factory.dart';
import 'package:grapher/filter/data-injector.dart';
import 'package:grapher/filter/incoming-data.dart';
import 'package:grapher/filter/json/explode.dart';
import 'package:grapher/filter/json/extract.dart';
import 'package:grapher/filter/json/to-candle2D.dart';
import 'package:grapher/geometry/candlestick.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/pack/unpack-view.dart';
import 'package:grapher/pipe/pipeIn.dart';
import 'package:grapher/subgraph/subgraph-kernel.dart';
import 'package:grapher/tag/tag.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/grapherExtension/block_same_map.dart';
import 'package:labelling/utils/map_to_stream.dart';

class CandleFragment implements FragmentInterface {
  CandleFragment(
      {required this.rootName,
      required String broker,
      required Map<String, dynamic>? data})
      : _broker = broker,
        name = NAME,
        id = '${broker}_$NAME' {
    if (data == null) return;
    parser = createParser(data);
    visualisation = createVisual();
  }

  // ignore: constant_identifier_names
  static const String NAME = 'candle';

  @override
  GraphObject? interaction, parser, visualisation;
  final String _broker;
  @override
  final String name;
  @override
  final String id;
  @override
  final String rootName;

  GraphObject createParser(Map<String, dynamic> jsonInput) {
    return SubGraphKernel(
        child: DataInjector(
            stream: mapToStream(jsonInput),
            child: BlockAlreadyReceivedMap(
                id: id,
                child: Extract(
                    options: _broker,
                    child: Explode(
                        child: ToCandle2D(
                            xLabel: "datetime",
                            yLabel: "price",
                            child: Tag(
                                name: id,
                                child: PipeIn(
                                    eventType: IncomingData,
                                    name: 'pipe_main_$rootName'))))))));
  }

  GraphObject createVisual() {
    return SubGraphKernel(
        child: UnpackFromViewEvent(
            tagName: id,
            child: DrawUnitFactory(
                template: DrawUnit.template(child: Candlestick()))));
  }
}
