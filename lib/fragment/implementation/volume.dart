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
import 'package:grapher/utils/y-virtual-range.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/grapherExtension/block_same_map.dart';
import 'package:labelling/services/source.dart';
import 'package:labelling/utils/map_to_stream.dart';
import 'package:grapher/detachedPanel/align-options.dart';
import 'package:grapher/detachedPanel/panel.dart';
import 'package:grapher/geometry/barchart.dart';

class VolumeFragment implements FragmentContract {
  @override
  GraphObject? interaction, parser, visualisation;

  @override
  VolumeFragment(Map<String, dynamic>? data) {
    if (data == null) return;
    parser = createParser(data);
    visualisation = createVisual();
  }

  GraphObject createParser(Map jsonInput) {
    return SubGraphKernel(
        child: DataInjector(
            stream: mapToStream(jsonInput),
            child: BlockAlreadyReceivedMap(
                id: 'volume',
                child: Extract(
                    options: SourceService.broker!,
                    child: Explode(
                        child: ToPoint2D(
                            xLabel: "datetime",
                            yLabel: "uniform_volume",
                            child: Tag(
                                name: '${SourceService.broker!}_volume',
                                property: TagProperty.neutralRange,
                                child: PipeIn(
                                    eventType: IncomingData,
                                    name: 'pipe_main'))))))));
  }

  GraphObject createVisual() {
    return SubGraphKernel(
        child: UnpackFromViewEvent(
            tagName: '${SourceService.broker!}_volume',
            child: YVirtualRangeUpdate(
                child: DetachedPanel(
                    height: 70,
                    vAlignment: VAlign.bottom,
                    vBias: 3,
                    child: DrawUnitFactory(
                        template: DrawUnit.template(
                            child: BarChart(
                                paint: Paint()
                                  ..color = const Color.fromARGB(
                                      131, 224, 138, 32))))))));
  }
}
