import 'package:grapher/cell/event.dart';
import 'package:grapher/cell/pointer-summary.dart';
import 'package:grapher/filter/dataStruct/point.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/kernel/propagator/single.dart';
import 'package:labelling/grapherExtension/head_shoulders/struct.dart';

class HeadAndShouldersInteraction extends GraphObject with SinglePropagator {
  var struct = HeadAndShouldersStruct();

  HeadAndShouldersInteraction({GraphObject? child}) {
    this.child = child;
    eventRegistry.add(CellEvent, (p0) => onCellEvent(p0 as CellEvent));
  }

  void onCellEvent(CellEvent e) {
    handleTap(e);
  }

  void handleTap(CellEvent ev) {
    if (ev.pointer.type != PointerType.Tap) return;
    final p = createPointFromCoord(ev);
    if (p == null) return;
    struct.upsert(p);
    if (!struct.atEnd()) struct.forwardCursor();
    propagate(struct);
  }

  Point2D? createPointFromCoord(CellEvent ev) {
    final x = ev.datetime;
    final y = ev.virtualY;
    if (x == null) return null;
    final p = Point2D(x, y);
    return p;
  }
}
