import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragmentLink/linked_fragment.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {}

void main() {
  test("Assert LinkedFragment child update its parent", () {
    final parentLink =
        LinkedFragment(id: 'linkA', fragmentToLink: MockFragment());
    final childLink = LinkedFragment(
        id: 'linkB', parentId: 'linkA', fragmentToLink: MockFragment());
    expect(parentLink.child, equals(childLink));
    expect(parentLink.parent, isNull);
    expect(childLink.parent, equals(parentLink));
    expect(childLink.child, isNull);
  });
}
