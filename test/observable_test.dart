import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:mocktail/mocktail.dart';

class FakeObservable with Observable {
  var aField = "a";

  @override
  copy() {
    final cp = FakeObservable();
    cp.aField = aField;
    return cp;
  }

  @override
  bool operator ==(covariant FakeObservable other) => aField == other.aField;

  @override
  int get hashCode => aField.hashCode;
}

class MockObserver extends Mock implements Observer {}

void main() {
  registerFallbackValue(FakeObservable());
  late FakeObservable observable;
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
    verify(() => observerA.onObservableEvent(any())).called(1);
    final verifResult = verify(() => observerB.onObservableEvent(captureAny()));
    verifResult.called(1);
    expect(verifResult.captured[0], equals(observable));
  });

  test("Expect observable event send a copy of the observable", () {
    observable.notify();
    final copiedObservable =
        verify(() => observerA.onObservableEvent(captureAny())).captured[0]
            as FakeObservable;
    copiedObservable.aField = "a change";
    expect(copiedObservable.aField, isNot(equals(observable.aField)));
  });
}
