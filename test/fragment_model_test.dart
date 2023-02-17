import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/fragment_resolver_interface.dart';
import 'package:labelling/model/fragment_model.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements FragmentInterface {}

class MockFragmentResolver extends Mock implements FragmentResolverInterface {}

void main() {
  late FragmentModel fragmentModel;

  setUp(() {
    fragmentModel = FragmentModel();
  });

  test("Assert fragment can be added to model and retrieved", () {
    final fragmentA = MockFragment();
    final fragmentB = MockFragment();
    fragmentModel.add(fragmentA);
    fragmentModel.add(fragmentB);
    expect(fragmentModel.getAllFragment(), equals([fragmentA, fragmentB]));
  });

  test(
      "Assert model getAll function return "
      "a shallow copy of the internal list. It will avoid side effect", () {
    fragmentModel.add(MockFragment());
    final fragmentList = fragmentModel.getAllFragment();
    expect(fragmentList.length, equals(1));
    fragmentList.add(MockFragment());
    expect(fragmentList.length, equals(2));
    expect(fragmentModel.getAllFragment().length, equals(1));
  });

  test("Test if fragment model copy function return a shallow copy", () {
    fragmentModel.add(MockFragment());
    final copiedModel = fragmentModel.copy();
    expect(copiedModel.getAllFragment().length, equals(1));
    fragmentModel.add(MockFragment());
    expect(copiedModel.getAllFragment().length, equals(1));
    expect(fragmentModel.getAllFragment().length, equals(2));
  });
}
