import 'package:labelling/model/drawtool_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/storage/preference/preference_io.dart';

class ChartModel with Observable {
  final DrawToolModel toolModel;
  final MarketMetadataModel marketMetadataModel;

  ChartModel(this.toolModel, this.marketMetadataModel);

  factory ChartModel.initDefault() {
    return ChartModel(DrawToolModel(), MarketMetadataModel(PreferenceIO()));
  }

  @override
  Observable copy() {
    return ChartModel(toolModel, marketMetadataModel);
  }
}
