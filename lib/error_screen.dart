import 'package:flutter/material.dart';
import 'package:labelling/model/chart_state.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({required this.chartStateModel, Key? key})
      : super(key: key);

  static const defaultOKText = "No error occured, everything is fine";
  static const defaultErrorText = "An error occured";
  final ChartStateModel chartStateModel;

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> implements Observer {
  @override
  void initState() {
    widget.chartStateModel.subscribe(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messageToDisplay = getAppropriateErrorMessage();
    return Center(child: Text(messageToDisplay));
  }

  String getAppropriateErrorMessage() {
    if (widget.chartStateModel.state != ChartViewState.error) {
      return ErrorScreen.defaultOKText;
    }
    return widget.chartStateModel.explanation ?? ErrorScreen.defaultErrorText;
  }

  @override
  void onObservableEvent(Observable observable) {
    if (observable is! ChartStateModel) return;
    setState(() {
      /* update on observable event */
    });
  }
}
