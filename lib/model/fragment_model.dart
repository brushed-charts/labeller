import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/observation/observable.dart';

class FragmentModel with Observable {
  final List<FragmentInterface> _fragmentList = [];

  void add(FragmentInterface fragment) {
    _fragmentList.add(fragment);
  }

  List<FragmentInterface> getAllFragment() {
    /// Make a copy of internal fragment list
    return List.from(_fragmentList);
  }

  @override
  FragmentModel copy() {
    final copiedModel = FragmentModel();
    for (final fragment in _fragmentList) {
      copiedModel.add(fragment);
    }
    return copiedModel;
  }
}
