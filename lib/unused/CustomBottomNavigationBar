import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrient/home_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final PageController pageController;

  CustomBottomNavigationBar({required this.pageController});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 2; // Default to the middle item

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.85,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration:  BoxDecoration(
          color: Colors.black,
         borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.chat_bubble_outline, 0),
            _buildNavItem(Icons.chat, 1),
            _buildNavItem(Icons.home, 2, isSpecial: true),
            _buildNavItem(Icons.favorite_border, 3),
            _buildNavItem(Icons.person_outline, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, {bool isSpecial = false}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        backgroundColor: _selectedIndex == index
            ? (isSpecial ? Colors.orange : Colors.grey[700])
            : Colors.transparent,
        radius: isSpecial ? 30.0 : 25.0,
        child: Icon(
          icon,
         // size: 15,
          color: _selectedIndex == index ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
