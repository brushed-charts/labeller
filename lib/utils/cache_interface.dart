import 'package:grapher/cache/contract.dart';
import 'package:labelling/services/cache.dart';

class CacheServiceInterface implements CacheContract {
  @override
  dynamic load(String key) => CacheService.load(key);

  @override
  void remove(String key) => CacheService.remove(key);

  @override
  void save(String key, dynamic value) => CacheService.save(key, value);
}
