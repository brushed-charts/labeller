import 'package:grapher/filter/incoming-data.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/kernel/propagator/single.dart';
import 'package:labelling/grapherExtension/head_shoulders/struct.dart';

class HeadAndShouldersParser extends GraphObject with SinglePropagator {
  HeadAndShouldersParser({GraphObject? child}) {
    this.child = child;
    eventRegistry.add(HeadAndShouldersStruct, (p0) => onIncomingHSStruct(p0));
  }

  onIncomingHSStruct(HeadAndShouldersStruct struct) {
    for (final anchor in struct.points) {
      if (anchor == null) continue;
      final incomingData = IncomingData(anchor);
      propagate(incomingData);
    }
  }
}
