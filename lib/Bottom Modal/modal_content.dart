import 'package:flutter/material.dart';
import 'package:nutrient/Bottom%20Modal/modal_widget.dart';

class ModalContent extends StatefulWidget {
  const ModalContent({super.key});

  @override
  State<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  double _height = 0;
  double _width = 0;
  double _opacity = 0;
  double _animatedSpace = 0;
  bool _showText = false;
  double _smallerWidth = 0;
  double _smallerAnimatedSpace = 0;

  _containerHeightAndWidth(){
    Future.delayed(Duration(seconds: 1), (){
      setState(() {
        _height = 35;
        _width = 35;
        _smallerWidth = 35;
      });
    });
    Future.delayed(Duration(seconds: 2), (){
      setState(() {
        _width = MediaQuery.of(context).size.width;
        _smallerWidth = MediaQuery.of(context).size.width*0.4;
      });
    });
    Future.delayed(Duration(seconds: 3), (){
      setState(() {
        _showText = true;
        _animatedSpace = MediaQuery.of(context).size.width*0.15;
        _smallerAnimatedSpace = 5;
        _opacity = 1;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _containerHeightAndWidth();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: ModalWidget(
              mainContainerHeight: MediaQuery.of(context).size.width*0.35,
              mainContainerWidth: MediaQuery.of(context).size.width,
              assetImage: 'assets/SoutholdKitchen2-2f1a1b24b0ff4476858f0b439ef0bdfc.jpeg',
              height: _height,
              width: _width,
              opacity:_opacity,
              text: 'Gladkova St., 25',
            animatedSpaceWidth: _animatedSpace,
            showText: _showText,
            textSize: 14,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: ModalWidget(
                mainContainerHeight: MediaQuery.of(context).size.width*0.8,
                mainContainerWidth: MediaQuery.of(context).size.width*0.47,
                assetImage: 'assets/beautiful-living-room-ideas.jpeg',
                height: _height,
                width: _smallerWidth,
                opacity:_opacity,
                text: 'Gubenero St., 25',
                animatedSpaceWidth: _smallerAnimatedSpace,
                showText: _showText,
                textSize: 9,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: ModalWidget(
                    mainContainerHeight: MediaQuery.of(context).size.width*0.4,
                    mainContainerWidth: MediaQuery.of(context).size.width*0.45,
                    assetImage: 'assets/istockphoto-1066999762-612x612.jpeg',
                    height: _height,
                    width: _smallerWidth,
                    opacity:_opacity,
                    text: 'Trefoleva St., 25',
                    animatedSpaceWidth: _smallerAnimatedSpace,
                    showText: _showText,
                    textSize: 9,
                  ),
                ),
                ModalWidget(
                  mainContainerHeight: MediaQuery.of(context).size.width*0.39,
                  mainContainerWidth: MediaQuery.of(context).size.width*0.45,
                  assetImage: 'assets/master-bedroom-with-woven-bench-kelsey-leigh-768x1134.jpeg',
                  height: _height,
                  width: _smallerWidth,
                  opacity:_opacity,
                  text: 'Glodosky St., 25',
                  animatedSpaceWidth: _smallerAnimatedSpace,
                  showText: _showText,
                  textSize: 9,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
