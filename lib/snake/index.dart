import 'dart:math';

import 'package:flutter/material.dart';

import 'config/config.dart';
import 'controller/snake_controller.dart';
import 'view/bg.dart';
import 'view/snake.dart';

class SnakeScreen extends StatefulWidget {
  @override
  _SnakeScreenState createState() => _SnakeScreenState();
}

class _SnakeScreenState extends State<SnakeScreen>
    with SingleTickerProviderStateMixin {
  late SnakeController snakeController;
  final score = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    snakeController = SnakeController(Config.size, this);
  }

  @override
  void dispose() {
    snakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.background,
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          final canvas = Stack(
            children: [
              const Bg(),
              Snake(snakeController: snakeController),
            ],
          );

          final scoreBoard = Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Score: ${snakeController.score}', //todo refresh
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );

          if (orientation == Orientation.landscape) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                canvas,
                scoreBoard,
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                canvas,
                scoreBoard,
              ],
            );
          }
        },
      ),
    );
  }
}
