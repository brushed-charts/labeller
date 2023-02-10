import 'package:flutter/material.dart';
import 'package:labelling/toolbar/controller/source_field.dart';
import 'package:labelling/toolbar/controller/calendar.dart';
import 'package:labelling/toolbar/controller/interval.dart';
import 'package:labelling/toolbar/controller/head_and_shoulders.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({Key? key}) : super(key: key);

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
          const HeadAndShouldersAnnotation(),
        ]));
  }
}
