import 'package:grapher/kernel/object.dart';

abstract class FragmentInterface {
  GraphObject? parser;
  GraphObject? visualisation;
  GraphObject? interaction;
  abstract final String rootParentName;
  abstract final String name;
  abstract final String id;
}
