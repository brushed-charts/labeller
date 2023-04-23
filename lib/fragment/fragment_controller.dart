import 'package:grapher/kernel/object.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/model/fragment_model.dart';
import 'package:labelling/fragment/fragment_resolver_interface.dart';
import 'package:logging/logging.dart';

class FragmentController {
  FragmentController(
      {required FragmentModel model,
      required FragmentResolverInterface resolver})
      : _model = model,
        _resolver = resolver;

  final FragmentModel _model;
  final FragmentResolverInterface _resolver;
  final Logger _logger = Logger("fragment_controller");

  void add(FragmentInterface fragment) {
    _logger.finest("Adding to model fragment "
        "(${fragment.name} whith hash ${fragment.hashCode})");
    _model.upsert(fragment);
  }

  GraphObject toGraphObject() {
    _logger.finest("Begin the convertion of model fragment to graphObject");
    return _resolver.reduceToGraphObject(_model);
  }
}
