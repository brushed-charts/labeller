import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/implementation/concat.dart';

class FragmentLink {
  FragmentLink(
      {required this.id, required this.fragmentToLink, String? parentId})
      : _parentId = parentId;

  String? _parentId;
  final String id;
  final FragmentInterface fragmentToLink;
  final _children = <FragmentLink>[];
  FragmentLink? _parent;

  String? get parentID => _parentId;
  FragmentLink? get parent => _parent;

  void linkToParent(FragmentLink parent) {
    _parent = parent;
    _parent!._children.add(this);
    _parentId = parent.id;
  }

  List<FragmentLink?> next() {
    return List.unmodifiable(_children);
  }

  FragmentInterface concat() {
    if (_children.isEmpty) return fragmentToLink;
    final concatedChildren = <FragmentInterface>[];
    for (final child in _children) {
      concatedChildren.add(child.concat());
    }
    return ConcatFragment(
        rootName: fragmentToLink.rootName,
        children: [...concatedChildren, fragmentToLink]);
  }
}
