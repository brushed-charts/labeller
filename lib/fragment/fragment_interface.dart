import 'package:grapher/kernel/object.dart';

abstract class FragmentInterface {
  GraphObject? parser;
  GraphObject? visualisation;
  GraphObject? interaction;
  String get name;
}
