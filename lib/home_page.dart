import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrient/container_animation.dart';
import 'package:nutrient/text_animation.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  double _animatedWidth = 0;
  double _animatedOpacity = 0;
  final String _profilePic = "https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg";
  double _circleSize = 0;
  double _hiMarina = 0;
  double _letsSelect = 0;
  late AnimationController _controller;
   Animation<int>? _circleAnimation;
   Animation<int>? _squareAnimation;
  late NumberFormat _numberFormat;
  final int _circleTargetNumber = 1034;
  final int _squareTargetAnimation = 2212;
  double circleAndSquareContainers = 0;
  bool _animateCircleSquareTexts = false;
  OverlayEntry? _overlayEntry;

  _firstContainer(){
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        _circleSize = 60;
        _animatedWidth = MediaQuery.of(context).size.width*0.5;
      });
    }).then((v){
     Future.delayed(Duration(milliseconds: 2000), (){
       setState(() {
         _animatedOpacity = 1;
       });
     });
    });
  }
  void _circleAndSquareContainerFunc(){
     Future.delayed(Duration(seconds: 3),(){
      setState(() {
        circleAndSquareContainers = MediaQuery.of(context).size.width*0.45;
        _animateCircleSquareTexts = true;
      });
      _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2), // Adjust duration as needed
      );


      _circleAnimation = IntTween(begin: 0, end: _circleTargetNumber).animate(_controller)
        ..addListener(() {
          setState(() {}); // Rebuild the widget with the new value
        });
      _squareAnimation = IntTween(begin: 0, end: _squareTargetAnimation).animate(_controller)
        ..addListener(() {
          setState(() {}); // Rebuild the widget with the new value
        });
      _numberFormat = NumberFormat("#,##0", "en_US");
      _controller.forward();
    });
  }


  _wordsBelowFirstContainer(){
    Future.delayed(Duration(milliseconds: 1500),(){
      setState(() {
        _hiMarina = MediaQuery.of(context).size.width*0.1;

      });
    });
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        _letsSelect = MediaQuery.of(context).size.width*0.11;
      });
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstContainer();
    _wordsBelowFirstContainer();
    _circleAndSquareContainerFunc();
  }


  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Color orangeColor = Color(0xFFFFA726);
    Color beigeColor = Color(0xFFFFE0B2);
    Color veryLightGreyColor = Color(0xffF5F5F5);
    Color brownGrayColor = Color(0xFF8D6E63);
    String circleFormatNumber = '0';
    String squareFormatNumber = '0';
    if(_circleAnimation != null){
     circleFormatNumber = _numberFormat.format(_circleAnimation!.value).replaceAll(',', ' ');
      squareFormatNumber = _numberFormat.format(_squareAnimation!.value).replaceAll(',', ' ');
    }
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              veryLightGreyColor,
              beigeColor.withOpacity(0.6),
              brownGrayColor,
            ],
            stops: [0.3, 0.7, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width*0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainerWidget(
                        padding: EdgeInsets.all(12),
                        duration: const Duration(milliseconds: 1400),
                        width: _animatedWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                        ),
                      child: AnimatedOpacity(
                        opacity: _animatedOpacity,
                        duration: const Duration(milliseconds: 600),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.location_on, color: brownGrayColor,),
                            ),
                            Text('Saint Petersburg',
                              style: TextStyle(
                                  color: brownGrayColor
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                   AnimatedContainerWidget(
                       padding: EdgeInsets.zero,
                       duration: const Duration(seconds: 1),
                       height: _circleSize,
                       width: _circleSize,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(40),
                         image: DecorationImage(
                             image: NetworkImage(_profilePic)
                         )
                     ),
                   )
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                AnimatedContainerWidget(
                    padding: EdgeInsets.zero,
                    duration: const Duration(seconds: 1),
                    height: _hiMarina,
                    decoration: const BoxDecoration(),
                  child: Text('Hi, Marina',
                    style: TextStyle(
                      color: brownGrayColor,
                      fontSize: 25,
                    ),
                  ),
                ),
                AnimatedContainerWidget(
                  padding: EdgeInsets.zero,
                  duration: const Duration(seconds: 1),
                  height: _letsSelect,
                  decoration: const BoxDecoration(),
                  child: const Text('let\'s select your',
                    style: TextStyle(
                      fontSize: 35,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                AnimatedContainerWidget(
                  padding: EdgeInsets.zero,
                  duration: const Duration(seconds: 1),
                  height: _letsSelect,
                  decoration: const BoxDecoration(),
                  child: const Text('perfect place',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    AnimatedContainerWidget(
                        padding: EdgeInsets.all(12),
                        duration: Duration(seconds: 1),
                        height: circleAndSquareContainers,
                        width:  circleAndSquareContainers,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(120),
                          color: orangeColor
                        ),
                      child:  Center(
                        child: Column(
                          children: [
                            TextAnimation(
                                boolAnimate: _animateCircleSquareTexts,
                                number: 14,
                                color: Colors.white,
                                text: 'BUY'
                            ),
                            AnimatedContainer(
                              height: _animateCircleSquareTexts?MediaQuery.of(context).size.width*0.1:1,
                              duration: const Duration(seconds: 1),
                            ),
                            TextAnimation(
                                boolAnimate: _animateCircleSquareTexts,
                                number: 34,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                text: _circleAnimation!= null?
                                circleFormatNumber:'0'
                            ),
                            TextAnimation(
                                boolAnimate: _animateCircleSquareTexts,
                                number: 14,
                                color: Colors.white,
                                text: 'offers'
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: AnimatedContainerWidget(
                        padding: EdgeInsets.all(12),
                        duration: Duration(seconds: 1),
                        height: circleAndSquareContainers,
                        width:  circleAndSquareContainers,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white
                        ),
                        child:  Center(
                          child: Column(
                            children: [
                             // Text(_animateCircleSquareTexts.toString()),
                              TextAnimation(
                                  boolAnimate: _animateCircleSquareTexts,
                                  number: 14,
                                  color: brownGrayColor,
                                  text: 'RENT'
                              ),
                              AnimatedContainer(
                                height: _animateCircleSquareTexts?MediaQuery.of(context).size.width*0.1:1,
                                duration: const Duration(seconds: 1),
                              ),
                              TextAnimation(
                                  boolAnimate: _animateCircleSquareTexts,
                                  number: 34,
                                  color: brownGrayColor,
                                  fontWeight: FontWeight.w600,
                                  text: _squareAnimation!= null?
                                  squareFormatNumber:'0'
                              ),
                              TextAnimation(
                                  boolAnimate: _animateCircleSquareTexts,
                                  number: 14,
                                  color: brownGrayColor,
                                  text: 'offers'
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        )
      ),
    );
  }
}
