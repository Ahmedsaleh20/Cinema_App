import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../OtherScreens/Constants.dart';


class Favorite_Svg extends StatelessWidget {
  const Favorite_Svg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF181818),
              const Color(0xFFC69634),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.6],
            tileMode: TileMode.clamp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.07),
            child: Lottie.asset("assets/images/empty.json",
              width: 300, height: 400, reverse: false, ),
          ),
          Padding(
            padding:   EdgeInsets.only(left: MediaQuery.of(context).size.width*.03,top: 30),
            child:const Text("No Movie yet ..!",style: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 24
              ,)),
          ),
        ],
      ),
    );
  }
}
