import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/layout/chart_layout_resolver.dart';
import 'package:labelling/layout/fragment_link.dart';
import 'package:labelling/layout/fragment_link_tree.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {}

void main() {
  test("Test each fragment is wrap in a StackLayout", () {
    final fragmentTree = FragmentTree();
    final layoutResolver = ChartLayoutResolver(fragmentTree);
    fragmentTree
        .upsert(FragmentLink(id: 'linkA', fragmentToLink: MockFragment()));
    fragmentTree.upsert(FragmentLink(
        id: 'linkB', fragmentToLink: MockFragment(), parentId: 'linkA'));
    fragmentTree.upsert(FragmentLink(
        id: 'linkC', fragmentToLink: MockFragment(), parentId: 'linkB'));
    fragmentTree.upsert(FragmentLink(
        id: 'linkA', fragmentToLink: MockFragment(), parentId: 'linkA'));
  });
}
