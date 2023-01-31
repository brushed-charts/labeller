import 'package:labelling/fragment/base.dart';
import 'package:labelling/fragment/fragment_tag.dart';

class FragmentModel {
  final List<FragmentTag> _fragmentList = [];

  void add(FragmentTag fragmentTag) {
    _fragmentList.add(fragmentTag);
  }

  List<FragmentContract> getAllFragment() {
    return List.from(_fragmentList.map<FragmentContract>((e) => e.fragment));
  }
}
