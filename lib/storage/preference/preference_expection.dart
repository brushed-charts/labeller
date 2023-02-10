import 'dart:io';

class PreferenceException implements IOException {
  String message;
  PreferenceException(this.message);
}
