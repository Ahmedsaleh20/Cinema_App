import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:movie_app/screens/Nav_Bar_Screens/HomePage.dart';

import 'Constants.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  accentColor,
                  primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.45, 0.7],
                tileMode: TileMode.clamp),
          ),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                left: 10,
                right: 10,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacement(
                              MaterialPageRoute(builder: (context) => HomePage(),)
                            ),
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: primaryColor,
                              size: 22,
                            )),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/images/download17.png",
                    width: 400,
                    height: 150,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 10, bottom: 40,top: 30),
                    child: Text(
                      "welcome".tr,
                      style: TextStyle(
                          fontSize: 16.5,
                          color: Colors.grey.shade50,
                          overflow: TextOverflow.visible,
                          letterSpacing: 2),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
