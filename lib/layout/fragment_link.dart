import 'package:labelling/fragment/fragment_interface.dart';

class FragmentLink {
  FragmentLink({required this.id, required this.fragmentToLink, this.parentId});

  final String? parentId;
  final String id;
  final FragmentInterface fragmentToLink;
  FragmentLink? _parent;
  FragmentLink? _child;

  void linkToParent(FragmentLink parent) {
    _parent = parent;
    _parent!._child = this;
  }

  FragmentLink? next() {
    return _child;
  }
}
