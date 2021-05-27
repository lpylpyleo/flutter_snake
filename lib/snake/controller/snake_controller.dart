import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_snake/snake/config/config.dart';

enum Direction { Up, Down, Left, Right }

class SnakeController with ChangeNotifier {
  final double size;
  final TickerProvider vsync;
  final rand = Random();
  late Ticker _ticker;

  int score = 0;

  /// snake's body coodinates
  late List<Offset> points;

  /// the direction that the snake is forwarding
  Direction _direction = Direction.Right;

  // delta distance in every frame(per 16.67ms)
  double _speed = 3.0;

  // snake's current length
  late double length;

  // snake's head position
  Offset get head => points.last;

  late Offset apple;

  SnakeController(this.size, this.vsync) {
    final w = size / Config.gridCount;
    final center = (Config.gridCount ~/ 2 + 0.5) * w;
    length = Config.initialLength * w;

    points = [
      Offset(center - w * Config.initialLength / 2, center),
      Offset(center + w * Config.initialLength / 2, center),
    ];

    _resetApple();

    _ticker = vsync.createTicker((_) => _tick())..start();
  }

  void _tick() {
    late Offset newHead;
    switch (_direction) {
      case Direction.Up:
        newHead = Offset(head.dx, head.dy - _speed);
        break;
      case Direction.Down:
        newHead = Offset(head.dx, head.dy + _speed);
        break;
      case Direction.Left:
        newHead = Offset(head.dx - _speed, head.dy);
        break;
      case Direction.Right:
        newHead = Offset(head.dx + _speed, head.dy);
        break;
    }
    if (!_isCollided(newHead)) {
      points[points.length - 1] = newHead; // todo: recycle useless points
      _judgeEat();
      notifyListeners();
    }
  }

  bool _isCollided(Offset newHead) {
    if (newHead.dx >= size - Config.snakeWidth / 2 ||
        newHead.dx <= Config.snakeWidth / 2 ||
        newHead.dy >= size - Config.snakeWidth / 2 ||
        newHead.dy <= Config.snakeWidth / 2) {
      _ticker.stop();
      return true;
    }
    return false;
  }

  /// judge if the head can reach the apple
  void _judgeEat() {
    if ((head - apple).distance < Config.appleRadius + Config.snakeWidth / 2) {
      _resetApple();
      length += size / Config.gridCount;
      score++;
    }
  }

  void _resetApple() {
    apple = Offset(
      rand.nextDouble() * (size - Config.snakeWidth * 2) + Config.snakeWidth,
      rand.nextDouble() * (size - Config.snakeWidth * 2) + Config.snakeWidth,
    );
  }

  void changeDirection(Direction newDirection) {
    // if current direction is up, then it cannot set to down,
    // similar for left and right
    if (_direction.index ~/ 2 == newDirection.index ~/ 2) {
      return;
    }
    points.add(head);
    _direction = newDirection;
  }

  @override
  void dispose() {
    _ticker.stop(canceled: true);
    super.dispose();
  }
}
