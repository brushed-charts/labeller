import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chartViewProvider = Provider((ref) {
  ref.pro continue here 
});

class ConditionnalChartView extends ConsumerWidget {
  const ConditionnalChartView({
    required Widget onData,
    Widget? noData,
    Widget? loading,
    Widget? error,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}
