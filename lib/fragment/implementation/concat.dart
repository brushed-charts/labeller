import 'package:grapher/kernel/object.dart';
import 'package:grapher/staticLayout/stack.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/utils/null_graph_object.dart';

class ConcatFragments implements FragmentContract {
  @override
  GraphObject? parser, visualisation, interaction;

  final List<FragmentContract> _fragments;

  final _parserList = <GraphObject?>[];
  final _visualList = <GraphObject?>[];
  final _interactionList = <GraphObject?>[];

  ConcatFragments({List<FragmentContract>? children})
      : _fragments = children ?? [] {
    _extractSubgraphFromFragment();
    _removeNullValues();
    _makeUnifiedFragment();
  }

  void _extractSubgraphFromFragment() {
    for (final fragment in _fragments) {
      _parserList.add(fragment.parser);
      _visualList.add(fragment.visualisation);
      _interactionList.add(fragment.interaction);
    }
  }

  void _removeNullValues() {
    _parserList.removeWhere((element) => element == null);
    _visualList.removeWhere((element) => element == null);
    _interactionList.removeWhere((element) => element == null);
  }

  _makeUnifiedFragment() {
    parser = _listToStackLayout(_parserList);
    visualisation = _listToStackLayout(_visualList);
    interaction = _listToStackLayout(_interactionList);
  }

  GraphObject _listToStackLayout(List<GraphObject?> inputs) {
    if (inputs.isEmpty) return NullGraphObject();
    return StackLayout(children: inputs.cast<GraphObject>());
  }
}
