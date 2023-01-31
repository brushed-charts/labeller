import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/conditionnal_chart_view.dart';

class Chart extends StateNotifier<ChartViewState> {
  Chart(this.ref) : super(ChartViewState.noData);

  final Ref ref;
}
