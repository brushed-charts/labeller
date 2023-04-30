import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/implementation/concat.dart';
import 'package:labelling/layout/fragment_link.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {
  @override
  String get rootName => 'mock_root';
}

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
    expect(fragmentB.parentID, equals('linkA'));
    expect(fragmentB.parent, fragmentA);
  });

  test("Assert LinkedFragment can be recursivly concated if it as children",
      () {
    expect(fragmentA.concat(), isInstanceOf<MockFragment>());
    expect(fragmentA.concat(), equals(fragmentA.fragmentToLink));
    fragmentB.linkToParent(fragmentA);
    expect(fragmentA.concat(), isInstanceOf<ConcatFragment>());
  });
}
