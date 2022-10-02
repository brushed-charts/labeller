import 'dart:io';

import 'package:flutter/material.dart';
import 'package:labelling/linkHub/event.dart';
import 'package:labelling/linkHub/main.dart';

enum AppMode { free, selection }

class AppModeService {
  final appModeChannel = 'app_mode';
  static var _mode = AppMode.free;

  AppMode get mode => _mode;
  set mode(AppMode value) {
    _mode = value;
    LinkHub.emit(HubEvent(channel: appModeChannel));
  }
}
