import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/fragment/fragment_tag.dart';

class FragmentModel {
  final List<FragmentTag> _fragmentList = [];

  void add(FragmentTag fragmentTag) {
    _fragmentList.add(fragmentTag);
  }

  List<FragmentTag> getAll() {
    return List.from(_fragmentList);
  }
}
