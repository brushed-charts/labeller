import 'package:grapher/cache/main.dart';
import 'package:grapher/cursor/haircross.dart';
import 'package:grapher/filter/accumulate-sorted.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/pack/pack.dart';
import 'package:grapher/pipe/pipeIn.dart';
import 'package:grapher/pipe/pipeOut.dart';
import 'package:grapher/reference/contract.dart';
import 'package:grapher/reference/main.dart';
import 'package:grapher/splitter/vertical.dart';
import 'package:grapher/staticLayout/stack.dart';
import 'package:grapher/view/view-event.dart';
import 'package:grapher/view/window.dart';
import 'package:grapher_user_draw/user_interaction/bypass_pointer_event.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/utils/cache_interface.dart';
import 'package:labelling/utils/null_graph_object.dart';

class VerticalLayout {
  VerticalLayout(
      {required this.referenceRepo, required List<FragmentInterface> children})
      : _children = children;

  final List<FragmentInterface> _children;
  ReferenceRepositoryInterface referenceRepo;

  GraphObject toGraphObjectLayout() {
    final graphObjectChildren = <StackLayout>[];
    for (final child in _children) {
      graphObjectChildren.add(StackLayout(children: [
        child.parser ?? NullGraphObject(),
        _makeVisualisation(referenceRepo, child),
        child.interaction ?? NullGraphObject()
      ]));
    }
    return VerticalSplitter(children: graphObjectChildren);
  }

  GraphObject _makeVisualisation(ReferenceRepositoryInterface referenceRepo,
      FragmentInterface childFragment) {
    return PipeOut(
        name: 'pipe_main_${childFragment.rootName}',
        child: Pack(
            child: SortAccumulation(
                child: CacheChild(
                    storage: CacheServiceInterface(),
                    key: 'graph_cache_window_node_${childFragment.rootName}',
                    child: Reference(
                        name: "pointer_bypass_${childFragment.rootName}",
                        repository: referenceRepo,
                        child: PointerEventBypassChild(
                            child: Window(
                                child: StackLayout(children: [
                          childFragment.visualisation ?? NullGraphObject(),
                          PipeIn(
                              name: 'pipe_view_event_${childFragment.rootName}',
                              eventType: ViewEvent),
                          PipeOut(
                              name: 'pipe_cell_event_${childFragment.rootName}',
                              child: HairCross()),
                        ]))))))));
  }
}
