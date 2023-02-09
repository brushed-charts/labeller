import 'package:flutter_test/flutter_test.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:labelling/storage/preference/preference_io.dart';
import 'package:mocktail/mocktail.dart';

class MockMarketMetadataModel extends Mock implements MarketMetadataModel {}

class MockChartModel extends Mock implements ChartModel {
  final marketMetadataModel = MockMarketMetadataModel();
}

class MockPreferenceIO extends Mock implements PreferenceIO {}

void main() {
  test("Assert query Controller call QueryMaker", () {
    final marketMetadata = MarketMetadataModel(MockPreferenceIO());
    final controller = ChartController(marketMetadata);
    marketMetadata.notify();
    controller.onMarketMetadataChange();
    expect(controller.isOk, isTrue);
  });
}

class ChartController implements Observer {
  ChartController(MarketMetadataModel chartmodel) : _chartModel = chartmodel {
    _.subscribe(this);
  }

  final MarketMetadataModel _chartModel;

  bool isOk = false;
  void onMarketMetadataChange() {
    isOk = true;
  }

   
    
      @override
      void onObservableEvent(Observable observable) {
     if (observable is! MarketMetadataModel) return;
    onMarketMetadataChange();
      }
  }
}
