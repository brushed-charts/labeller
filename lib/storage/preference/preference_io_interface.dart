abstract class PreferenceIOInterface {
  Future<String?> load(String prefName);
  Future<void> write(String key, String value);
}
