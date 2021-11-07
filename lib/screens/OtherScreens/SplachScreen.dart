import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
 import 'package:movie_app/screens/OtherScreens/Constants.dart';
import 'package:movie_app/screens/AuthScreens/LoginScreen.dart';
import 'package:movie_app/screens/AuthScreens/Regster/RegistersScreen.dart';

class SplachScreen extends StatelessWidget {
    var  width;
    var height;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: accentColor,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  "assets/images/download14.png",
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Image.asset(
                      "assets/images/download17.png",
                      width: 400,
                      height: 150,
                    ),
                  ),
                  const Text("Cinema For U",style: TextStyle(
                      color: primaryColor,
                      fontSize: 25
                  ),),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.30,
                          right: width * 0.07,
                          left: width * 0.07,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextButton(
                            onPressed: ()=>Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (ctx)=>Registers())),
                            child:  Text(
                              "Registers".tr,
                              style: TextStyle(
                                  color: accentColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                        TextButton(
                          onPressed:()=> Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (ctx)=>LoginScreen())),
                          child:   Text("Sign In".tr,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),

                    ],
                  ),
                ],
              ),
                ],
              ),
        ),

        );
  }
}
