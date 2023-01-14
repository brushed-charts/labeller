import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:mocktail/mocktail.dart';

class FakeObservable with Observable {}

class MockObserver extends Mock implements Observer {}

void main() {
  registerFallbackValue(FakeObservable());
  late Observable observable;
  late Observer observerA, observerB;

  setUp(() {
    observable = FakeObservable();
    observerA = MockObserver();
    observerB = MockObserver();
    observable.subscribe(observerA);
    observable.subscribe(observerB);
  });
  test("Test that observers can be added to observable object", () {
    expect(observable.observers.length, equals(2));
    expect(observable.observers[0], equals(observerA));
    expect(observable.observers[1], equals(observerB));
  });

  test("Test observable objects notifies every observers", () {
    observable.notify();
    verify(() => observerA.onObservablEvent(any())).called(1);
    final verifResult = verify(() => observerB.onObservablEvent(captureAny()));
    verifResult.called(1);
    expect(verifResult.captured[0], equals(observable));
  });
}
