import 'package:flutter/material.dart';
import 'package:nutrient/Home/home_page.dart';
import 'package:nutrient/Map%20Page/map_page.dart';
import 'package:nutrient/Bottom%20Modal/modal_content.dart';

import 'bottom_nav.dart';

class ChangePageView extends StatefulWidget {
  const ChangePageView({super.key});

  @override
  State<ChangePageView> createState() => _ChangePageViewState();
}

class _ChangePageViewState extends State<ChangePageView> with SingleTickerProviderStateMixin{
  final PageController _pageController = PageController(initialPage: 2);
  OverlayEntry? _overlayEntry;
  double _bottom = -100; // Initially off the screen
  bool _isModalVisible = true;

  _showBottomModal(){
      Future.delayed(const Duration(milliseconds: 4500),(){
        showGeneralDialog(
          context: context,
          barrierLabel: "Barrier",
          barrierDismissible: false,
          barrierColor: Colors.transparent,
          transitionDuration: Duration(seconds: 1), // Animation duration
          pageBuilder: (context, __, ___) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.41,
                child: Material(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: Column(
                    children: [
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                        ),
                        child: Center(
                          child: Container(
                            width: 40.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          color: Colors.white,
                          child: SingleChildScrollView(child: ModalContent())
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim, __, child) {

            if(anim.status == AnimationStatus.forward){
              return SlideTransition(
                position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim),
                child: child,
              );
            }else{
              return FadeTransition(
                opacity: anim,
                child: child,
              );
            }
          },
        ).then((_){
          // _overlayEntry?.remove();
          // _overlayEntry = null;
        });
        Future.delayed(Duration(milliseconds: 700), (){
          setState(() {
            _bottom = 40; // Adjust this value to bring the bottom nav bar into view
          });
        });
        _showOverlay(context);

      });


  }

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => AnimatedPositioned(
        bottom: _bottom,
        left: 0,
        right: 0,
        duration: const Duration(seconds: 1),
        child: CustomBottomNavigationBar(pageController: _pageController),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideBottomModal() {
    setState(() {
      _isModalVisible = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showBottomModal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if(index == 2){
            _showBottomModal();
            setState(() {
              _isModalVisible = true;
            });
          }else{
            if(_isModalVisible){
              Navigator.pop(context);
            }
            _hideBottomModal();
          }
        },
        children:  [
          MapPage(),
          Center(child: Text('Chat Page', style: TextStyle(fontSize: 24.0))),
          HomePage(),
          Center(child: Text('Favorite Page', style: TextStyle(fontSize: 24.0))),
          Center(child: Text('Profile Page', style: TextStyle(fontSize: 24.0))),
          Center(child: Text('Profile Page', style: TextStyle(fontSize: 24.0))) // Added MapPage
        ],
      ),
    );
  }
}
