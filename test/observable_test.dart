import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:mocktail/mocktail.dart';

class FakeObservable with Observable {}

class MockObserver extends Mock implements Observer {}

void main() {
  registerFallbackValue(FakeObservable());
  late Observable observable;
  late Observer observer;

  setUp(() {
    observable = FakeObservable();
    observer = MockObserver();
    observable.subscribe(observer);
  });
  test("Test that observer can be added to observable object", () {
    expect(observable.observers.length, equals(1));
    expect(observable.observers[0], equals(observer));
  });

  test("Test observable object notify observer", () {
    observable.notify();
    final verifResult = verify(() => observer.onObservablevent(captureAny()));
    verifResult.called(1);
    expect(verifResult.captured[0], equals(observable));
  });
}
