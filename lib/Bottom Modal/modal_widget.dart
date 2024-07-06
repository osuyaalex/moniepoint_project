import 'package:flutter/material.dart';

class ModalWidget extends StatelessWidget {
  final double mainContainerHeight;
  final double mainContainerWidth;
  final String assetImage;
  final double height;
  final double width;
  final double opacity;
  final String text;
  final double animatedSpaceWidth;
  final bool showText;
  final double textSize;
  const ModalWidget({super.key, required this.mainContainerHeight, required this.mainContainerWidth, required this.assetImage, required this.height, required this.width,required this.opacity, required this.text, required this.animatedSpaceWidth, required this.showText, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: mainContainerHeight,
      width: mainContainerWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          image: DecorationImage(image: AssetImage(assetImage),
              fit: BoxFit.fill
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container()),
          AnimatedContainer(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.only(right: 4),
              duration: Duration(seconds: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  showText?AnimatedOpacity(
                      opacity: opacity,
                      duration: Duration(seconds: 1),
                    child:  Text(text,
                      style:  TextStyle(fontSize: textSize),
                    ),
                  ):Container(),
                  AnimatedContainer(
                      duration: Duration(seconds: 1),
                    width: animatedSpaceWidth,
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    height: height,
                    width: height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),

                    ),
                  )
                ],
              )
          ),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}
