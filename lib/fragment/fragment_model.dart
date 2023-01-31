import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/fragment_tag.dart';

class FragmentModel {
  final List<FragmentTag> _fragmentList = [];

  void add(FragmentTag fragmentTag) {
    _fragmentList.add(fragmentTag);
  }

  List<FragmentInterface> getAllFragment() {
    return List.from(_fragmentList.map<FragmentInterface>((e) => e.fragment));
  }
}
