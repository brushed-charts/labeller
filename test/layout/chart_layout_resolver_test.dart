import 'package:flutter_test/flutter_test.dart';
import 'package:grapher/staticLayout/stack.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/layout/chart_layout_resolver.dart';
import 'package:labelling/layout/fragment_link.dart';
import 'package:labelling/layout/fragment_tree.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {}

void main() {
  test("Test ChartLayoutResolver create a stackLayout a", () {
    final fragmentTree = FragmentTree();
    final layoutResolver = ChartLayoutResolver(fragmentTree);
    fragmentTree
        .upsert(FragmentLink(id: 'linkA', fragmentToLink: MockFragment()));

    final go = layoutResolver.toGraphObject();
    expect(go, isInstanceOf<StackLayout>());
  });
}
