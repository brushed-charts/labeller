import 'package:labelling/fragment/fragment_interface.dart';

class FragmentModel {
  final List<FragmentInterface> _fragmentList = [];

  void add(FragmentInterface fragmentTag) {
    _fragmentList.add(fragmentTag);
  }

  List<FragmentInterface> getAllFragment() {
    /// Make a copy of internal fragment list
    return List.from(_fragmentList);
  }
}
