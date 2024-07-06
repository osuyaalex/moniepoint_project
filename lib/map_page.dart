import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

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

  _expandCircles(){
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        _circle = 35;
        _listCOntainerHeight = 40;
        _listCOntainerWidth = MediaQuery.of(context).size.width*0.45;
      });
    });
    Future.delayed(Duration(milliseconds: 1500),(){
      setState(() {
        _itemOpacity = 1;
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
                          child: SvgPicture.asset('assets/stack-alt-svgrepo-com.svg', height: 20,),
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
                      )
                    ],
                  ),
                ),
              )
          )
        ],
      ):Container(),
    );
  }
}
