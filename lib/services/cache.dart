class CacheService {
  static final _memory = <String, dynamic>{};

  static void save(String key, dynamic value) {
    _memory[key] = value;
  }

  static dynamic load(String key) {
    final value = _memory[key];
    return value;
  }

  static void remove(String key) {
    _memory.remove(key);
  }
}
