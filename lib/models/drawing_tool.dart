enum DrawingTool {
  select,
  line;

  bool get isLine => this == DrawingTool.line;
  bool get isSelect => this == DrawingTool.select;
}
