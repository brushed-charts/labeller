import 'package:grapher/kernel/object.dart';
import 'package:labelling/fragment/fragment_model.dart';

abstract class FragmentResolverInterface {
  abstract final FragmentModel model;
  GraphObject reduceToGraphObject();
}
