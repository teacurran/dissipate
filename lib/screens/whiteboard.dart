import 'package:flutter/material.dart';

class Whiteboard extends StatefulWidget {
  const Whiteboard({Key? key}) : super(key: key);

  @override
  State<Whiteboard> createState() => _WhiteboardState();
}

class _WhiteboardState extends State<Whiteboard> {
  List<Point> points = [];
  List<BezierCurve> curves = [];
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;
  bool _drawingBezier = false;
  BezierCurve? _activeCurve;
  List<Point> selectedPoints = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onTapDown: _onTapDown,
      onLongPressStart: _onLongPressStart,
      onLongPressMoveUpdate: _onLongPressMoveUpdate,
      onLongPressEnd: _onLongPressEnd,
      child: Container(
        color: Colors.white,  // White background
        child: CustomPaint(
          painter: WhiteboardPainter(points, curves, selectedPoints, _scale, _offset),
          size: Size.infinite,
        ),
      ),
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    _previousScale = _scale;
    _previousOffset = details.focalPoint - _offset;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = _previousScale * details.scale;
      _offset = details.focalPoint - _previousOffset;
    });
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      final transformedPoint = Point((details.localPosition - _offset) / _scale, []);
      points.add(transformedPoint);

      if (selectedPoints.isNotEmpty && selectedPoints.length == 1) {
        var previousPoint = selectedPoints[0];
        if (previousPoint.curves.isEmpty || previousPoint.curves.length == 1) {
          var bc = BezierCurve(start: previousPoint.offset, end: transformedPoint.offset);
          previousPoint.curves.add(bc);
          curves.add(bc);
        }
      }

      if (points.isEmpty || _drawingBezier) {
        points.add(transformedPoint);
        if (_drawingBezier && _activeCurve != null) {
          curves.add(_activeCurve!);
        }
        _drawingBezier = false;
        _activeCurve = null;
      } else if (points.length == 1) {
        // points.add(transformedPoint);
        // selectedPoints = [transformedPoint];
      } else {
        // points.clear();
      }

      selectedPoints = [transformedPoint];
    });
  }

  void _onLongPressStart(LongPressStartDetails details) {
    setState(() {
      final transformedPoint = (details.localPosition - _offset) / _scale;
      if (points.length == 2) {
        _drawingBezier = true;
        _activeCurve = BezierCurve(start: points[0].offset, end: points[1].offset, control1: transformedPoint);
      }
    });
  }

  void _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    if (_drawingBezier && _activeCurve != null) {
      setState(() {
        _activeCurve!.control1 = (details.localPosition - _offset) / _scale;
      });
    }
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    if (_drawingBezier && _activeCurve != null) {
      setState(() {
        final transformedPoint = (details.localPosition - _offset) / _scale;
        _activeCurve!.control2 = transformedPoint;
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

  WhiteboardPainter(this.points, this.curves, this.selectedPoints, this.scale, this.offset);

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


      var control1 = curve.control1;
      var control2 = curve.control2;

      if (control1 == null && control2 != null) {
        control1 = control2;
      } else if (control1 != null && control2 == null) {
        control2 = control1;
      }
      if (control1 != null && control2 != null) {
        path.cubicTo(
          curve.control1!.dx, curve.control1!.dy,
          curve.control2!.dx, curve.control2!.dy,
          curve.end.dx, curve.end.dy,
        );
        canvas.drawPath(path, paint);
      } else {
        canvas.drawLine(curve.start, curve.end, paint);
      }

      if (control1 != null) {
        canvas.drawCircle(curve.control1!, 10, paint);
      }
      if (control2 != null) {
        canvas.drawCircle(curve.control2!, 10, paint);
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

    canvas.restore();
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
  final Offset start;
  final Offset end;
  Offset? control1;
  Offset? control2;

  BezierCurve({
    required this.start,
    required this.end,
    this.control1,
    this.control2,
  });
}