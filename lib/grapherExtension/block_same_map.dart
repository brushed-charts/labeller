import 'package:flutter/material.dart';
import 'package:grapher/cache/main.dart';
import 'package:grapher/cursor/haircross.dart';
import 'package:grapher/filter/accumulate-sorted.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/kernel/propagator/single.dart';
import 'package:grapher/pack/pack.dart';
import 'package:grapher/pipe/pipeIn.dart';
import 'package:grapher/pipe/pipeOut.dart';
import 'package:grapher/staticLayout/stack.dart';
import 'package:grapher/view/view-event.dart';
import 'package:grapher/view/window.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/services/appmode.dart';
import 'package:labelling/utils/cache_interface.dart';
import 'package:labelling/utils/null_graph_object.dart';

class FragmentToGraphObject extends GraphObject with SinglePropagator {
  FragmentToGraphObject({required FragmentContract fragment}) {
    child = buildCoreGraph(fragment);
  }

  GraphObject buildCoreGraph(FragmentContract fragmentStruct) {
    return StackLayout(children: [
      buildParser(fragmentStruct),
      buildVisualization(fragmentStruct),
      buildInteraction(fragmentStruct),
    ]);
  }

  GraphObject buildParser(FragmentContract struct) {
    return struct.parser ?? NullGraphObject();
  }

  Paint? getColor() {
    if (AppModeService.mode == AppMode.free) return null;
    final paint = Paint();
    paint.color = Colors.red;
    return paint;
  }

  GraphObject buildVisualization(FragmentContract struct) {
    return PipeOut(
        name: 'pipe_main',
        child: Pack(
            child: SortAccumulation(
                child: CacheChild(
                    storage: CacheServiceInterface(),
                    key: 'graph_cache_window_node',
                    child: Window(
                        child: StackLayout(children: [
                      struct.visualisation ?? NullGraphObject(),
                      PipeIn(name: 'pipe_view_event', eventType: ViewEvent),
                      PipeOut(
                          name: 'pipe_cell_event',
                          child: HairCross(paint: getColor())),
                    ]))))));
  }

  GraphObject buildInteraction(FragmentContract struct) {
    return struct.interaction ?? NullGraphObject();
  }
}
