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
  CandleFragment(this.name, this._broker, Map<String, dynamic>? data) {
    if (data == null) return;
    parser = createParser(data);
    visualisation = createVisual();
  }

  @override
  GraphObject? interaction, parser, visualisation;
  @override
  final String name;
  final String _broker;

  GraphObject createParser(Map<String, dynamic> jsonInput) {
    return SubGraphKernel(
        child: DataInjector(
            stream: mapToStream(jsonInput),
            child: BlockAlreadyReceivedMap(
                id: 'price',
                child: Extract(
                    options: _broker,
                    child: Explode(
                        child: ToCandle2D(
                            xLabel: "datetime",
                            yLabel: "price",
                            child: Tag(
                                name: '${_broker}_price',
                                child: PipeIn(
                                    eventType: IncomingData,
                                    name: 'pipe_main'))))))));
  }

  GraphObject createVisual() {
    return SubGraphKernel(
        child: UnpackFromViewEvent(
            tagName: '${_broker}_price',
            child: DrawUnitFactory(
                template: DrawUnit.template(child: Candlestick()))));
  }
}
