import 'package:flutter/material.dart';

class TextAnimation extends StatelessWidget {
  final bool boolAnimate;
  final double number;
  final Color color;
  final FontWeight? fontWeight;
  final String text;
  const TextAnimation({super.key, required this.boolAnimate, required this.number, required this.color,this.fontWeight, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      style: TextStyle(
        fontSize: boolAnimate ? number : 0, // Change the font size
        color: color,
      ),
      duration: Duration(seconds: 1), // Animation duration
      curve: Curves.easeInOut, // Animation curve
      child: Text(text),
    );
  }
}
