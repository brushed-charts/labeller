import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labelling/services/appmode.dart';
import 'package:labelling/services/source.dart';
import 'package:provider/provider.dart';

class SelectionMode extends StatefulWidget {
  const SelectionMode({Key? key}) : super(key: key);

  @override
  _SelectionModeState createState() => _SelectionModeState();
}

class _SelectionModeState extends State<SelectionMode> {
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
    // AppModeService = (isSelected) ? AppMode.selection : AppMode.free;
  }

  Color _getIconColor(BuildContext context) {
    return isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).disabledColor;
  }
}
