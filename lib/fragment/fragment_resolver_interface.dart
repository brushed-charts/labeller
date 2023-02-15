import 'package:grapher/kernel/object.dart';
import 'package:labelling/model/fragment_model.dart';

abstract class FragmentResolverInterface {
  GraphObject reduceToGraphObject(FragmentModel model);
}
