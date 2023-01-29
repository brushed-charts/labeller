import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:labelling/fragment/fragment_tag.dart';
import 'package:mocktail/mocktail.dart';

class MockFragment extends Mock implements Fragment {}

void main() {
  test("Check that tag name associate a given name to fragment", () {
    final fragment = MockFragment();
    final fragmentTag = FragmentTag(name: "Price", fragment: fragment);
    expect(fragmentTag.name, "Price");
    expect(fragmentTag.fragment, fragment);
  });
}
