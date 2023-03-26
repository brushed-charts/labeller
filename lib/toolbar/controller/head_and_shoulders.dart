import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labelling/drawTools/head_and_shoulders.dart';
import 'package:labelling/model/drawtool_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';
import 'package:logging/logging.dart';

class HeadAndShouldersAnnotation extends StatefulWidget {
  const HeadAndShouldersAnnotation({required this.drawToolModel, Key? key})
      : super(key: key);

  static final drawTool = HeadAndShouldersDrawTool();
  final DrawToolModel drawToolModel;

  @override
  createState() => _HeadAndShouldersAnnotationState();
}

class _HeadAndShouldersAnnotationState extends State<HeadAndShouldersAnnotation>
    implements Observer {
  @override
  void initState() {
    widget.drawToolModel.subscribe(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => _onButtonPressed(context),
        iconSize: 30,
        icon: SvgPicture.asset(
          'assets/svg/head_and_shoulders.svg',
          color: _getIconColor(context),
        ));
  }

  void _onButtonPressed(BuildContext context) {
    final logger = Logger('HeadAndShouldersToolbarButton');
    if (widget.drawToolModel.tool == HeadAndShouldersAnnotation.drawTool) {
      widget.drawToolModel.tool = null;
      logger.info('Head and shoulders anotation is disabled');
      return;
    }
    widget.drawToolModel.tool = HeadAndShouldersAnnotation.drawTool;
    logger.info('Head and shoulders anotation is enabled');
  }

  Color _getIconColor(BuildContext context) {
    return widget.drawToolModel.tool == HeadAndShouldersAnnotation.drawTool
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).disabledColor;
  }

  @override
  void onObservableEvent(Observable observable) {
    if (observable is! DrawToolModel) return;
    setState(() {
      /* Update on drawToolModel events */
    });
  }
}
