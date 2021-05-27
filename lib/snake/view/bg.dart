import 'package:flutter/material.dart';
import 'package:flutter_snake/snake/config/config.dart';

class Bg extends StatefulWidget {
  const Bg({Key? key}) : super(key: key);

  @override
  _BgState createState() => _BgState();
}

class _BgState extends State<Bg> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(Config.size, Config.size),
        painter: BgPainter(),
      ),
    );
  }
}

class BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint();

    final gridSize = size.width / Config.gridCount;
    for (var i = 0; i < Config.gridCount; i++) {
      for (var j = 0; j < Config.gridCount; j++) {
        if ((i + j) % 2 == 0) {
          bgPaint.color = Config.deepGreen;
        } else {
          bgPaint.color = Config.lightGreen;
        }
        canvas.drawRect(
          Offset(i * gridSize, j * gridSize) & Size(gridSize, gridSize),
          bgPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
