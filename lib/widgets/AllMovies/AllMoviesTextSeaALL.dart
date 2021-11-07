import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
 import 'package:movie_app/widgets/custem_Text.dart';

import 'AllMoviesSeeAll.dart';

class Tv_Movies extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: CustemText(
            text: "AllMovies".tr,
            color:Colors.white,
            fontSize: 21,
            fontWidget: FontWeight.bold,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(right:  10),
            child: TextButton(
                child: Text("SeeAll".tr,
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )),
                onPressed: ()=>Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SeaAllMovies())),
            ))
      ],
    );
  }
}
