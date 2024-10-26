enum DrawingTool {
  select,
  pen,
  box,
  circle,
  polygon;

  bool get isLine => this == DrawingTool.pen;
  bool get isSelect => this == DrawingTool.select;
  bool get isBox => this == DrawingTool.box;
  bool get isCircle => this == DrawingTool.circle;
  bool get isPolygon => this == DrawingTool.polygon;

}
