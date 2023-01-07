import 'package:flutter/widgets.dart';
import 'package:grapher/interaction/widget.dart';
import 'package:grapher/kernel/kernel.dart';
import 'package:grapher/kernel/widget.dart';
import 'package:grapher/reference/contract.dart';
import 'package:labelling/fragment/base.dart';

import 'fragment/concat.dart';
import 'grapherExtension/axed_graph.dart';
import 'grapherExtension/centered_text.dart';
import 'grapherExtension/fragment_to_graph_object.dart';

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
      List<FragmentContract> children) {
    return GraphFullInteraction(
        kernel: GraphKernel(
            child: AxedGraph(
                graph: FragmentToGraphObject(
                    referenceRepository: referenceRepository,
                    fragment: ConcatFragments(children: children)))));
  }
}
