import 'package:grapher/cache/contract.dart';

/// Save in memory the state of an object identified by its key
/// Usefull to restaure the state between reload
class CacheInMemory implements CacheContract {
  final Map<String, dynamic> _memory;

  CacheInMemory([Map<String, dynamic>? externalKVMemory])
      : _memory = externalKVMemory ?? {};

  @override
  void save(String key, dynamic value) {
    _memory[key] = value;
  }

  @override
  dynamic load(String key) {
    final value = _memory[key];
    return value;
  }

  @override
  void remove(String key) {
    _memory.remove(key);
  }
}
