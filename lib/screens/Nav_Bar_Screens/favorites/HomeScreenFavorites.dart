import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
 import 'package:lottie/lottie.dart';
import 'package:movie_app/screens/OtherScreens/Constants.dart';
import 'package:movie_app/models/PopularResponse/PopularSuccessResponse.dart';
import 'package:movie_app/providers/Movies_Provider.dart';
import 'package:movie_app/widgets/custem_Text.dart';
import 'package:provider/provider.dart';

import '../../OtherScreens/Detials.dart';
import '../HomePage.dart';

class HomeScreenFavorites extends StatelessWidget{
   List<Results>? _movie = [];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    viewList(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: RefreshIndicator(
        color: Colors.black,
        backgroundColor: primaryColor,
        edgeOffset: 3,
        strokeWidth: 4,
        displacement: 100,
        onRefresh: () => _refreshHome(context),
        child: Scaffold(
            key: _scaffoldKey,
             appBar: AppBar(
              backgroundColor: accentColor,
              leading: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage(),)
                    ),
                icon: Icon(Icons.arrow_back_ios),
                color: primaryColor,
              ),
              title: Text(
                "FavoritesMovies".tr,
                style: TextStyle(color: primaryColor,letterSpacing: 1.5),
              ),
            ),
            body:Builder(builder: (_){
              Timer(Duration(seconds: 1), ()=>CircularProgressIndicator());
             return (_movie ==null || _movie!.length ==0) ? Container(
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
                      child:  Text("NoMovieyet..!".tr,style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                        ,)),
                    ),
                  ],
                ),
              ):
              Container(
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
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3 / 5.35),
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 20),
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () =>
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => Details(
                                            _movie![index],
                                          ))),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 300,
                                    imageUrl:
                                    "$BaseImage_Url${_movie![index].poster_path}",
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 180.0),
                                  child: Container(
                                      width: double.infinity,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 0, 0, 0.60),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          top: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: CustemText(
                                                space: 1.5,
                                                text: "${_movie![index].title}",
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0, top: 10, bottom: 12),
                                                child: Text(
                                                  "${_movie![index].release_date}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      letterSpacing: 1.5),
                                                ),
                                              ),
                                            ),

                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                  "🌟  ${_movie![index].vote_average}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                  )),
                                            ),
                                          ],
                                        ),

                                      )),
                                ),
                                Positioned(
                                  top: 230,
                                  right: 10,
                                  width: 50,
                                  height: 70,
                                  child: IconButton(
                                    onPressed: () {
                                      var alert = AlertDialog(
                                        title: Text("Notice".tr,
                                            style: TextStyle(
                                                color:
                                                primaryColor,
                                                fontSize: 20)),
                                        content: Container(
                                          height: 70,
                                          child: Column(
                                            children: [
                                              Divider(
                                                color:
                                                primaryColor,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10.0),
                                                child: Text(
                                                    "Are You Sure you want to Remove this Movie ?".tr,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white54,
                                                        fontSize:
                                                        16)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        backgroundColor:
                                        accentColor,
                                        shape:
                                        RoundedRectangleBorder(),
                                        elevation: 2,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();},
                                              child: Text("Cancel".tr, style: TextStyle(fontSize: 16,
                                                  color: primaryColor),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Results meal = _movie![index];
                                                Navigator.of(context).pop();
                                                deleteAll(meal,context);
                                                Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Row(
                                                      children: [
                                                        Lottie.asset("assets/images/done.json",
                                                            width: 40, height:40, reverse: false,repeat: false ),
                                                        SizedBox(width: 20,),
                                                        Text('Done'.tr,style:TextStyle(
                                                            color: primaryColor,
                                                            fontSize: 18
                                                        ) ,
                                                        )],
                                                    ),
                                                    backgroundColor: accentColor,
                                                    behavior: SnackBarBehavior.floating,
                                                    margin: EdgeInsets.only(top: 5,right:5,left: 5,bottom: 10),
                                                    elevation: 30,
                                                    duration: Duration(milliseconds: 1500),
                                                  ),

                                                );
                                              },
                                              child: Text("Ok".tr,
                                                  style: TextStyle(
                                                      fontSize:
                                                      16,
                                                      color:
                                                      primaryColor))),
                                        ],
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext
                                          context) =>
                                          alert);
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      size: 40,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _movie!.length,
                ),
              );
            },)
        ),
      ),
    );
  }

  void viewList(context) {
    try {
      Provider.of<Movies_Providers>(context).viewData().then((value) {
        _movie = value;
      });
    }catch(e){}
  }

  void deleteAll(Results Movie,context) {
    try{
    Provider.of<Movies_Providers>(context,listen: false).delete(Movie);
    viewList(context);
  }catch(e){}
  }

  _refreshHome(context) async {
     viewList(context);
  }
}
