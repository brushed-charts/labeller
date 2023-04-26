import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/layout/fragment_link.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {}

void main() {
  test("Assert LinkedFragment can be linked to a parent", () {
    final fragmentA = FragmentLink(id: 'linkA', fragmentToLink: MockFragment());
    final fragmentB = FragmentLink(id: 'linkB', fragmentToLink: MockFragment());
    expect(fragmentA.next(), isNull);
    fragmentB.linkToParent(fragmentA);
    expect(fragmentA.next(), equals(fragmentB));
    expect(fragmentB.next(), isNull);
  });
}
