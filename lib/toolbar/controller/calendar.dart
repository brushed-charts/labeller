import 'package:flutter/material.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/services/source.dart';

class CalendarWidget extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  CalendarWidget({Key? key, required this.marketMetadataModel})
      : super(key: key);

  late final SourceService source;
  final MarketMetadataModel marketMetadataModel;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _onCalendar(context),
      iconSize: 25,
      icon: Icon(
        Icons.calendar_today_sharp,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _onCalendar(BuildContext context) async {
    final range = await showDateRangePicker(
        context: context,
        initialDateRange: marketMetadataModel.dateRange,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    saveIfDateIsCorrect(range);
  }

  void saveIfDateIsCorrect(DateTimeRange? range) {
    if (range == null) return;
    marketMetadataModel.dateRange = range;
    marketMetadataModel.save();
  }
}
