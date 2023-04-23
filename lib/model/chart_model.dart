import 'package:labelling/model/chart_state.dart';
import 'package:labelling/model/drawtool_model.dart';
import 'package:labelling/fragment/model/fragment_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/storage/preference/preference_io.dart';

class ChartModel {
  ChartModel(this.marketMetadataModel, this.stateModel, this.fragmentModel,
      this.drawToolModel);

  final MarketMetadataModel marketMetadataModel;
  final ChartStateModel stateModel;
  final FragmentModel fragmentModel;
  final DrawToolModel drawToolModel;

  factory ChartModel.initWithDefault() {
    return ChartModel(
      MarketMetadataModel(PreferenceIO()),
      ChartStateModel(),
      FragmentModel(),
      DrawToolModel(),
    );
  }
}
