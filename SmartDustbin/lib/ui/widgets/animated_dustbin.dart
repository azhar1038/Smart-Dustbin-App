import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_dustbin/ui/widgets/loader.dart';

class AnimatedDustbin extends StatefulWidget {
  final double height;
  final double width;
  final double trashLevel;
  final bool isBusy;

  const AnimatedDustbin({
    Key key,
    this.height = 250,
    this.width = 200,
    this.trashLevel = 1,
    this.isBusy = false,
  })  : assert(trashLevel >= 0 && trashLevel <= 1),
        super(key: key);

  @override
  _AnimatedDustbinState createState() => _AnimatedDustbinState();
}

class _AnimatedDustbinState extends State<AnimatedDustbin>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _trashLevelAnimation;
  Animation<Color> _binColorAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _setUpAnimation(0, widget.trashLevel);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedDustbin oldWidget) {
    if (oldWidget.trashLevel != widget.trashLevel) {
      _setUpAnimation(oldWidget.trashLevel, widget.trashLevel);
      // } else if (!oldWidget.isBusy && widget.isBusy) {
      //   _setUpAnimation(widget.trashLevel, 0);
      // } else if (oldWidget.isBusy && !widget.isBusy) {
      //   _setUpAnimation(0, widget.trashLevel);
    }
    super.didUpdateWidget(oldWidget);
  }

  Color _getColor(double level) {
    Color color;
    if (level < 0.5)
      color = Colors.green;
    else if (level < 0.8)
      color = Colors.orange;
    else
      color = Colors.red;
    return color;
  }

  void _setUpAnimation(double beginLevel, double endLevel) {
    _controller.value = 0;
    _trashLevelAnimation =
        Tween<double>(begin: beginLevel, end: endLevel).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _controller,
      ),
    );
    _binColorAnimation = ColorTween(
      begin: _getColor(beginLevel),
      end: _getColor(endLevel),
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _controller,
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        int trashPercent = (_trashLevelAnimation.value * 100).round();
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Stack(
            children: [
              CustomPaint(
                painter: DustbinPainter(
                  height: widget.height,
                  width: widget.width,
                  level: _trashLevelAnimation.value,
                  color: _binColorAnimation.value,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: widget.isBusy
                    ? Loader()
                    : RichText(
                        text: TextSpan(
                          text: "$trashPercent",
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xff242424),
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: " %",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DustbinPainter extends CustomPainter {
  final double level;
  final double height;
  final double width;
  final Color color;

  DustbinPainter({
    this.level = 0,
    @required this.height,
    @required this.width,
    @required this.color,
  });

  static const double THETA = 83;
  static const double CAP_HEIGHT = 16;
  static const double SIDE_GAP = 16;
  static const double HANDLE_WIDTH = 30;

  final double tanTheta = tan(THETA * 0.0175);

  @override
  void paint(Canvas canvas, Size size) {
    _drawBinBody(canvas);
    _drawBinCap(canvas);
    _drawTrashLevel(canvas);
  }

  void _drawBinBody(Canvas canvas) {
    final binBodyPaint = Paint();
    binBodyPaint.color = color;
    binBodyPaint.strokeWidth = 8;
    binBodyPaint.strokeCap = StrokeCap.round;
    binBodyPaint.strokeJoin = StrokeJoin.round;
    binBodyPaint.style = PaintingStyle.stroke;

    final binBodyPath = Path();
    double x;
    x = width / 6 - (height - CAP_HEIGHT) / tanTheta;
    x = x < 0 ? 0 : x;
    x += SIDE_GAP;
    binBodyPath.moveTo(x, CAP_HEIGHT);
    x = width / 6 + SIDE_GAP;
    binBodyPath.lineTo(x, height);
    x = 5 / 6 * width - SIDE_GAP;
    x = x < 0 ? 0 : x;
    binBodyPath.lineTo(x, height);
    x = 5 / 6 * width + (height - CAP_HEIGHT) / tanTheta;
    x = x > width ? width : x;
    x -= SIDE_GAP;
    binBodyPath.lineTo(x, CAP_HEIGHT);
    canvas.drawPath(binBodyPath, binBodyPaint);
  }

  void _drawBinCap(Canvas canvas) {
    final binCapPaint = Paint();
    binCapPaint.color = color;
    binCapPaint.style = PaintingStyle.fill;

    double x, y;
    double curveSize = 4;
    final binCapPath = Path();
    binCapPath.moveTo(curveSize, CAP_HEIGHT);
    binCapPath.lineTo(width - curveSize, CAP_HEIGHT);
    binCapPath.quadraticBezierTo(
        width, CAP_HEIGHT, width, CAP_HEIGHT - curveSize);
    y = CAP_HEIGHT / 2;
    binCapPath.lineTo(width, y + curveSize);
    binCapPath.quadraticBezierTo(width, y, width - curveSize, y);
    x = (width + HANDLE_WIDTH) / 2;
    y = CAP_HEIGHT / 2;
    binCapPath.lineTo(x, y);
    binCapPath.lineTo(x, curveSize);
    binCapPath.quadraticBezierTo(x, 0, x - curveSize, 0);
    x = (width - HANDLE_WIDTH) / 2;
    binCapPath.lineTo(x + curveSize, 0);
    binCapPath.quadraticBezierTo(x, 0, x, curveSize);
    binCapPath.lineTo(x, y);
    binCapPath.lineTo(curveSize, y);
    binCapPath.quadraticBezierTo(0, y, 0, y + curveSize);
    binCapPath.lineTo(0, CAP_HEIGHT - curveSize);
    binCapPath.quadraticBezierTo(0, CAP_HEIGHT, curveSize, CAP_HEIGHT);
    binCapPath.close();
    canvas.drawPath(binCapPath, binCapPaint);
  }

  void _drawTrashLevel(Canvas canvas) {
    final binBodyPaint = Paint();
    binBodyPaint.color = color.withOpacity(0.6);

    final double trashHeight = (height - CAP_HEIGHT) * level;
    final double gap = 8;

    final binBodyPath = Path();
    double x, y;
    x = width / 6 - (trashHeight - CAP_HEIGHT) / tanTheta;
    x = x < 0 ? 0 : x;
    x += SIDE_GAP + gap;
    y = height - trashHeight + gap / 2;
    y = y > height - gap ? height - gap : y;
    binBodyPath.moveTo(x, y);
    x = width / 6 + SIDE_GAP + gap;
    binBodyPath.lineTo(x, height - gap);
    x = 5 / 6 * width - SIDE_GAP - gap;
    x = x < 0 ? 0 : x;
    binBodyPath.lineTo(x, height - gap);
    x = 5 / 6 * width + (trashHeight - CAP_HEIGHT) / tanTheta;
    x = x > width ? width : x;
    x -= SIDE_GAP + gap;
    binBodyPath.lineTo(x, y);
    canvas.drawPath(binBodyPath, binBodyPaint);
  }

  @override
  bool shouldRepaint(DustbinPainter oldDelegate) {
    return level != oldDelegate.level;
  }
}
