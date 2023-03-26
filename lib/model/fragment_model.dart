import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/observation/observable.dart';

class FragmentModel with Observable {
  final List<FragmentInterface> _fragmentList = [];

  void upsert(FragmentInterface fragment) {
    _fragmentList.removeWhere((element) => element.name == fragment.name);
    _fragmentList.add(fragment);
    notify();
  }

  List<FragmentInterface> getAllFragment() {
    /// Make a copy of internal fragment list
    return List.from(_fragmentList);
  }

  @override
  FragmentModel copy() {
    final copiedModel = FragmentModel();
    for (final fragment in _fragmentList) {
      copiedModel.upsert(fragment);
    }
    return copiedModel;
  }

  FragmentInterface? getByName(String fragmentName) {
    FragmentInterface? matchingFragment;
    try {
      matchingFragment =
          _fragmentList.singleWhere((item) => item.name == fragmentName);
    } on StateError {
      matchingFragment = null;
    }
    return matchingFragment;
  }
}
