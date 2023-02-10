import 'package:flutter/material.dart';
import 'package:labelling/model/market_metadata_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';

class SourceField extends StatefulWidget {
  const SourceField(
      {required this.marketMetadataModel, this.width = 90, Key? key})
      : super(key: key);

  final double width;
  final MarketMetadataModel marketMetadataModel;

  @override
  SourceFieldState createState() => SourceFieldState();
}

class SourceFieldState extends State<SourceField> implements Observer {
  final _controller = TextEditingController();

  @override
  void initState() {
    widget.marketMetadataModel.subscribe(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.marketMetadataModel.rawSource;
    return SizedBox(
        width: widget.width,
        child: TextField(
          autofocus: true,
          decoration: const InputDecoration(
              isDense: true, contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 10)),
          onSubmitted: _onEdited,
          controller: _controller,
        ));
  }

  void _onEdited(String rawSource) {
    setState(() => widget.marketMetadataModel.rawSource = rawSource);
    widget.marketMetadataModel.save();
  }

  @override
  void onObservableEvent(Observable observable) {
    if (observable is! MarketMetadataModel) return;
    setState(() {/* Update when metadataModel change*/});
  }
}
