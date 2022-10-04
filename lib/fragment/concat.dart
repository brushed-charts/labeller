import 'package:grapher/kernel/object.dart';
import 'package:grapher/staticLayout/stack.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/utils/null_graph_object.dart';

class ConcatFragment implements FragmentContract {
  @override
  GraphObject? parser, visualisation, interaction;

  final List<FragmentContract> _fragments;

  final _parserList = <GraphObject?>[];
  final _visualList = <GraphObject?>[];
  final _interactionList = <GraphObject?>[];

  ConcatFragment(this._fragments) {
    extractSubgraphFromFragment();
    removeNullValues();
    makeUnifiedFragment();
  }

  void extractSubgraphFromFragment() {
    for (final fragment in _fragments) {
      _parserList.add(fragment.parser);
      _visualList.add(fragment.visualisation);
      _interactionList.add(fragment.interaction);
    }
  }

  void removeNullValues() {
    _parserList.removeWhere((element) => element == null);
    _visualList.removeWhere((element) => element == null);
    _interactionList.removeWhere((element) => element == null);
  }

  makeUnifiedFragment() {
    parser = listToStackLayout(_parserList);
    visualisation = listToStackLayout(_visualList);
    interaction = listToStackLayout(_interactionList);
  }

  GraphObject listToStackLayout(List<GraphObject?> inputs) {
    if (inputs.isEmpty) return NullGraphObject();
    return StackLayout(children: inputs.cast<GraphObject>());
  }
}
