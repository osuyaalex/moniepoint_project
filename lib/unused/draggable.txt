import 'package:flutter/material.dart';

class DraggableSlider extends StatefulWidget {
  @override
  _DraggableSliderState createState() => _DraggableSliderState();
}

class _DraggableSliderState extends State<DraggableSlider> {
  double _position = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 300.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gladkova St., 25',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Positioned(
              left: _position,
              child: Draggable(
                axis: Axis.horizontal,
                feedback: _buildDraggableCircle(),
                childWhenDragging: Container(),
                onDragEnd: (details) {
                  setState(() {
                    _position = details.offset.dx.clamp(0.0, 260.0);
                  });
                },
                child: _buildDraggableCircle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableCircle() {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(Icons.arrow_forward),
    );
  }
}

void main() => runApp(MaterialApp(
  home: DraggableSlider(),
));
