import 'package:labelling/observation/observable.dart';

abstract class Observer {
  onObservablEvent(Observable observable);
}
