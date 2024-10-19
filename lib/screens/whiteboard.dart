import 'package:flutter/material.dart';

class Whiteboard extends StatefulWidget {
  const Whiteboard({Key? key}) : super(key: key);

  @override
  State<Whiteboard> createState() => _WhiteboardState();
}

class _WhiteboardState extends State<Whiteboard> {
  List<Offset> points = [];
  List<BezierCurve> curves = [];
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;
  bool _drawingBezier = false;
  BezierCurve? _activeCurve;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onTapUp: _onTapUp,
      onLongPressStart: _onLongPressStart,
      onLongPressMoveUpdate: _onLongPressMoveUpdate,
      onLongPressEnd: _onLongPressEnd,
      child: Container(
        color: Colors.white,  // White background
        child: CustomPaint(
          painter: WhiteboardPainter(points, curves, _scale, _offset),
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

  void _onTapUp(TapUpDetails details) {
    setState(() {
      final transformedPoint = (details.localPosition - _offset) / _scale;
      if (points.isEmpty || _drawingBezier) {
        points.add(transformedPoint);
        if (_drawingBezier && _activeCurve != null) {
          curves.add(_activeCurve!);
        }
        _drawingBezier = false;
        _activeCurve = null;
      } else if (points.length == 1) {
        points.add(transformedPoint);
      } else {
        points.clear();
      }
    });
  }

  void _onLongPressStart(LongPressStartDetails details) {
    setState(() {
      final transformedPoint = (details.localPosition - _offset) / _scale;
      if (points.length == 2) {
        _drawingBezier = true;
        _activeCurve = BezierCurve(start: points[0], end: points[1], control1: transformedPoint);
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
  final List<Offset> points;
  final List<BezierCurve> curves;
  final double scale;
  final Offset offset;

  WhiteboardPainter(this.points, this.curves, this.scale, this.offset);

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
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    // Draw points and lines
    if (points.length >= 2) {
      canvas.drawLine(points[0], points[1], paint);
    }

    // Draw curves
    for (var curve in curves) {
      final path = Path();
      path.moveTo(curve.start.dx, curve.start.dy);
      if (curve.control1 != null && curve.control2 != null) {
        path.cubicTo(
          curve.control1!.dx, curve.control1!.dy,
          curve.control2!.dx, curve.control2!.dy,
          curve.end.dx, curve.end.dy,
        );
        canvas.drawPath(path, paint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
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