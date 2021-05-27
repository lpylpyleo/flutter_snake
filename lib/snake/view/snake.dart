import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_snake/snake/config/config.dart';
import 'package:flutter_snake/snake/controller/snake_controller.dart';

class Snake extends StatefulWidget {
  final SnakeController snakeController;

  const Snake({Key? key, required this.snakeController}) : super(key: key);
  @override
  _SnakeState createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  late FocusNode _focusNode;
  late SnakeController snakeController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    snakeController = widget.snakeController;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      onKey: _onKey,
      focusNode: _focusNode,
      child: CustomPaint(
        size: Size(Config.size, Config.size),
        painter: SnakePainter(snakeController),
      ),
    );
  }

  /// 4295426130 - Arrow Up
  /// 4295426129 - Arrow Down
  /// 4295426128 - Arrow Left
  /// 4295426127 - Arrow Right
  Direction? keyId2Direction(num keyId) {
    if (keyId == 4295426130) {
      return Direction.Up;
    } else if (keyId == 4295426129) {
      return Direction.Down;
    } else if (keyId == 4295426128) {
      return Direction.Left;
    } else if (keyId == 4295426127) {
      return Direction.Right;
    }
  }

  void _onKey(RawKeyEvent e) {
    final direction = keyId2Direction(e.logicalKey.keyId);
    if (direction != null) {
      snakeController.changeDirection(direction);
    }
  }
}

class SnakePainter extends CustomPainter {
  final SnakeController controller;

  SnakePainter(this.controller) : super(repaint: controller);
  final snakePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = Config.snakeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..color = Colors.blueAccent;

  final applePaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..addPolygon(controller.points, false);
    final pm = path.computeMetrics().first;
    final snakePath = pm.extractPath(
      pm.length - controller.length,
      pm.length,
    );

    canvas.drawPath(snakePath, snakePaint);
    canvas.drawCircle(controller.apple, Config.appleRadius, applePaint);
  }

  @override
  bool shouldRepaint(covariant SnakePainter oldDelegate) {
    return oldDelegate.controller != controller;
  }
}
