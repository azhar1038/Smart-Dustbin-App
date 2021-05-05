import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const GeneralButton({
    Key key,
    this.title = '',
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(title),
      color: Colors.orange,
      onPressed: onPressed,
    );
  }
}
