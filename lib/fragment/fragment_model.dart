import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/fragment_tag.dart';

class FragmentModel {
  final List<FragmentTag> _fragmentList = [];

  void add(FragmentTag fragmentTag) {
    _fragmentList.add(fragmentTag);
  }

  List<FragmentInterface> getAllFragment() {
    /// Make a copy of internal fragment list
    return List.from(_fragmentList.map<FragmentInterface>((e) => e.fragment));
  }
}
