import 'package:labelling/fragment/fragment_model.dart';
import 'package:labelling/fragment/fragment_resolver_interface.dart';

class FragmentController {
  FragmentController(
      {required FragmentModel model,
      required FragmentResolverInterface resolver})
      : _model = model,
        _resolver = resolver;

  final FragmentModel _model;
  final FragmentResolverInterface _resolver;
}
