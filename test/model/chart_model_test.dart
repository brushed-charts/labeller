import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer providerContainer;
  test(
      "Assert chartModel is updated when "
      "source, interval or dateRange is updated", () {
    providerContainer = ProviderContainer(overrides: []);
  });
}
