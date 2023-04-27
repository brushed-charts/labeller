import 'package:grapher/kernel/object.dart';
import 'package:grapher/staticLayout/stack.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/implementation/concat.dart';

class FragmentLink {
  FragmentLink({required this.id, required this.fragmentToLink, this.parentId});

  final String? parentId;
  final String id;
  final FragmentInterface fragmentToLink;
  final _children = <FragmentLink>[];
  FragmentLink? _parent;

  void linkToParent(FragmentLink parent) {
    _parent = parent;
    _parent!._children.add(this);
  }

  List<FragmentLink?> next() {
    return List.unmodifiable(_children);
  }

  ConcatFragment concat() {
    for(final child in _children){
      child.concat()
    }
    return ConcatFragment(children: List.unmodifiable(_children));
  }
}
