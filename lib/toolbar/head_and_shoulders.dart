import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../services/appmode.dart';

class HeadAndShouldersAnnotation extends StatefulWidget {
  const HeadAndShouldersAnnotation({Key? key}) : super(key: key);

  @override
  createState() => _HeadAndShouldersAnnotationState();
}

class _HeadAndShouldersAnnotationState
    extends State<HeadAndShouldersAnnotation> {
  bool isSelected = false;

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
    setState(() => isSelected = !isSelected);
    AppModeService.mode =
        (isSelected) ? AppMode.headAndShoulders : AppMode.free;
  }

  Color _getIconColor(BuildContext context) {
    return isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).disabledColor;
  }
}
