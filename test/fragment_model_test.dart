import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/fragment/fragment_interface.dart';
import 'package:labelling/fragment/fragment_resolver_interface.dart';
import 'package:labelling/model/fragment_model.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Fake implements FragmentInterface {
  MockFragment(this.name);

  @override
  final String name;
}

class MockFragmentResolver extends Mock implements FragmentResolverInterface {}

void main() {
  late FragmentModel fragmentModel;

  setUp(() {
    fragmentModel = FragmentModel();
  });

  group("Test upserting a fragment:", () {
    test("Assert fragment can be added to model and retrieved", () {
      final fragmentA = MockFragment('fragA');
      final fragmentB = MockFragment('fragB');
      fragmentModel.upsert(fragmentA);
      fragmentModel.upsert(fragmentB);
      expect(fragmentModel.getAllFragment(), equals([fragmentA, fragmentB]));
    });

    test("Assert fragment is updated if fragment with the same name exist", () {
      final fragmentA = MockFragment('fragA');
      final fragmentABis = MockFragment('fragA');
      fragmentModel.upsert(fragmentA);
      fragmentModel.upsert(fragmentABis);
      expect(fragmentModel.getAllFragment(), equals([fragmentABis]));
    });
  });

  test(
      "Assert model getAll function return "
      "a shallow copy of the internal list. It will avoid side effect", () {
    fragmentModel.upsert(MockFragment('fragA'));
    final fragmentList = fragmentModel.getAllFragment();
    expect(fragmentList.length, equals(1));
    fragmentList.add(MockFragment('fragX'));
    expect(fragmentList.length, equals(2));
    expect(fragmentModel.getAllFragment().length, equals(1));
  });

  test("Test if fragment model copy function return a shallow copy", () {
    fragmentModel.upsert(MockFragment('fragA'));
    final copiedModel = fragmentModel.copy();
    expect(copiedModel.getAllFragment().length, equals(1));
    fragmentModel.upsert(MockFragment('fragB'));
    expect(copiedModel.getAllFragment().length, equals(1));
    expect(fragmentModel.getAllFragment().length, equals(2));
  });
}
