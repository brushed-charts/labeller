import 'package:flutter/material.dart';
import 'package:labelling/services/source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SourceField extends StatelessWidget {
  SourceField({Key? key, this.width = 90}) : super(key: key);

  final _controller = TextEditingController();
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: TextField(
          autofocus: true,
          decoration: const InputDecoration(
              isDense: true, contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 10)),
          onSubmitted: _onEdited,
          controller: _controller,
        ));
  }

  void _onEdited(String rawSource) {
    SourceService.rawSource = rawSource;
    SourceService.update();
    _savePref();
  }

  Future<void> _savePref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('rawSource', SourceService.rawSource ?? '');
  }
}
