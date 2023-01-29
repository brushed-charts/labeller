import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/fragment/fragment_model.dart';
import 'package:labelling/fragment/fragment_tag.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentContract {}

class MockFragmentTag extends Mock implements FragmentTag {}

void main() {
  test("Assert fragment can be added to model and retrieved", () {
    final model = FragmentModel();
    final fragmentTagA = MockFragmentTag();
    final fragmentTagB = MockFragmentTag();
    model.add(fragmentTagA);
    model.add(fragmentTagB);
    expect(model.getAll(), equals([fragmentTagA, fragmentTagB]));
  });

  test(
      "Assert model getAll function return "
      "a shallow copy of the internal list. It will avoid side effect", () {
    final model = FragmentModel();
    model.add(MockFragmentTag());
    final fragmentList = model.getAll();
    expect(fragmentList.length, equals(1));
    fragmentList.add(MockFragmentTag());
    expect(fragmentList.length, equals(2));
    expect(model.getAll().length, equals(1));
  });
}
