import 'package:grapher/kernel/object.dart';
import 'package:grapher/reference/contract.dart';
import 'package:grapher/reference/main.dart';
import 'package:grapher/reference/reader.dart';
import 'package:grapher/subgraph/subgraph-kernel.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:grapher_user_draw/entrypoint_viewable.dart';
import 'package:grapher_user_draw/figure_database_interface.dart';
import 'package:grapher_user_draw/presenter.dart';
import 'package:grapher_user_draw/store.dart';
import 'package:grapher_user_draw/user_interaction/main_userinteraction.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/grapherExtension/draw_tool_propagator.dart';

class FigureFragment implements FragmentInterface {
  FigureFragment(
      this._figureStore, this._referenceRepository, this._figureDatabase) {
    visualisation = createVisual();
  }

  final FigureStore _figureStore;
  final ReferenceRepositoryInterface _referenceRepository;
  final FigureDatabaseInterface _figureDatabase;

  @override
  GraphObject? interaction, parser, visualisation;

  set drawTool(DrawToolInterface? tool) {
    return ReferenceReader<DrawToolPropagator>(
            repository: _referenceRepository, refName: 'draw_tool_propagator')
        .read()!
        .propagateDrawTool(tool);
  }

  GraphObject createVisual() {
    return SubGraphKernel(
        child: Reference(
            name: 'draw_tool_propagator',
            repository: _referenceRepository,
            child: DrawToolPropagator(
                child: GrapherUserDraw(
                    drawPresenter: DrawPresenter(_figureStore),
                    interaction: UserInteraction(
                        store: _figureStore,
                        refPointerBypass: ReferenceReader(
                            refName: "pointer_bypass",
                            repository: _referenceRepository),
                        figureDatabase: _figureDatabase),
                    store: _figureStore,
                    figureDatabase: _figureDatabase))));
  }
}
