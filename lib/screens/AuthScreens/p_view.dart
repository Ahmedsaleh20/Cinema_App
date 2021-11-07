import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/OtherScreens/Constants.dart';
import 'package:movie_app/lang/LangouageTranslation.dart';
import 'package:movie_app/providers/Movies_Provider.dart';
import 'package:movie_app/providers/api_service.dart';
import 'package:movie_app/providers/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../OtherScreens/SplachScreen.dart';

class MultiPageView extends StatefulWidget {
  @override
  _MultiPageViewState createState() => _MultiPageViewState();
}

class Data {
  final String ImageUrl;

  Data({required this.ImageUrl});
}

class _MultiPageViewState extends State<MultiPageView> {
    List<Data> data = [
    Data(ImageUrl: "assets/images/r.jpg"),
    Data(ImageUrl: "assets/images/r1.jpg"),
    Data(ImageUrl: "assets/images/r2.jpg"),
    Data(ImageUrl: "assets/images/r3.jpg"),
  ];
  PageController _controller = PageController(
    initialPage: 0,
  );
  int selected = 0;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (selected < 3) selected++;
      if (_controller.hasClients)
        _controller.animateToPage(
          selected,
          duration: Duration(seconds: 1),
          curve: Curves.easeIn,
        );
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AuthProvider()),
          ChangeNotifierProvider(create: (ctx) => Api_services()),
          ChangeNotifierProvider(create: (ctx) => Movies_Providers()),

        ],
        child: Consumer<AuthProvider>(builder: (context, auth, _) {
          return GetMaterialApp(
            locale: Locale("en"),
            fallbackLocale: Locale("en"),
            translations:Langouage_Translation(),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Stack(children: [
                Builder(builder: (context) {
                  return PageView(
                    controller: _controller,
                    onPageChanged: (val) {
                      setState(() {
                        selected = val;
                      });
                    },
                    children: data.map((item) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff090909),
                          image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.7),
                                  BlendMode.dstATop),
                              image: ExactAssetImage(item.ImageUrl),
                              fit: BoxFit.cover),
                        ),
                      );
                    }).toList(),
                  );
                }),
                Indicator(
                  selected: selected,
                ),
                Builder(
                  builder: (ctx) => Align(
                      alignment: Alignment(0, 0.9),
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: 320,
                        height: 60,
                        child: TextButton(
                          onPressed: () async {
                            SharedPreferences _prefs =
                                await SharedPreferences.getInstance();
                            _prefs.setBool("value", true);
                            Navigator.of(ctx).pushReplacement(MaterialPageRoute(
                                builder: (ctx) => SplachScreen()));
                          },
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: accentColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),

                )
              ]),
            ),
          );
        }));
  }
}

class Indicator extends StatelessWidget {
  final int? selected;

  const Indicator({this.selected});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.65),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildContainer(0, selected == 0 ? primaryColor : Colors.white),
          _buildContainer(1, selected == 1 ? primaryColor : Colors.white),
          _buildContainer(2, selected == 2 ? primaryColor : Colors.white),
          _buildContainer(3, selected == 3 ? primaryColor : Colors.white),
        ],
      ),
    );
  }

  Widget _buildContainer(int i, Color color) {
    return selected == i
        ? Icon(
            Icons.star,
            color: color,
            size: 27,
          )
        : Container(
            margin: EdgeInsets.all(12),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          );
  }
}
