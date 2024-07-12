import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Duration duration;
  final double? height;
  final double? width;
  final Decoration decoration;
  final Widget? child;

  const AnimatedContainerWidget(
      {super.key, required this.padding, required this.duration, this.height, this.width, required this.decoration, this.child,});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: padding,
      duration: duration,
      height: height,
      width: width,
      decoration: decoration,
      child: child,
    );
  }
}
