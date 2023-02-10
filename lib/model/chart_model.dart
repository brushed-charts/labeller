import 'package:labelling/model/chart_state.dart';
import 'package:labelling/model/drawtool_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/storage/preference/preference_io.dart';

class ChartModel with Observable {
  ChartModel(this.toolModel, this.marketMetadataModel, this.stateModel);

  final DrawToolModel toolModel;
  final MarketMetadataModel marketMetadataModel;
  final ChartStateModel stateModel;

  factory ChartModel.initWithDefault() {
    return ChartModel(
      DrawToolModel(),
      MarketMetadataModel(PreferenceIO()),
      ChartStateModel(),
    );
  }

  @override
  Observable copy() {
    return ChartModel(
        toolModel.copy(), marketMetadataModel.copy(), stateModel.copy());
  }
}
