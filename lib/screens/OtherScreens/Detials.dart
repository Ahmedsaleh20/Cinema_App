import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:movie_app/screens/OtherScreens/Constants.dart';
import 'package:movie_app/models/PopularResponse/PopularSuccessResponse.dart';
import 'package:movie_app/providers/Movies_Provider.dart';
import 'package:movie_app/screens/Nav_Bar_Screens/HomePage.dart';
import 'package:movie_app/widgets/custem_Text.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  var list;
  Details(this.list);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details".tr,style: TextStyle(
            color: accentColor
          ),),
          backgroundColor: primaryColor,
          leading: Align(
            child: IconButton(
              icon:const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: accentColor,
              ),
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage())),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xFF181818),
                  const Color(0xFFC69634),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.45, 0.8],
                tileMode: TileMode.clamp),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "$BaseImage_Url${list.backdrop_path}",
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                      child: Text("${list.title}",
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white
                          )),
                    ),
                  ),
                         Padding(
                          padding: const EdgeInsets.only(top: 15.0,right: 15),
                          child: CustemText(
                            text: "🌟 ${list.vote_average}",
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                  SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Adult : false",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        Text("${list.release_date}",
                            style: TextStyle(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        Text("Language :${list.original_language}".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 15,right: 10),
                          child:
                          Text(
                            "Description".tr,
                            style: TextStyle(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Align(
                       alignment: Alignment.topLeft,
                       child: Directionality(
                         textDirection: TextDirection.ltr,
                         child: Text("${list.overview}",
                                  style: TextStyle(
                                    color: Colors.white,
                                     fontSize: 15,
                                  ),maxLines: 5,
                              ),
                       ),
                     ),
                   ],
                 ),
               ),

                  Builder(builder: (ctx) {
                    return Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          right: 30,
                        ),
                        child: Container(
                          width: 80,
                          height: 80,
                          child: IconButton(
                            icon: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: accentColor,
                              ),
                              child: Icon(
                                Icons.favorite,
                                size: 30,
                                color: primaryColor,
                              ),
                            ),
                            onPressed: () {
                              Results movie = Results(
                                title: list.title,
                                id: list.id,
                                 backdrop_path:list.backdrop_path,
                                original_language: list.original_language,
                                overview: list.overview,
                                popularity: list.popularity,
                                poster_path: list.poster_path,
                                release_date: list.release_date,
                                vote_count: list.vote_count,
                                original_title: list.original_title,
                                vote_average: list.vote_average,
                              );
                              Provider.of<Movies_Providers>(context,
                                      listen: false)
                                  .insertFav(movie, ctx);
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
