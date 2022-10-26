import 'package:grapher/cell/cell.dart';
import 'package:grapher/cell/event.dart';
import 'package:grapher/drawUnit/drawunit.dart';
import 'package:grapher/factory/factory.dart';
import 'package:grapher/filter/incoming-data.dart';
import 'package:grapher/geometry/line.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/pack/unpack-view.dart';
import 'package:grapher/pipe/pipeIn.dart';
import 'package:grapher/pipe/pipeOut.dart';
import 'package:grapher/subgraph/subgraph-kernel.dart';
import 'package:grapher/tag/property.dart';
import 'package:grapher/tag/tag.dart';
import 'package:grapher/utils/merge.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/grapherExtension/head_shoulders/parser.dart';
import 'package:labelling/grapherExtension/head_shoulders/struct.dart';
import 'package:labelling/grapherExtension/head_shoulders/view.dart';

import '../grapherExtension/head_shoulders/interaction.dart';

class HeadAndShouldersFragment implements FragmentContract {
  @override
  GraphObject? interaction, parser, visualisation;

  @override
  HeadAndShouldersFragment() {
    parser = createParser();
    visualisation = createVisual();
    interaction = createInteraction();
  }

  GraphObject createParser() {
    return SubGraphKernel(
        child: PipeOut(
            name: 'pipe_head_and_shoulders_struct',
            child: HeadAndShouldersParser(
                child: Tag(
                    name: 'head_and_shoulders',
                    property: TagProperty.neutralRange,
                    child:
                        PipeIn(eventType: IncomingData, name: 'pipe_main')))));
  }

  GraphObject createVisual() {
    return SubGraphKernel(
        child: UnpackFromViewEvent(
            tagName: 'head_and_shoulders',
            child: DrawUnitFactory(
                template: Cell.template(
                    child: HeadAndShouldersView(
                        child: MergeBranches(
                            child: PipeIn(
                                name: 'pipe_cell_event',
                                eventType: CellEvent)))))));
  }

  GraphObject createInteraction() {
    return PipeOut(
        name: 'pipe_view_event',
        child: PipeOut(
            name: 'pipe_cell_event',
            child: HeadAndShouldersInteraction(
                child: PipeIn(
                    name: 'pipe_head_and_shoulders_struct',
                    eventType: HeadAndShouldersStruct))));
  }
}
