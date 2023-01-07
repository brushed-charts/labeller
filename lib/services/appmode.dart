import 'package:labelling/linkHub/event.dart';
import 'package:labelling/linkHub/main.dart';

enum AppMode { free, headAndShoulders }

class AppModeService {
  static const channel = 'app_mode';
  static var _mode = AppMode.free;

  static AppMode get mode => _mode;
  static set mode(AppMode value) {
    _mode = value;
    LinkHub.emit(HubEvent(channel: channel));
  }
}
