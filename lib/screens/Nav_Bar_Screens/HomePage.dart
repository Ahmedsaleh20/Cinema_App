import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:movie_app/screens/OtherScreens/Constants.dart';
 import 'package:movie_app/providers/Movies_Provider.dart';
 import 'package:movie_app/screens/OtherScreens/AboutUs.dart';
import 'package:movie_app/screens/Nav_Bar_Screens/HomeScreenSettings.dart';
import 'package:movie_app/screens/Nav_Bar_Screens/HomeScreenSignOut.dart';
import 'HomeScreenHome.dart';
 import 'favorites/HomeScreenFavorites.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  void selectedWidget(int _currentIndex) {
    setState(() {
      selectedPage = _currentIndex;
    });
  }

  List<Widget> widgets = [
    HomeScreenHome(),
    HomeScreenFavorites(),
    AboutUs(),
    HomeScreenSettings(),
    HomeScreenSignOut(),
  ];

  @override
  Widget build(BuildContext context) {
    Movies_Providers().getDbPath();
    Movies_Providers().geFavoriteDb();
    return Scaffold(
      body: widgets[selectedPage],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: selectedPage,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        backgroundColor: Colors.black,
        onItemSelected: selectedWidget,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon:const Icon(
              Icons.home,
              size: 30,
            ),
            title: Text('Home'.tr,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 17,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold)),
            activeColor: primaryColor,
            textAlign: TextAlign.center,
            inactiveColor: greyColor,
          ),
          BottomNavyBarItem(
              icon:const Icon(Icons.favorite),
              title: Text('likes '.tr,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold)),
              activeColor: primaryColor,
              textAlign: TextAlign.center,
              inactiveColor: greyColor),
          BottomNavyBarItem(
            icon:const Icon(Icons.info),
            title: Text(" About Us".tr,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 17,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold)),
            activeColor: primaryColor,
            inactiveColor: greyColor,
          ),
          BottomNavyBarItem(
              icon:const Icon(Icons.settings),
              title: Text(
                'Settings'.tr,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              activeColor: primaryColor,
              textAlign: TextAlign.center,
              inactiveColor: greyColor),
          BottomNavyBarItem(
              icon:const Icon(Icons.logout),
              title: Text(
                'SignOut'.tr,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              activeColor: primaryColor,
              textAlign: TextAlign.center,
              inactiveColor: greyColor)
        ],
      ),
    );
  }
}
