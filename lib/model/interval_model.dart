import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:labelling/storage/preference/preference_io_interface.dart';

final intervalModelProvider = StateNotifierProvider<IntervalModel, String>(
    (_) => IntervalModel(PreferenceIO()));

class IntervalModel extends StateNotifier<String> {
  IntervalModel(this.preferenceStorage) : super(IntervalModel.defaultInterval);

  static const defaultInterval = '30m';
  final PreferenceIOInterface preferenceStorage;

  void setInterval(String newState) {
    state = newState;
  }

  Future<void> refresh() async {
    state = (await preferenceStorage.load('interval')) ?? defaultInterval;
  }

  Future<void> save() async {
    await preferenceStorage.write('interval', state);
  }
}
