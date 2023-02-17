import 'package:flutter/material.dart';
import 'package:labelling/model/chart_model.dart';
import 'package:labelling/toolbar/controller/source_field.dart';
import 'package:labelling/toolbar/controller/calendar.dart';
import 'package:labelling/toolbar/controller/interval.dart';
import 'package:labelling/toolbar/controller/head_and_shoulders.dart';

class ToolBar extends StatelessWidget {
  final ChartModel model;
  const ToolBar({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: Row(children: [
          const SizedBox(width: 30),
          SourceField(
              marketMetadataModel: model.marketMetadataModel, width: 150),
          const SizedBox(width: 30),
          IntervalSelector(marketMetadataModel: model.marketMetadataModel),
          const SizedBox(width: 30),
          CalendarWidget(marketMetadataModel: model.marketMetadataModel),
          const SizedBox(width: 30),
          HeadAndShouldersAnnotation(drawToolModel: model.drawToolModel),
        ]));
  }
}
