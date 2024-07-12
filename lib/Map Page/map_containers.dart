import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapContainers extends StatelessWidget {
  final double height;
  final double width;
  final double opacity;
  final String text;
  final bool switchIcon;
  const MapContainers({super.key, required this.height, required this.width, required this.opacity, required this.text, required this.switchIcon});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
        width: width,
        duration: Duration(seconds: 1),
        decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
          bottomRight: Radius.circular(22)
    ),
          color: Colors.orangeAccent
    ),
      child: AnimatedOpacity(
          opacity: opacity,
          duration: Duration(seconds: 1),
        child: Center(
          child: AnimatedSwitcher(
            duration: Duration(seconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child:switchIcon == false? Text(text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12
            ),
            ):SvgPicture.asset('assets/building-svgrepo-com.svg', height: 22,),
          ),
        ),
      ),
    );
  }
}
