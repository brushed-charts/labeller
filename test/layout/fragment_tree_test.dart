import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/layout/fragment_tree.dart';
import 'package:labelling/layout/fragment_link.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {}

void main() {
  late FragmentTree model;
  late FragmentLink linkA, linkB, linkA2, linkC, linkD;

  setUp(() {
    model = FragmentTree();
    linkA = FragmentLink(id: 'linkA', fragmentToLink: MockFragment());
    linkA2 = FragmentLink(id: 'linkA', fragmentToLink: MockFragment());
    linkB = FragmentLink(id: 'linkB', fragmentToLink: MockFragment());
    linkC = FragmentLink(id: 'linkC', fragmentToLink: MockFragment());
    linkD = FragmentLink(id: 'linkD', fragmentToLink: MockFragment());
  });
  test("Assert LinkedFragment can be added to ChartLayoutModel", () {
    expect(model.getAll(), isEmpty);
    model.upsert(linkA);
    expect(model.getAll(), containsAll([linkA]));
    model.upsert(linkB);
    expect(model.getAll(), containsAll([linkA, linkB]));
    expect(model.getAll().length, equals(2));
  });
  test(
      "Assert in ChartLayoutModel LinkedFragment"
      "with the same name is replaced  ", () {
    model.upsert(linkA);
    expect(model.getAll(), equals([linkA]));
    model.upsert(linkA2);
    expect(model.getAll(), equals([linkA2]));
    expect(model.getAll(), isNot(contains(linkA)));
  });

  test(
      "Expect the ChartLayoutModel to be able to "
      "get a LinkedFragment with its name", () {
    model.upsert(linkA);
    model.upsert(linkB);
    expect(model.getByID('linkA'), equals(linkA));
    expect(model.getByID('linkB'), equals(linkB));
  });

  test(
      "Expect the ChartLayoutModel "
      "return null when retrieving wrong ID", () {
    expect(model.getByID('linkUnknow'), isNull); // model is empty
    model.upsert(linkA);
    expect(model.getByID('linkUnknow'), isNull);
  });

  test(
      "Expect getRoots from FragmentTree to return "
      "fragmentLink without parents", () {
    model.upsert(linkA);
    model.upsert(linkB);
    model.upsert(linkC);
    model.upsert(linkD);
    linkB.linkToParent(linkA);
    linkC.linkToParent(linkB);
    expect(model.getRoots(), equals([linkA, linkD]));
  });
}
