import 'package:grapher/kernel/object.dart';
import 'package:labelling/fragment/fragment_model.dart';

abstract class FragmentResolverInterface {
  GraphObject reduceToGraphObject(FragmentModel model);
}
