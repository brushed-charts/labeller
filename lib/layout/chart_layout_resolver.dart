import 'package:grapher/reference/contract.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/layout/fragment_tree.dart';
import 'package:labelling/layout/vertical_splliter.dart';

class ChartLayoutResolver {
  ChartLayoutResolver(
      ReferenceRepositoryInterface referenceRepository, this.tree);

  final FragmentTree tree;
  final ReferenceRepositoryInterface referenceRepository;

  void resolve() {
    final parentLessLinks = tree.getRoots();
    final concatedChildren = <FragmentInterface>[];
    for (final link in parentLessLinks) {
      concatedChildren.add(link.concat());
    }
    VerticalLayout(
        referenceRepo: referenceRepository, children: concatedChildren);
  }
}
