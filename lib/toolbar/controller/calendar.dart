import 'dart:html';

import 'package:flutter/material.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:labelling/services/source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarWidget extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  CalendarWidget({Key? key, required this.marketMetadataModel})
      : super(key: key);

  late final SourceService source;
  final MarketMetadataModel marketMetadataModel;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final range = await _onCalendar(context, ref);
        saveIfDateIsCorrect(range, ref);
      },
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
        firstDate: DateTime(2018),
        lastDate: DateTime.now());
    return range;
  }

  void saveIfDateIsCorrect(DateTimeRange? range) {
    if (range == null) return;
    marketMetadataModel.dateRange = range;
    marketMetadataModel.save();
  }
}
