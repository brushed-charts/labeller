import 'package:flutter_test/flutter_test.dart';
import 'package:grapher/reference/contract.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/implementation/concat.dart';
import 'package:labelling/layout/chart_layout_resolver.dart';
import 'package:labelling/layout/fragment_link.dart';
import 'package:labelling/layout/fragment_tree.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {}

class MockFragmentTree extends Mock implements FragmentTree {}

class MockReferenceRepository extends Mock
    implements ReferenceRepositoryInterface {}

class MockFragmentLink extends Mock implements FragmentLink {
  MockFragmentLink({required this.id});
  @override
  final String id;
}

void main() {
  late FragmentTree tree;
  late FragmentLink fragmentA, fragmentB;
  late ChartLayoutResolver layoutResolver;
  setUp(() {
    tree = MockFragmentTree();
    layoutResolver = ChartLayoutResolver(MockReferenceRepository(), tree);
    fragmentA = MockFragmentLink(id: 'linkA');
    fragmentB = MockFragmentLink(id: 'linkB');

    when(() => tree.getRoots()).thenReturn([fragmentA, fragmentB]);
    when(() => fragmentA.concat()).thenReturn(ConcatFragment(rootName: 'A'));
    when(() => fragmentB.concat()).thenReturn(ConcatFragment(rootName: 'B'));
  });
  test("Test ChartLayoutResolver concat all parentless link", () {
    layoutResolver.resolve();
    verify(() => tree.getRoots()).called(1);
    verify(() => fragmentA.concat()).called(1);
    verify(() => fragmentB.concat()).called(1);
  });
}
