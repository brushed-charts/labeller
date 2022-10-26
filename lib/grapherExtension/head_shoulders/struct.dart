import 'package:grapher/filter/dataStruct/anchor.dart';
import 'package:grapher/filter/dataStruct/point.dart';
import 'package:labelling/utils/misc_function.dart';

class HeadAndShouldersStruct {
  static const pointCount = 7;
  final points = List<Anchor?>.filled(pointCount, null);
  final int _group;
  var _cursor = 0;
  get cursor => _cursor;

  HeadAndShouldersStruct() : _group = Misc.generateUniqueID();

  void forwardCursor() {
    if (atEnd()) throw Exception("Can't forward, cusor is already at the end");
    _cursor = _cursor + 1;
  }

  bool atEnd() {
    if (_cursor == pointCount - 1) return true;
    return false;
  }

  void upsert(Point2D p) {
    // final anchor = Anchor(p.x, p.y, _group);
    final anchor = Anchor(p.x, p.y, _group);
    points[_cursor] = anchor;
  }

  @override
  String toString() {
    return points.toString();
  }
}
