import 'package:firestore_figure_database/figure_converter.dart';
import 'package:grapher_user_draw/draw_tools/draw_tool_interface.dart';
import 'package:labelling/drawTools/head_and_shoulders.dart';

class FigureConverterWithToolGuess extends FigureConverter {
  @override
  DrawToolInterface guessToolUsingItsName(String name) {
    switch (name) {
      case 'head_and_shoulder':
        return HeadAndShouldersDrawTool();
      default:
        throw ArgumentError("Can't guess the tool giving it's name");
    }
  }
}
