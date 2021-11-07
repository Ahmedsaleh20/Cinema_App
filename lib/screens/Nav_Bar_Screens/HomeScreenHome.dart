import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:movie_app/widgets/Popular/Caursoul_Popular.dart';
import 'package:movie_app/widgets/AllMovies/Cursoul_All.dart';
import 'package:movie_app/widgets/Popular/POPLURTextSeaALL.dart';
 import 'package:movie_app/widgets/AllMovies/AllMoviesTextSeaALL.dart';
import 'package:movie_app/widgets/custem_Text.dart';

import '../OtherScreens/Constants.dart';

class HomeScreenHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
             accentColor,
              primaryColor,            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.45, 0.6],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20,top: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
             Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustemText(
                        text: "Movies,".tr,
                        color: Colors.white,
                        fontSize: 25,
                        fontWidget: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset("assets/images/download17.png",width: 20,height: 30,),
                    ),
                  ],
                ),
              SizedBox(height: 10),
              PopularAndSee(),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: 280,
                child: CursoulPopolur(),
              ),
                Row(
                  children: <Widget>[
                    const Text(
                      "   *   ",
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child:const Divider(
                          thickness:1.5,
                          color: accentColor,
                        )),
                    const Text(
                      "   *   ",
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
              Tv_Movies(),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 280,
                  child: CursoulTv(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
