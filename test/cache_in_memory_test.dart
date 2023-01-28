import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/storage/cache/cache_in_memory.dart';

class DummyObject {
  String value;
  DummyObject(this.value);
}

void main() {
  final expectedObjectA = DummyObject("a_dummy_value");
  late Map<String, dynamic> memory;
  final Map<String, dynamic> emptyMemory = {};

  setUp(() {
    memory = <String, dynamic>{
      'test_key1': expectedObjectA,
      'test_key2': 'test_value'
    };
  });

  group("Cache in memory loading ->", () {
    test("Assert cache can load a String", () {
      final cache = CacheInMemory(memory);
      expect(cache.load('test_key2'), equals('test_value'));
    });
    test("Assert cache can load an object", () {
      final cache = CacheInMemory(memory);
      expect(cache.load('test_key1'), equals(expectedObjectA));
    });
  });

  test("Assert in memory cache can save an object", () {
    final memory = <String, dynamic>{};
    final cache = CacheInMemory(memory);
    cache.save('a_key', expectedObjectA);
    expect(memory['a_key'], equals(expectedObjectA));
  });

  test("Assert in memory cache can delete an object", () {
    expect(memory.length, equals(2));
    final cache = CacheInMemory(memory);
    cache.remove('test_key1');
    expect(memory['test_key1'], isNull);
    expect(memory.length, equals(1));
  });

  group("In memory cache crash test ->", () {
    test("Assert it don't throw during loading when key desn't exists", () {
      final cache = CacheInMemory(emptyMemory);
      expect(cache.load('non_existant_key'), isNull);
      expect(cache.load('non_existant_key'), isNot(throwsException));
    });

    test("Assert it don't throw during deletion if key desn't exists", () {
      final cache = CacheInMemory();
      expect(() => cache.remove('non_existant_key'), returnsNormally);
    });

    test("Assert don't throw when loading a key with a null value", () {
      final memory = <String, dynamic>{'a_key': null};
      final cache = CacheInMemory(memory);
      expect(cache.load('a_key'), isNull);
    });
  });
}
