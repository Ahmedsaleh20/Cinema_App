import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:movie_app/providers/AuthProvider.dart';
import 'package:movie_app/screens/Nav_Bar_Screens/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../OtherScreens/Constants.dart';
import '../OtherScreens/http_exception.dart';
import 'Regster/RegistersScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var width;
  var height;
  bool Loading = false;
  bool visable = true;
  GlobalKey<FormState> _globalKey = GlobalKey();
  Map<String, String> _authData = {"email": "", "password": ""};

  void _showErrordialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("An Error Occurred"),
            content: Text(
              message,
              style: TextStyle(
                color: primaryColor,
              ),
            ),
            backgroundColor: greyColor,
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      Loading = false;
                    });
                    Navigator.of(ctx, rootNavigator: true).pop();
                  },
                  child:const Text("okey   ",
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AuthProvider>(context, listen: false);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
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
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Image.asset(
                                "assets/images/download17.png",
                                width: 400,
                                height: 120,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child:const Text(
                                "Cinema For U",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 23),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35, top: 30),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.red[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade50)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          hintText: "EMAIL".tr,
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 16)),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ("this Field is required");
                        } else if (!val.contains("@")) {
                          return ("Invalid Email");
                        }
                      },
                      onSaved: (value) {
                        _authData["email"] = value!.trim();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _authData["password"] = value!.trim();
                      },
                      validator: (val) {
                        {
                          if (val!.isEmpty) {
                            return ("this Field is required");
                          } else if (val.length < 6) {
                            return ("Is too Short At least 6 Character");
                          }
                        }
                      },
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      cursorColor: Colors.white,
                      obscureText: visable,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.red[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          suffixIcon: IconButton(
                              icon: visable == true
                                  ? Icon(Icons.visibility_off_outlined,
                                      size: 22, color: Colors.grey.shade400)
                                  : Icon(Icons.visibility_outlined,
                                      size: 22, color: primaryColor),
                              onPressed: () {
                                setState(() {
                                  visable = !visable;
                                });
                              }),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade50)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: Colors.grey,
                          ),
                          hintText: "PASSWORD".tr,
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 16)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Loading == true
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: height * 0.25),
                              child: SpinKitFadingCircle(
                                color: primaryColor,
                                duration: Duration(seconds: 1),
                                size: 60,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: TextButton(
                                  onPressed: _submit,
                                  child:   Text(
                                    "LOGIN".tr,
                                    style: TextStyle(
                                        color: accentColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                    child:const Divider(
                                  color: Colors.grey,
                                )),
                                Text(
                                  "     Social Logins    ".tr,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                    child:const Divider(
                                  color: Colors.grey,
                                )),
                              ]),
                              const  SizedBox(
                                height: 20,
                              ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 70.0,right: 60),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                        child: TextButton(
                                          child: Image.asset(
                                              "assets/images/download.png"),
                                          onPressed: () {
                                            try {
                                              provider.faceBookSignInMethod()
                                                  .then((value) {
                                                Navigator.of(context)
                                                    .pushReplacement(MaterialPageRoute(builder:(context) => HomePage(), ));
                                              });
                                            } catch (e) {
                                              Loading = false;
                                              print(e);
                                              const error_message =
                                                  "could not authenticate you ,try again later";
                                              _showErrordialog(error_message);
                                            }
                                          },
                                        ),
                                      ),
                                      const  SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                        child: TextButton(
                                          child: Image.asset(
                                              "assets/images/download (1).png"),
                                          onPressed: () {
                                            try {
                                              provider
                                                  .googleSignInMethod()
                                                  .then((value) {
                                                Navigator.of(context)
                                                    .pushReplacement(MaterialPageRoute(builder:(context) => HomePage(), ));

                                              });
                                            } catch (e) {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "An error Occurred",
                                                  style: TextStyle(
                                                    color: accentColor,
                                                  ),
                                                ),
                                                backgroundColor: primaryColor,
                                              ));
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Don't have an Account ?".tr,
                                        style: TextStyle(
                                            fontSize: 19, color: Colors.grey.shade700),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(builder: (context)=>Registers())),
                                        child:  Text("REGISTERS".tr,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _globalKey.currentState!.save();

    try {
      Loading = true;
      await Provider.of<AuthProvider>(context, listen: false)
          .login(_authData["email"]!, _authData["password"]!)
          .then((value) {
        Timer(Duration(seconds: 2), () {
          setState(() {
            Loading = false;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
        });
      });
    } on HttpException catch (error) {
      var error_message = "Authentication failed";

      if (error.toString().contains("INVALID_EMAIL"))
        error_message = "this Eamil is not valid";
      else if (error.toString().contains("WEAK_PASSWORD"))
        error_message = "this password is weak";
      else if (error.toString().contains("EMAIL_NOT_FOUND"))
        error_message = "could not found user with this email";
      else if (error.toString().contains("INVALID_PASSWORD")) {
        error_message = "password is invalid";
      }
      _showErrordialog(error_message);
    } catch (error) {
      print(error);
      const error_message = "could not authenticate you ,try again later";
      _showErrordialog(error_message);
    }
  }
}
