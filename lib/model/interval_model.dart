import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:labelling/storage/preference/preference_io_interface.dart';

final intervalModelProvider = StateNotifierProvider<IntervalModel, String>(
    (_) => IntervalModel(PreferenceIO()));

class IntervalModel extends StateNotifier<String> {
  IntervalModel(this.preferenceStorage) : super(IntervalModel.defaultInterval);

  static const defaultInterval = '30m';
  final PreferenceIOInterface preferenceStorage;
  bool isLoaded = false;

  void setInterval(String newState) {
    state = newState;
  }

  Future<void> refresh() async {
    state = (await preferenceStorage.load('interval')) ?? defaultInterval;
    isLoaded = true;
  }

  Future<void> save() async {
    await preferenceStorage.write('interval', state);
  }

  int get intervalToSeconds {
    final number = int.parse(state.substring(0, state.length - 1));
    final unit = state[state.length - 1];
    switch (unit) {
      case 's':
        return number;
      case 'm':
        return number * 60;
      case 'h':
        return number * 60 * 60;
      case 'd':
        return number * 24 * 60 * 60;
      case 'w':
        return number * 7 * 24 * 60 * 60;
      case 'M':
        return number * 730 * 60 * 60;
      case 'y':
        return number * 8760 * 60 * 60;
      default:
        throw FormatException('Interval has not the right syntax ($state) . '
            'Syntax is <number><s|m|h|d|w|M|y>');
    }
  }
}
