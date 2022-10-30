import 'package:grapher/cell/cell.dart';
import 'package:grapher/cell/event.dart';
import 'package:grapher/factory/factory.dart';
import 'package:grapher/filter/incoming-data.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/pipe/pipeIn.dart';
import 'package:grapher/pipe/pipeOut.dart';
import 'package:grapher/staticLayout/stack.dart';
import 'package:grapher/subgraph/subgraph-kernel.dart';
import 'package:grapher/tag/property.dart';
import 'package:grapher/group/tag.dart';
import 'package:grapher/utils/merge.dart';
import 'package:grapher/group/unpack.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/grapherExtension/head_shoulders/parser.dart';
import 'package:labelling/grapherExtension/head_shoulders/struct.dart';
import 'package:labelling/grapherExtension/head_shoulders/view.dart';

import '../grapherExtension/head_shoulders/creation.dart';

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
                child: TagUsingGroupID(
                    prefix: 'head_and_shoulders',
                    property: TagProperty.neutralRange,
                    child:
                        PipeIn(eventType: IncomingData, name: 'pipe_main')))));
  }

  GraphObject createVisual() {
    return SubGraphKernel(
        child: UnpackToStackByGroupID(
            tagPrefix: 'head_and_shoulders',
            template: DrawUnitFactory(
                template: Cell.template(
                    child: HeadAndShouldersView(
                        child: MergeBranches(
                            child: PipeIn(
                                name: 'pipe_cell_event_hs',
                                eventType: CellEvent)))))));
  }

  GraphObject createInteraction() {
    return StackLayout(children: [
      PipeOut(
          name: 'pipe_cell_event_price',
          child: HeadAndShouldersCreation(
              child: PipeIn(
                  name: 'pipe_head_and_shoulders_struct',
                  eventType: HeadAndShouldersStruct)))
    ]);
  }
}
