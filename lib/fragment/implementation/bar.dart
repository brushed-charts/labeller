import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grapher/drawUnit/drawunit.dart';
import 'package:grapher/factory/factory.dart';
import 'package:grapher/filter/data-injector.dart';
import 'package:grapher/filter/incoming-data.dart';
import 'package:grapher/filter/json/explode.dart';
import 'package:grapher/filter/json/extract.dart';
import 'package:grapher/filter/json/to-point2D.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/pack/unpack-view.dart';
import 'package:grapher/pipe/pipeIn.dart';
import 'package:grapher/subgraph/subgraph-kernel.dart';
import 'package:grapher/tag/property.dart';
import 'package:grapher/tag/tag.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/grapherExtension/block_same_map.dart';
import 'package:labelling/utils/map_to_stream.dart';
import 'package:grapher/geometry/barchart.dart';

class BarFragment implements FragmentInterface {
  BarFragment(
      this.name, this.rootName, this._broker, Map<String, dynamic>? data)
      : id = '${_broker}_$name' {
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
  final String _broker;

  GraphObject createParser(Map<String, dynamic> jsonInput) {
    return SubGraphKernel(
        child: DataInjector(
            stream: mapToStream(jsonInput),
            child: BlockAlreadyReceivedMap(
                id: id,
                child: Extract(
                    options: _broker,
                    child: Explode(
                        child: ToPoint2D(
                            xLabel: "datetime",
                            yLabel: "value",
                            child: Tag(
                                name: id,
                                property: TagProperty.neutralRange,
                                child: PipeIn(
                                    eventType: IncomingData,
                                    name: 'pipe_main_$rootName'))))))));
  }

  GraphObject createVisual() {
    return SubGraphKernel(
        child: UnpackFromViewEvent(
            tagName: id,
            child: DrawUnitFactory(
                template: DrawUnit.template(
                    child: BarChart(
                        paint: Paint()
                          ..color =
                              const Color.fromARGB(131, 224, 138, 32))))));
  }
}
