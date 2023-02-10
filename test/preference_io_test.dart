import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  test("Assert value can be loaded using PreferenceIO", () async {
    final prefIO = PreferenceIO();
    final sharedInstance = await SharedPreferences.getInstance();
    sharedInstance.setString("aPrefName", "aValue");
    final result = await prefIO.load("aPrefName");
    expect(result, equals("aValue"));
    sharedInstance.remove("aPrefName");
  });

  group("Preference writing ->", () {
    test("Assert PreferenceIO can write value", () async {
      final prefIO = PreferenceIO();
      await prefIO.write('aPrefNameTest', 'aValueTest');
      final sharedInstance = await SharedPreferences.getInstance();
      final result = sharedInstance.getString('aPrefNameTest');
      expect(result, equals('aValueTest'));
    });

    // test("Assert PreferenceIO can write "
  });
}
