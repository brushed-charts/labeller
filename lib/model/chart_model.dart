import 'package:labelling/model/drawtool_model.dart';
import 'package:labelling/model/source_model.dart';
import 'package:labelling/storage/preference/preference_io.dart';

class ChartModel {
  final toolModel = DrawToolModel();
  final sourceModel = SourceModel(PreferenceIO());
}
