import 'package:flutter_test/flutter_test.dart';
import 'package:grapher/kernel/object.dart';
import 'package:grapher/staticLayout/stack.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/implementation/concat.dart';
import 'package:labelling/layout/fragment_link.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {}

void main() {
  late FragmentLink fragmentA, fragmentB;
  setUp(() {
    fragmentA = FragmentLink(id: 'linkA', fragmentToLink: MockFragment());
    fragmentB = FragmentLink(id: 'linkB', fragmentToLink: MockFragment());
  });
  test("Assert LinkedFragment can be linked to a parent", () {
    expect(fragmentA.next(), isEmpty);
    fragmentB.linkToParent(fragmentA);
    expect(fragmentA.next(), equals([fragmentB]));
    expect(fragmentB.next(), isEmpty);
  });

  test("Assert LinkedFragment toGraphObject return a concat fragment", () {
    expect(fragmentA.concat(), isInstanceOf<ConcatFragment>());
  });
}
