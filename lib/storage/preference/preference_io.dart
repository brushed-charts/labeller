import 'package:labelling/storage/preference/preference_expection.dart';
import 'package:labelling/storage/preference/preference_io_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceIO implements PreferenceIOInterface {
  @override
  Future<String?> load(String prefName) async {
    final prefs = await SharedPreferences.getInstance();
    final savedSource = prefs.getString(prefName);
    return savedSource;
  }

  @override
  Future<void> write(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final isWrote = await prefs.setString(key, value);
    if (!isWrote) throw PreferenceException("Can't save the preference '$key'");
  }
}
