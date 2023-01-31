import 'package:grapher/reference/contract.dart';
import 'package:labelling/fragment/fragment_model.dart';
import 'package:grapher/kernel/object.dart';
import 'package:labelling/fragment/fragment_resolver_interface.dart';
import 'package:labelling/fragment/fragment_to_graph_object.dart';

import 'implementation/concat.dart';

class SinglePanelResolser implements FragmentResolverInterface {
  SinglePanelResolser(this.model, this.referenceRepository);

  @override
  final FragmentModel model;
  final ReferenceRepositoryInterface referenceRepository;

  @override
  GraphObject reduceToGraphObject() {
    final concatedFragment = ConcatFragments(children: model.getAllFragment());
    return FragmentToGraphObject(
      fragment: concatedFragment,
      referenceRepository: referenceRepository,
    );
  }
}
