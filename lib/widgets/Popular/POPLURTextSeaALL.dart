import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:movie_app/screens/OtherScreens/Constants.dart';
import 'package:movie_app/widgets/Popular/See_All_Popular.dart';
import 'package:movie_app/widgets/custem_Text.dart';

class PopularAndSee extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: CustemText(
            text: "PopularMovies".tr,
            color: Colors.white,
            fontSize: 20,
            fontWidget: FontWeight.bold,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: TextButton(
                child: Text("SeeAll".tr,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SeeAllPopular()))))
      ],
    );
  }
}
