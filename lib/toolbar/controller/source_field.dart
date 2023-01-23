import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labelling/model/source_model.dart';
import 'package:labelling/services/source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SourceField extends ConsumerStatefulWidget {
  final double width;
  const SourceField({this.width = 90, Key? key}) : super(key: key);

  @override
  SourceFieldState createState() => SourceFieldState();
}

class SourceFieldState extends ConsumerState<SourceField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = ref.watch(sourceModelProvider);
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
    setState(() => SourceService.rawSource = rawSource);
    SourceService.update();
    _savePref();
  }

  Future<void> _savePref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('rawSource', SourceService.rawSource ?? '');
  }
}
