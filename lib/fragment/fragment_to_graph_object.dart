import 'package:grapher/cache/main.dart';
import 'package:grapher/cursor/haircross.dart';
import 'package:grapher/filter/accumulate-sorted.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/kernel/propagator/single.dart';
import 'package:grapher/pack/pack.dart';
import 'package:grapher/pipe/pipeIn.dart';
import 'package:grapher/pipe/pipeOut.dart';
import 'package:grapher/reference/contract.dart';
import 'package:grapher/reference/main.dart';
import 'package:grapher/staticLayout/stack.dart';
import 'package:grapher/view/view-event.dart';
import 'package:grapher/view/window.dart';
import 'package:grapher_user_draw/user_interaction/bypass_pointer_event.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/utils/cache_interface.dart';
import 'package:labelling/utils/null_graph_object.dart';

class FragmentToGraphObject extends GraphObject with SinglePropagator {
  final ReferenceRepositoryInterface _referenceRepository;

  FragmentToGraphObject(
      {required FragmentContract fragment,
      required ReferenceRepositoryInterface referenceRepository})
      : _referenceRepository = referenceRepository {
    child = _buildCoreGraph(fragment);
  }

  GraphObject _buildCoreGraph(FragmentContract fragmentStruct) {
    return StackLayout(children: [
      _buildParser(fragmentStruct),
      _buildVisualization(fragmentStruct),
      _buildInteraction(fragmentStruct),
    ]);
  }

  GraphObject _buildParser(FragmentContract struct) {
    return struct.parser ?? NullGraphObject();
  }

  GraphObject _buildVisualization(FragmentContract struct) {
    return PipeOut(
        name: 'pipe_main',
        child: Pack(
            child: SortAccumulation(
                child: CacheChild(
                    storage: CacheServiceInterface(),
                    key: 'graph_cache_window_node',
                    child: Reference(
                        name: "pointer_bypass",
                        repository: _referenceRepository,
                        child: PointerEventBypassChild(
                            child: Window(
                                child: StackLayout(children: [
                          struct.visualisation ?? NullGraphObject(),
                          PipeIn(name: 'pipe_view_event', eventType: ViewEvent),
                          PipeOut(name: 'pipe_cell_event', child: HairCross()),
                        ]))))))));
  }

  GraphObject _buildInteraction(FragmentContract struct) {
    return struct.interaction ?? NullGraphObject();
  }
}
