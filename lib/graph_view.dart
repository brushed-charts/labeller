import 'package:flutter/widgets.dart';
import 'package:grapher/interaction/widget.dart';
import 'package:grapher/kernel/kernel.dart';
import 'package:grapher/kernel/widget.dart';
import 'package:grapher/reference/contract.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/fragment_to_graph_object.dart';
import 'package:labelling/fragment/implementation/concat.dart';

import 'grapherExtension/axed_graph.dart';
import 'grapherExtension/centered_text.dart';

class GraphViewBuilder {
  Widget noDataScreen() {
    return Graph(
        key: UniqueKey(),
        kernel: GraphKernel(child: CenteredText('There is no data')));
  }

  Widget loadingScreen() {
    return Graph(
        key: UniqueKey(),
        kernel: GraphKernel(child: CenteredText('Loading... Please wait')));
  }

  Widget errorScreen() {
    return Graph(
        key: UniqueKey(),
        kernel: GraphKernel(
            child: CenteredText('There is an error during the loading')));
  }

  Widget priceWidget(ReferenceRepositoryInterface referenceRepository,
      List<FragmentInterface> children) {
    return GraphFullInteraction(
        kernel: GraphKernel(
            child: AxedGraph(
                graph: FragmentToGraphObject(
                    referenceRepository: referenceRepository,
                    fragment: ConcatFragments(children: children)))));
  }
}
