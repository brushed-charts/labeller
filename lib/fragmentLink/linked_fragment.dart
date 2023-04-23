import 'package:labelling/fragment/fragment_interface.dart';

class LinkedFragment {
  LinkedFragment(
      {required this.id, required this.fragmentToLink, this.parentId});

  final String? parentId;
  final String id;
  final FragmentInterface fragmentToLink;
  LinkedFragment? parent;
  LinkedFragment? child;
}
