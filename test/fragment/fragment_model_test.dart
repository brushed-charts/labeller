import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/fragment_model.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {}

void main() {
  test("Assert fragment can be added to model and retrieved", () {
    final model = FragmentModel();
    final fragmentA = MockFragment();
    final fragmentB = MockFragment();
    model.add(fragmentA);
    model.add(fragmentB);
    expect(model.getAllFragment(), equals([fragmentA, fragmentB]));
  });

  test(
      "Assert model getAll function return "
      "a shallow copy of the internal list. It will avoid side effect", () {
    final model = FragmentModel();
    model.add(MockFragment());
    final fragmentList = model.getAllFragment();
    expect(fragmentList.length, equals(1));
    fragmentList.add(MockFragment());
    expect(fragmentList.length, equals(2));
    expect(model.getAllFragment().length, equals(1));
  });
}
