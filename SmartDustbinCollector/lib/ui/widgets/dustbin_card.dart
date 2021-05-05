import 'package:flutter/material.dart';

class DustbinCard extends StatelessWidget {
  final int percent;
  final String hero;
  final VoidCallback onPressed;

  const DustbinCard({
    Key key,
    @required this.percent,
    @required this.hero,
    this.onPressed,
  }) : super(key: key);

  Color _getColor() {
    Color color;
    if (percent < 50)
      color = Colors.green[200];
    else if (percent < 80)
      color = Colors.orange[200];
    else
      color = Colors.red[200];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: _getColor(),
        child: Hero(
          tag: hero,
          child: Container(
            height: 80,
            width: 80,
            alignment: Alignment.center,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                '$percent %',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
