import 'drawing_tool.dart';

class GlyphOptions {
  final DrawingTool currentTool;
  final bool showGrid;

  const GlyphOptions({
    required this.currentTool,
    required this.showGrid,
  });
}