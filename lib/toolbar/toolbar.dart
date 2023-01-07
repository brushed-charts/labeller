import 'package:flutter/material.dart';
import 'package:labelling/toolbar/source_field.dart';
import 'package:labelling/toolbar/calendar.dart';
import 'package:labelling/toolbar/interval.dart';
import 'package:labelling/toolbar/head_and_shoulders.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: Row(children: [
          const SizedBox(width: 30),
          const SourceField(width: 150),
          const SizedBox(width: 30),
          const IntervalSelector(),
          const SizedBox(width: 30),
          CalendarWidget(),
          const SizedBox(width: 30),
          const HeadAndShouldersAnnotation(),
        ]));
  }
}
