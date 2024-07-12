import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nutrient/Map%20PAge/map_containers.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  String? _mapStyle;
  double _circle = 0;
  double _itemOpacity = 0;
  double _listCOntainerHeight = 0;
  double _listCOntainerWidth = 0;
  double _textFieldHeight = 0;
  double _textFieldWidth = 0;
  double _settingsCircleHeight = 0;
  double _mapContainerHeight = 0;
  double _mapContainerWidth = 0;
  double _mapContainerOpacity = 0;
  double _infoContainerSize = 0;
  double _infoContentOpacity = 0;
  bool _switchIcon = false;
  int _selectedIndex = 1;
  String _selectedIconPath = 'assets/wallet-money-svgrepo-com.svg';
  final List<Map<String, String>> _items = [
    {'icon': 'assets/safety-svgrepo-com.svg', 'text': 'Cosy areas'},
    {'icon': 'assets/wallet-money-svgrepo-com.svg', 'text': 'Price'},
    {'icon': 'assets/trash-bin-minimalistic-svgrepo-com.svg', 'text': 'Infrastructure'},
    {'icon': 'assets/stack-svgrepo-com.svg', 'text': 'Layerless'},
  ];


  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedIconPath = _items[index]['icon']!;
    });
  }

  _expandCircles(){
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        _circle = 35;
        _listCOntainerHeight = 40;
        _listCOntainerWidth = MediaQuery.of(context).size.width*0.45;
        _textFieldHeight = 45;
        _textFieldWidth = MediaQuery.of(context).size.width*0.75;
        _settingsCircleHeight = 45;

      });
    });
    Future.delayed(Duration(milliseconds: 1500),(){
      setState(() {
        _itemOpacity = 1;
      });
    });
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        _mapContainerHeight = 45;
        _mapContainerWidth = 5;
      });
    });
    Future.delayed(Duration(seconds: 3),(){
      setState(() {
        _mapContainerWidth = MediaQuery.of(context).size.width*0.3;
      });
    });
    Future.delayed(Duration(seconds: 4),(){
      setState(() {
        _mapContainerOpacity = 1;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/json/map_style.json').then((string) {
      setState(() {
        _mapStyle = string;
      });
    });
    _expandCircles();

  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_mapStyle != null? Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            style: _mapStyle,
          ),
          Positioned(
              left: 20,
              bottom: MediaQuery.of(context).size.height*0.16,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _infoContainerSize = 135;
                          _infoContentOpacity = 0;
                        });
                        Future.delayed(Duration(seconds: 1),(){
                          setState(() {
                            _infoContentOpacity = 1;
                          });
                        });
                      },
                      child: AnimatedContainer(
                        height: _circle,
                        width: _circle,
                        duration: Duration(seconds: 1),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: AnimatedOpacity(
                          opacity: _itemOpacity,
                          duration: Duration(seconds: 1),
                          child: Center(
                            child: SvgPicture.asset(_selectedIconPath, height: 20,color: Color(0xffF5F5F5),),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    height: _circle,
                    width: _circle,
                    duration: Duration(seconds: 1),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: AnimatedOpacity(
                      opacity: _itemOpacity,
                      duration: Duration(seconds: 1),
                      child: Center(
                        child: SvgPicture.asset('assets/send-svgrepo-com.svg', height: 20,),
                      ),
                    ),
                  )
                ],
              )
          ),
          Positioned(
              left: 20,
              bottom: MediaQuery.of(context).size.height*0.21,
              child: AnimatedContainer(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                height: _infoContainerSize,
                width: _infoContainerSize,
                duration: Duration(milliseconds: 700),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(27),
                ),
                child: _infoContainerSize == 135 ? AnimatedOpacity(
                  opacity: _infoContentOpacity,
                  duration: Duration(milliseconds: 700),
                  child: Column(
                    children: [
                      for (int index = 0; index < _items.length; index++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: GestureDetector(
                            onTap: () {
                             if(_items[index]['text'] == 'Layerless'){
                               setState(() {
                                 _infoContainerSize = 0;

                                 _mapContainerWidth = 40;
                                 _switchIcon = true;
                               });
                               _onItemTap(index);
                             }else{
                               setState(() {
                                 _infoContainerSize = 0;
                                 _mapContainerOpacity = 1;
                                 _mapContainerWidth = MediaQuery.of(context).size.width*0.3;
                                 _switchIcon = false;
                               });
                               _onItemTap(index);
                             }

                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  _items[index]['icon']!,
                                  height: 20,
                                  color: _selectedIndex == index
                                      ? Colors.orange
                                      : Colors.grey.shade400,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _items[index]['text']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _selectedIndex == index
                                        ? Colors.orange
                                        : Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ) : SizedBox.shrink(),
              ),
          ),
          Positioned(
              right: 20,
              bottom: MediaQuery.of(context).size.height*0.16,
              child: AnimatedContainer(
                height: _listCOntainerHeight,
                width: _listCOntainerWidth,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.withOpacity(0.4)
                ),
                duration: Duration(seconds: 1),
                child: AnimatedOpacity(
                  opacity: _itemOpacity,
                  duration: Duration(seconds: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset('assets/menu-alt-1-svgrepo-com.svg', height: 20,),
                      ),
                      const Text('List of varients',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xffF5F5F5)
                      ),
                      ),
                    ],
                  ),
                ),
              )
          ),
          Positioned(
            top: 50,
              left: 20,
              child:Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: _textFieldWidth,
                      height: _textFieldHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset('assets/search-alt-svgrepo-com.svg', height: 10,),
                            ),
                            border: InputBorder.none,
                            hintText: 'Saint Petersburg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    height: _settingsCircleHeight,
                      width: _settingsCircleHeight,
                      duration: Duration(seconds: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/settings-2-svgrepo-com.svg', height: 27,),
                    ),
                  )
                ],
              ),
          ),
          Positioned(
            right: 50,
              bottom: MediaQuery.of(context).size.height*0.5,
              child: MapContainers(
                  height: _mapContainerHeight,
                  width: _mapContainerWidth,
                  opacity: _mapContainerOpacity,
                  text: '13,3 mnP',
                switchIcon: _switchIcon,
              )
          ),
          Positioned(
              right: 70,
              bottom: MediaQuery.of(context).size.height*0.32,
              child: MapContainers(
                  height: _mapContainerHeight,
                  width: _mapContainerWidth,
                  opacity: _mapContainerOpacity,
                  text: '15 mnP',
                switchIcon: _switchIcon,

              )
          ),
          Positioned(
              left: MediaQuery.of(context).size.width*0.13,
              top: MediaQuery.of(context).size.height*0.28,
              child: MapContainers(
                  height: _mapContainerHeight,
                  width: _mapContainerWidth,
                  opacity: _mapContainerOpacity,
                  text: '3,065 mnP',
                switchIcon: _switchIcon,
              )
          ),
          Positioned(
              left: MediaQuery.of(context).size.width*0.13,
              top: MediaQuery.of(context).size.height*0.53,
              child: MapContainers(
                  height: _mapContainerHeight,
                  width: _mapContainerWidth,
                  opacity: _mapContainerOpacity,
                  text: '15,432 mnP',
                switchIcon: _switchIcon,
              )
          ),
          Positioned(
              left: MediaQuery.of(context).size.width*0.17,
              top: MediaQuery.of(context).size.height*0.21,
              child: MapContainers(
                  height: _mapContainerHeight,
                  width: _mapContainerWidth,
                  opacity: _mapContainerOpacity,
                  text: '265 mnP',
                switchIcon: _switchIcon,
              )
          ),
          Positioned(
              right: MediaQuery.of(context).size.width*0.17,
              top: MediaQuery.of(context).size.height*0.3,
              child: MapContainers(
                  height: _mapContainerHeight,
                  width: _mapContainerWidth,
                  opacity: _mapContainerOpacity,
                  text: '265 mnP',
                switchIcon: _switchIcon,
              )
          )
        ],
      ):Container(),
    );
  }
}
