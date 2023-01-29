import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/fragment/fragment_model.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentContract {}

void main() {
  test("Assert fragment can be added to model and retrieved", () {
    final model = FragmentModel();
    final fragmentA = MockFragment();
    final fragmentB = MockFragment();
    model.add(fragmentA);
    model.add(fragmentB);
    expect(model.getAll(), equals([fragmentA, fragmentB]));
  });

  test(
      "Assert model getAll function return "
      "a shallow copy of the internal list. It will avoid side effect", () {
    final model = FragmentModel();
    model.add(MockFragment());
    final fragmentList = model.getAll();
    expect(fragmentList.length, equals(1));
    fragmentList.add(MockFragment());
    expect(fragmentList.length, equals(2));
    expect(model.getAll().length, equals(1));
  });
}
