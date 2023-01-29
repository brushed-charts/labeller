import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/fragment/base.dart';

class FragmentModel {
  final List<FragmentContract> _fragmentList = [];

  void add(FragmentContract fragment) {
    _fragmentList.add(fragment);
  }

  List<FragmentContract> getAll() {
    return List.from(_fragmentList);
  }
}
