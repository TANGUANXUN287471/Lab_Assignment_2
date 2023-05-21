import 'package:flutter/material.dart';
import 'package:barterit/screens/profiletabscreen.dart';
import 'package:barterit/screens/posttabscreen.dart';

import 'package:barterit/models/user.dart';
import 'tradetabscreen.dart';
import 'newstabscreen.dart';



class MainScreen extends StatefulWidget {
final User user;

const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Trade";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      TradeTabScreen(user:widget.user),
      PostTabScreen(user:widget.user),
      ProfileTabScreen(user:widget.user),
      NewsTabScreen(user:widget.user)
    ];
  }

  @override
  void dispose() {
    super.dispose();
    //print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.balance,
                ),
                label: "Trade"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.post_add_rounded,
                ),
                label: "Post"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.newspaper,
                ),
                label: "News")
          ]),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 0) {
        maintitle = "Buyer";
      }
      if (_currentIndex == 1) {
        maintitle = "Seller";
      }
      if (_currentIndex == 2) {
        maintitle = "Profile";
      }
      if (_currentIndex == 3) {
        maintitle = "News";
      }
    });
  }
}