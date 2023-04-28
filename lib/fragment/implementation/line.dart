import 'package:grapher/drawUnit/drawunit.dart';
import 'package:grapher/factory/factory.dart';
import 'package:grapher/filter/data-injector.dart';
import 'package:grapher/filter/incoming-data.dart';
import 'package:grapher/filter/json/explode.dart';
import 'package:grapher/filter/json/extract.dart';
import 'package:grapher/filter/json/to-point2D.dart';
import 'package:grapher/geometry/line.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/pack/unpack-view.dart';
import 'package:grapher/pipe/pipeIn.dart';
import 'package:grapher/subgraph/subgraph-kernel.dart';
import 'package:grapher/tag/tag.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/grapherExtension/block_same_map.dart';
import 'package:labelling/utils/map_to_stream.dart';

class LineFragment implements FragmentInterface {
  LineFragment(this.name, this.rootName, Map<String, dynamic>? data)
      : id = '${rootName}_$name' {
    if (data == null) return;
    parser = createParser(data);
    visualisation = createVisual();
  }

  @override
  GraphObject? interaction, parser, visualisation;
  @override
  final String name;
  @override
  final String id;
  @override
  final String rootName;

  GraphObject createParser(Map jsonInput) {
    return SubGraphKernel(
        child: DataInjector(
            stream: mapToStream(jsonInput),
            child: BlockAlreadyReceivedMap(
                id: name,
                child: Extract(
                    options: name,
                    child: Explode(
                        child: ToPoint2D(
                            xLabel: "datetime",
                            yLabel: "value",
                            child: Tag(
                                name: name,
                                child: PipeIn(
                                    eventType: IncomingData,
                                    name: 'pipe_main_$rootName'))))))));
  }

  GraphObject createVisual() {
    return SubGraphKernel(
        child: UnpackFromViewEvent(
            tagName: name,
            child:
                DrawUnitFactory(template: DrawUnit.template(child: Line()))));
  }
}
