import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/fragment/base.dart';
import 'package:labelling/fragment/fragment_model.dart';
import 'package:labelling/fragment/fragment_tag.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentContract {}

class MockFragmentTag extends Mock implements FragmentTag {
  @override
  final fragment = MockFragment();
}

void main() {
  test("Assert fragment can be added to model and retrieved", () {
    final model = FragmentModel();
    final fragmentTagA = MockFragmentTag();
    final fragmentTagB = MockFragmentTag();
    model.add(fragmentTagA);
    model.add(fragmentTagB);
    expect(
        model.getAllFragment(),
        equals([
          fragmentTagA.fragment,
          fragmentTagB.fragment,
        ]));
  });

  test(
      "Assert model getAll function return "
      "a shallow copy of the internal list. It will avoid side effect", () {
    final model = FragmentModel();
    model.add(MockFragmentTag());
    final fragmentList = model.getAllFragment();
    expect(fragmentList.length, equals(1));
    fragmentList.add(MockFragment());
    expect(fragmentList.length, equals(2));
    expect(model.getAllFragment().length, equals(1));
  });
}
