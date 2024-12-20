enum DrawingTool {
  select,
  pen,
  box,
  circle,
  polygon;

  bool get isSelect => this == DrawingTool.select;
  bool get isPen => this == DrawingTool.pen;
  bool get isBox => this == DrawingTool.box;
  bool get isCircle => this == DrawingTool.circle;
  bool get isPolygon => this == DrawingTool.polygon;

}
