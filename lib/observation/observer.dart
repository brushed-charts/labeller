import 'package:labelling/observation/observable.dart';

abstract class Observer {
  void onObservableEvent(Observable observable);
}
