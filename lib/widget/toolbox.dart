import 'package:dissipate/widget/polygon_painter.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/drawing_tool.dart';

class Toolbox extends StatefulWidget {
  final ValueNotifier<DrawingTool> drawingTool;
  final ValueNotifier<bool> showGrid;
  final ValueNotifier<int> polygonSides;

  const Toolbox({
    Key? key,
    required this.drawingTool,
    required this.showGrid,
    required this.polygonSides,
  }) : super(key: key);

  @override
  State<Toolbox> createState() => _ToolboxState();
}

class _ToolboxState extends State<Toolbox> {
  // UndoRedoStack get undoRedoStack => widget.undoRedoStack;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          widget.drawingTool,
          widget.showGrid,
          widget.polygonSides,
        ]),
        builder: (context, _) {
          return Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              controller: scrollController,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    _IconBox(
                      iconData: FontAwesomeIcons.arrowPointer,
                      selected: widget.drawingTool.value == DrawingTool.select,
                      onTap: () => widget.drawingTool.value = DrawingTool.select,
                      tooltip: 'Line',
                    ),
                    _IconBox(
                      iconData: FontAwesomeIcons.penNib,
                      selected: widget.drawingTool.value == DrawingTool.pen,
                      onTap: () => widget.drawingTool.value = DrawingTool.pen,
                      tooltip: 'Line',
                    ),
                    _IconBox(
                      iconData: FontAwesomeIcons.square,
                      selected: widget.drawingTool.value == DrawingTool.box,
                      onTap: () => widget.drawingTool.value = DrawingTool.box,
                      tooltip: 'Square',
                    ),
                    _IconBox(
                      iconData: FontAwesomeIcons.circle,
                      selected: widget.drawingTool.value == DrawingTool.circle,
                      onTap: () => widget.drawingTool.value = DrawingTool.circle,
                      tooltip: 'Circle',
                    ),
                    _IconBox(
                      selected: widget.drawingTool.value == DrawingTool.polygon,
                      onTap: () => widget.drawingTool.value = DrawingTool.polygon,
                      tooltip: 'Polygon',
                      child: CustomPaint(
                        painter: PolygonPainter(
                          sides: widget.polygonSides.value,
                          color: widget.drawingTool.value.isPolygon ? Colors.grey[900]! : Colors.grey,
                          padding: 5
                        )
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: widget.drawingTool.value == DrawingTool.polygon
                      ? Row(
                          children: [
                            const Text(
                              'Sides: ',
                              style: TextStyle(fontSize: 12),
                            ),
                            Slider(
                              value: widget.polygonSides.value.toDouble(),
                              min: 3,
                              max: 8,
                              onChanged: (val) {
                                widget.polygonSides.value = val.toInt();
                              },
                              label: '${widget.polygonSides.value}',
                              divisions: 5,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData? iconData;
  final Widget? child;
  final bool selected;
  final VoidCallback onTap;
  final String? tooltip;

  const _IconBox({
    Key? key,
    this.iconData,
    this.child,
    this.tooltip,
    required this.selected,
    required this.onTap,
  })  : assert(child != null || iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? Colors.grey[800]! : Colors.grey,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(1)),
          ),
          child: Tooltip(
            message: tooltip,
            preferBelow: false,
            child: child ??
                Icon(
                  iconData,
                  color: selected ? Colors.grey[900] : Colors.grey,
                  size: 20,
                ),
          ),
        ),
      ),
    );
  }
}
