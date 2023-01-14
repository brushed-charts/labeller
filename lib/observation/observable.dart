import 'observer.dart';

mixin Observable {
  final observers = <Observer>[];

  void subscribe(Observer observer) {
    observers.add(observer);
  }

  void notify() {
    for (final observer in observers) {
      observer.onObservablEvent(this);
    }
  }
}
