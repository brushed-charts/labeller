import 'package:grapher/cell/event.dart';
import 'package:grapher/cell/pointer-summary.dart';
import 'package:grapher/filter/dataStruct/point.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/kernel/propagator/single.dart';
import 'package:labelling/grapherExtension/head_shoulders/struct.dart';

class HeadAndShouldersCreation extends GraphObject with SinglePropagator {
  var pattern = HeadAndShouldersStruct();

  HeadAndShouldersCreation({GraphObject? child}) {
    this.child = child;
    eventRegistry.add(CellEvent, (p0) => onCellEvent(p0 as CellEvent));
  }

  void onCellEvent(CellEvent e) {
    handleTap(e);
    resetStructWhenCursorAtEnd();
  }

  void handleTap(CellEvent ev) {
    if (!isEventValid(ev, PointerType.Tap)) return;
    final p = createPointFromCoord(ev);
    updatePattern(p);
    propagate(pattern);
  }

  bool isEventValid(CellEvent ev, PointerType type) {
    if (ev.pointer.type != type) return false;
    if (ev.datetime == null) return false;
    return true;
  }

  void updatePattern(Point2D? coord) {
    if (coord == null) return;
    pattern.upsert(coord);
    pattern.forwardCursor();
  }

  Point2D? createPointFromCoord(CellEvent ev) {
    final x = ev.datetime;
    final y = ev.virtualY;
    if (x == null) return null;
    return Point2D(x, y);
  }

  void resetStructWhenCursorAtEnd() {
    if (!pattern.isCompleted()) return;
    pattern = HeadAndShouldersStruct();
  }
}
