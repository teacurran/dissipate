import 'package:dissipate/models/glyph_options.dart';
import 'package:dissipate/screens/whiteboard.dart';
import 'package:flutter/material.dart';

import '../models/drawing_tool.dart';
import '../widget/toolbox.dart';
import '../widget/hot_key_listener.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  final ValueNotifier<DrawingTool> drawingTool = ValueNotifier(DrawingTool.pen);

  final GlobalKey canvasGlobalKey = GlobalKey();
  final ValueNotifier<int> polygonSides = ValueNotifier(3);

  final ValueNotifier<bool> showGrid = ValueNotifier(false);

  final Color kCanvasColor = Color(0xfff2f3f7);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCanvasColor,
      body: HotkeyListener(
        onRedo: () {},
        onUndo: () {},
        child: LayoutBuilder(
          builder: (context, constraints) {
              return _buildDesktopView();
          },
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([
            drawingTool,
            polygonSides,
            showGrid,
          ]),
          builder: (context, _) {
            return Whiteboard(
              options: GlyphOptions(
                showGrid: showGrid.value,
                currentTool: drawingTool.value,
              ),
            );
          },
        ),
        Positioned(
          top: kToolbarHeight + 10,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animationController),
            child: Toolbox(
              drawingTool: drawingTool,
              polygonSides: polygonSides,
              showGrid: showGrid,
            ),
          ),
        ),
        _CustomAppBar(animationController: animationController),
      ],
    );
  }

  Widget _buildDesktopView() {
    final toolbox = Toolbox(
      drawingTool: drawingTool,
      polygonSides: polygonSides,
      showGrid: showGrid,
    );

    return Column(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              drawingTool,
              polygonSides,
              showGrid,
            ]),
            builder: (context, _) {
              return Whiteboard(
                options: GlyphOptions(
                  showGrid: showGrid.value,
                  currentTool: drawingTool.value,
                ),
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          child: toolbox,
          decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 1))
        )
      ],
    );
  }
}


class _CustomAppBar extends StatelessWidget {
  final AnimationController animationController;

  const _CustomAppBar({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (animationController.value == 0) {
                  animationController.forward();
                } else {
                  animationController.reverse();
                }
              },
              icon: const Icon(Icons.menu),
            ),
            const Text(
              'Glyph Editor',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
