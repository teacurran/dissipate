import 'package:dissipate/models/glyph_options.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class Whiteboard extends StatefulWidget {
  final GlyphOptions options;

  const Whiteboard({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  State<Whiteboard> createState() => _WhiteboardState();
}

class _WhiteboardState extends State<Whiteboard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  List<Point> points = [];
  List<BezierCurve> curves = [];
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;
  bool _drawingBezier = false;
  BezierCurve? _activeCurve;
  List<Point> selectedPoints = [];
  bool isDragging = false;

  Offset squareSelectTopLeft = Offset.zero;
  Offset squareSelectBottomRight = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onScaleStart: onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onLongPressStart: onLongPressStart,
          onLongPressMoveUpdate: _onLongPressMoveUpdate,
          onLongPressEnd: _onLongPressEnd,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Container(
                color: Colors.white, // White background
                child: CustomPaint(
                  painter: WhiteboardPainter(
                      points, curves, selectedPoints, _scale, _offset, squareSelectTopLeft, squareSelectBottomRight, _animation.value),
                  size: Size.infinite,
                ),
              );
            },
        )
    );
  }

  void onScaleStart(ScaleStartDetails details) {
    _previousScale = _scale;
    _previousOffset = details.focalPoint - _offset;
    // if (selectedPoints.isNotEmpty) {
    //   isDragging = true;
    // }
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (isDragging && selectedPoints.isNotEmpty) {
      setState(() {
        for (var point in selectedPoints) {
          var newOffset = (event.localPosition - _offset) / _scale;
          if (point.curves.isNotEmpty) {
            for (var curve in point.curves) {
              if (curve != null) {
                if (curve.start == point.offset) {
                  curve.start = newOffset;
                  if (curve.controlStart != null) {
                    curve.controlStart = (curve.controlStart! - _offset) / _scale;
                  }
                }
                if (curve.end == point.offset) {
                  curve.end = newOffset;
                  if (curve.controlEnd != null) {
                    curve.controlEnd = (curve.controlEnd! - _offset) / _scale;
                  }
                }
              }
            }
          }
          point.offset = newOffset;
        }
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (isDragging && selectedPoints.isNotEmpty) {
      setState(() {
        for (var point in selectedPoints) {
          var newOffset = (details.localPosition - _offset) / _scale;
          if (point.curves.isNotEmpty) {
            for (var curve in point.curves) {
              if (curve != null) {
                if (curve.start == point.offset) {
                  curve.start = newOffset;
                  if (curve.controlStart != null) {
                    curve.controlStart = (curve.controlStart! - _offset) / _scale;
                  }
                }
                if (curve.end == point.offset) {
                  curve.end = newOffset;
                  if (curve.controlEnd != null) {
                    curve.controlEnd = (curve.controlEnd! - _offset) / _scale;
                  }
                }
              }
            }
          }
          point.offset = newOffset;
        }
      });
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    Offset localOffset = (details.localFocalPoint - _offset) / _scale;

    setState(() {
      if (widget.options.currentTool.isPen && isDragging && selectedPoints.isNotEmpty) {
        selectedPoints[0].offset = localOffset;
      } else if (widget.options.currentTool.isSelect && isDragging) {
        if (squareSelectTopLeft != Offset.zero) {
          squareSelectBottomRight = localOffset;
        } else {
          for (var point in selectedPoints) {
            if (point.curves.isNotEmpty) {
              for (var curve in point.curves) {
                if (curve != null) {
                  if (curve.start == point.offset) {
                    curve.start = localOffset;
                    if (curve.controlStart != null) {
                      curve.controlStart = (curve.controlStart! - _offset) / _scale;
                    }
                  }
                  if (curve.end == point.offset) {
                    curve.end = localOffset;
                    if (curve.controlEnd != null) {
                      curve.controlEnd = (curve.controlEnd! - _offset) / _scale;
                    }
                  }
                }
              }
            }
            point.offset = localOffset;
          }
          // _scale = _previousScale * details.scale;
          // _offset = details.focalPoint - _previousOffset;
        }
        squareSelectBottomRight = localOffset;
      } else {
        _scale = _previousScale * details.scale;
        _offset = details.focalPoint - _previousOffset;
      }

      // _scale = _previousScale * details.scale;
      // _offset = details.focalPoint - _previousOffset;
      // if (isDragging) {
      //   selectedPoints[0].offset = (details.localFocalPoint - _offset) / _scale;
      // }
    });
  }

  void onTapUp(TapUpDetails details) {
    setState(() {
      isDragging = false;
    });
  }

  void onTapDown(TapDownDetails details) {
    setState(() {
      final transformedPoint = Point((details.localPosition - _offset) / _scale, []);

      if (widget.options.currentTool.isPen) {
        points.add(transformedPoint);

        // if there is a single point selected, connect to it
        if (selectedPoints.isNotEmpty && selectedPoints.length == 1) {
          var previousPoint = selectedPoints[0];
          if (previousPoint.curves.isEmpty || previousPoint.curves.length == 1) {
            var bc = BezierCurve(start: previousPoint.offset, end: transformedPoint.offset);
            previousPoint.curves.add(bc);
            transformedPoint.curves.add(bc);
            curves.add(bc);
          }
        }

        selectedPoints = [transformedPoint];
        isDragging = true;
      }

      if (widget.options.currentTool.isSelect) {
        selectedPoints = [];

        for (var point in points) {
          if (transformedPoint.offset.dx > point.offset.dx - 5 &&
              transformedPoint.offset.dx < point.offset.dx + 5 &&
              transformedPoint.offset.dy > point.offset.dy - 5 &&
              transformedPoint.offset.dy < point.offset.dy + 5) {
            selectedPoints.add(point);
          }
        }
        if (selectedPoints.isEmpty) {
          squareSelectTopLeft = transformedPoint.offset;
          squareSelectBottomRight = Offset.zero;
        } else {
          squareSelectTopLeft = Offset.zero;
          squareSelectBottomRight = Offset.zero;
        }

        isDragging = true;
      }
    });
  }

  void onLongPressStart(LongPressStartDetails details) {
    setState(() {
      final transformedPoint = (details.localPosition - _offset) / _scale;
      if (points.length == 2) {
        _drawingBezier = true;
        _activeCurve = BezierCurve(start: points[0].offset, end: points[1].offset, controlStart: transformedPoint);
      }
    });
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    if (_drawingBezier && _activeCurve != null) {
      setState(() {
        _activeCurve!.controlStart = (details.localPosition - _offset) / _scale;
      });
    }
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    if (_drawingBezier && _activeCurve != null) {
      setState(() {
        final transformedPoint = (details.localPosition - _offset) / _scale;
        _activeCurve!.controlEnd = transformedPoint;
      });
    }
  }
}

class WhiteboardPainter extends CustomPainter {
  final List<Point> points;
  final List<BezierCurve> curves;
  final List<Point> selectedPoints;
  final double scale;
  final Offset offset;
  final Offset squareSelectTopLeft;
  final Offset squareSelectBottomRight;
  final double animationValue;

  WhiteboardPainter(this.points, this.curves, this.selectedPoints, this.scale, this.offset, this.squareSelectTopLeft,
      this.squareSelectBottomRight, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);

    // Background color
    canvas.drawRect(
      Rect.fromLTWH(-offset.dx, -offset.dy, size.width / scale, size.height / scale),
      Paint()..color = Colors.white,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    final pointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.pink
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    final selectedPointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    // Draw points and lines
    if (points.length >= 2) {
      canvas.drawLine(points[0].offset, points[1].offset, paint);
    }

    // Draw curves
    for (var curve in curves) {
      final path = Path();
      path.moveTo(curve.start.dx, curve.start.dy);

      var control1 = curve.controlStart;
      var control2 = curve.controlEnd;

      if (control1 == null && control2 != null) {
        control1 = control2;
      } else if (control1 != null && control2 == null) {
        control2 = control1;
      }
      if (control1 != null && control2 != null) {
        path.cubicTo(
          curve.controlStart!.dx,
          curve.controlStart!.dy,
          curve.controlEnd!.dx,
          curve.controlEnd!.dy,
          curve.end.dx,
          curve.end.dy,
        );
        canvas.drawPath(path, paint);
      } else {
        canvas.drawLine(curve.start, curve.end, paint);
      }

      if (control1 != null) {
        canvas.drawCircle(curve.controlStart!, 10, paint);
      }
      if (control2 != null) {
        canvas.drawCircle(curve.controlEnd!, 10, paint);
      }

      // Draw control point
      // canvas.drawCircle(curve.control1!, 10, paint);

      // draw a square for the start and end points
      // for (var point in [curve.start, curve.end]) {
      //   canvas.drawRect(
      //     Rect.fromCenter(center: point, width: 10, height: 10),
      //     pointPaint,
      //   );
      // }
    }

    for (var point in points) {
      var currentPaint = pointPaint;
      if (selectedPoints.contains(point)) {
        currentPaint = selectedPointPaint;
      }
      canvas.drawCircle(point.offset, 5, currentPaint);
    }

    if (squareSelectTopLeft != Offset.zero && squareSelectBottomRight != Offset.zero) {
      _drawAnimatedDashedRect(canvas, squareSelectTopLeft, squareSelectBottomRight, animationValue);
    }

    canvas.restore();
  }

  void _drawAnimatedDashedRect(Canvas canvas, Offset topLeft, Offset bottomRight, double animationValue) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    path.moveTo(topLeft.dx, topLeft.dy);
    path.lineTo(bottomRight.dx, topLeft.dy);
    path.lineTo(bottomRight.dx, bottomRight.dy);
    path.lineTo(topLeft.dx, bottomRight.dy);
    path.close();

    final dashWidth = 5.0;
    final dashSpace = 5.0;
    final totalDashLength = dashWidth + dashSpace;
    final phase = animationValue * totalDashLength;

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[dashWidth, dashSpace]),
        dashOffset: DashOffset.absolute(phase),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Point {
  Offset offset;
  List<BezierCurve?> curves;

  Point(this.offset, this.curves);
}

class BezierCurve {
  Offset start;
  Offset end;
  Offset? controlStart;
  Offset? controlEnd;

  BezierCurve({
    required this.start,
    required this.end,
    this.controlStart,
    this.controlEnd,
  });
}
