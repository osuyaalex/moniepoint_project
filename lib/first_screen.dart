import 'dart:async';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>with TickerProviderStateMixin{
  late double _space;
  double _opacity = 0;
  List<String> _textOptions = ['Learn About Stuff', "Do Stuff Quickly", "Learn About More Stuff"];
  int _currentIndex = 0;
  late AnimationController _controller;
  final random = Random();
  Color? _firstColor;
  Color? _secondColor;
  Color? _lastColor;
  List<Color>? _allColors;


  void _animateMargins() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _space = 10;
    });
  }
  void _startTextAnimation() {

    // Animate the text every 3 seconds
    Timer.periodic(Duration(seconds: 3), (timer) {
      _controller.forward(from: 0.0);
      if(mounted){
        setState(() {
          _currentIndex = (_currentIndex + 1) % _textOptions.length;
          _generateNewColors();
        });
      }
    });
  }
  // Separate method to generate new colors
  void _generateNewColors() {
    _firstColor = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    _secondColor = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    _lastColor = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    _allColors = [_firstColor!,_secondColor!, _lastColor!];
  }
  @override
  void initState() {
    super.initState();
    // Initialize the margins with some initial large values.
    _space = 50;
    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
        _opacity = 1.0;
      });
      _startTextAnimation();
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Start the animation after the first frame is rendered.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //
    // });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _firstColor!=null?
          AnimatedOpacity(
            duration: Duration(milliseconds: 600),
            opacity: _opacity,
            child: PageTransitionSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (
                  Widget child,
                  Animation<double> primaryAnimation,
                  Animation<double> secondaryAnimation,
                  ) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.scaled,
                  child: child,
                );
              },
              child:GradientText(_textOptions[_currentIndex],
                  key: ValueKey<int>(_currentIndex),
                  // style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                  colors: _allColors!
              ),
            ),
          ):Container(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height:  MediaQuery.of(context).size.width*0.9,
                  width: MediaQuery.of(context).size.width*0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.yellow.withOpacity(0.4)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Image.asset('assets/AU-KGS-Sachet-WS.png',
                          height:MediaQuery.of(context).size.width*0.5,),
                        SizedBox(height: 10,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Solution To Your Problems',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Expanded(
                            child: SingleChildScrollView(
                              child:Text('Nourishment is the fuel that sustains life. From the nutrients in the foods we eat to the emotional and mental sustenance we receive through human connection, proper nourishment allows us to grow, thrive, and reach our full potential. Nutritious foods provide the vitamins, minerals, proteins, and other compounds our bodies require to function optimally. However, nourishment extends beyond just physical needs. We nourish our minds through learning, creativity, and exploration.',
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 15
                                ),
                              )
                              ,
                            )
                        )
                      ],
                    ),
                  ),
                ),
                VisibilityDetector(
                  key: Key('my-key'),
                  onVisibilityChanged: (visibilityInfo) {
                    double visibleFraction = visibilityInfo.visibleFraction;
                    if (visibleFraction > 0) {
                      // The AnimatedContainer is now visible
                      // Call your function here
                      _animateMargins();
                    }
                  },
                  child: AnimatedContainer(
                      height: _space,
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.easeOut
                  ),
                ),
                AnimatedContainer(
                  height:  MediaQuery.of(context).size.width*0.9,
                  width: _space!=10?MediaQuery.of(context).size.width*0.85:MediaQuery.of(context).size.width*0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.yellow.withOpacity(0.5)
                  ),
                  duration: Duration(milliseconds: 1500),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset('assets/GoodStuff_Trucha_Back_Mockup.webp',
                          height:MediaQuery.of(context).size.width*0.5,),
                        SizedBox(height: 20,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Solution To Your Problems',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,


                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}