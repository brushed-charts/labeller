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
import 'package:labelling/fragment/base.dart';
import 'package:labelling/grapherExtension/block_same_map.dart';
import 'package:labelling/services/source.dart';
import 'package:labelling/utils/map_to_stream.dart';

class CandleFragment implements FragmentContract {
  @override
  GraphObject? interaction, parser, visualisation;

  @override
  CandleFragment(Map<String, dynamic>? data) {
    if (data == null) return;
    parser = createParser(data);
    visualisation = createVisual();
  }

  GraphObject createParser(Map jsonInput) {
    return SubGraphKernel(
        child: DataInjector(
            stream: mapToStream(jsonInput),
            child: BlockAlreadyReceivedMap(
                id: 'price',
                child: Extract(
                    options: SourceService.broker!,
                    child: Explode(
                        child: ToCandle2D(
                            xLabel: "datetime",
                            yLabel: "price",
                            child: Tag(
                                name: '${SourceService.broker!}_price',
                                child: PipeIn(
                                    eventType: IncomingData,
                                    name: 'pipe_main'))))))));
  }

  GraphObject createVisual() {
    return SubGraphKernel(
        child: UnpackFromViewEvent(
            tagName: '${SourceService.broker!}_price',
            child: DrawUnitFactory(
                template: DrawUnit.template(child: Candlestick()))));
  }
}
