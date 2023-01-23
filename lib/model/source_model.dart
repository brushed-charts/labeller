import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:labelling/storage/preference/preference_io_interface.dart';

final sourceModelProvider = StateNotifierProvider<SourceModel, String>(
    (_) => SourceModel(PreferenceIO()));

class SourceModel extends StateNotifier<String> {
  SourceModel(this.preferenceStorage) : super(defaultSource) {
    refresh();
  }

  static const defaultSource = 'OANDA:EUR_USD';
  final PreferenceIOInterface preferenceStorage;
  String get broker => state.split(':')[0].toLowerCase();
  String get assetPair => state.split(':')[1].toLowerCase();

  Future<void> refresh() async {
    state = (await preferenceStorage.load('source')) ?? defaultSource;
  }

  Future<void> save() async {
    await preferenceStorage.write('source', state);
  }
}
