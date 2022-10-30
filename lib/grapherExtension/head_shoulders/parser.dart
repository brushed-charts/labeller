import 'package:grapher/filter/incoming-data.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/kernel/propagator/single.dart';
import 'package:grapher/pack/prune-event.dart';
import 'package:labelling/grapherExtension/head_shoulders/struct.dart';

class HeadAndShouldersParser extends GraphObject with SinglePropagator {
  HeadAndShouldersParser({GraphObject? child}) {
    this.child = child;
    eventRegistry.add(HeadAndShouldersStruct, (p0) => onIncomingHSStruct(p0));
  }

  onIncomingHSStruct(HeadAndShouldersStruct struct) {
    removePreviousGroup(struct.groupID);
    for (final anchor in struct.points) {
      if (anchor == null) continue;
      final incomingData = IncomingData(anchor);
      propagate(incomingData);
    }
  }

  removePreviousGroup(int groupID) {
    final tagName = 'head_and_shoulders_$groupID';
    final pruneEvent = PrunePacketEvent(tagNameToPrune: tagName);
    propagate(pruneEvent);
  }
}
