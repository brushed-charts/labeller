import 'package:labelling/observation/copyable_interface.dart';

import 'observer.dart';

mixin Observable implements Copyable<Observable> {
  final observers = <Observer>[];

  void subscribe(Observer observer) {
    observers.add(observer);
  }

  void notify() {
    for (final observer in observers) {
      observer.onObservableEvent(copy());
    }
  }
}
