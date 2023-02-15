import 'package:grapher/kernel/object.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/fragment_resolver_interface.dart';

class FragmentModel {
  FragmentModel({required FragmentResolverInterface resolver})
      : _resolver = resolver;

  final FragmentResolverInterface _resolver;
  final List<FragmentInterface> _fragmentList = [];

  void add(FragmentInterface fragmentTag) {
    _fragmentList.add(fragmentTag);
  }

  List<FragmentInterface> getAllFragment() {
    /// Make a copy of internal fragment list
    return List.from(_fragmentList);
  }

  GraphObject toGraphObject() {
    return _resolver.reduceToGraphObject(this);
  }
}
