import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          color: Colors.grey.shade900,
         borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('assets/search-alt-svgrepo-com.svg', 0),
            _buildNavItem('assets/chat-line-svgrepo-com.svg', 1),
            _buildNavItem('assets/home-9-svgrepo-com.svg', 2,),
            _buildNavItem('assets/heart-alt-svgrepo-com.svg', 3),
            _buildNavItem('assets/profile-svgrepo-com.svg', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, int index,) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        backgroundColor: _selectedIndex == index
            ? Colors.orange
            : Colors.black,
        radius: 22,
        child: SvgPicture.asset(icon, color: Colors.white, height: 24,)
      ),
    );
  }
}
