import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:movie_app/screens/OtherScreens/Constants.dart';
import 'package:movie_app/models/PopularResponse/PopularSuccessResponse.dart';
import 'package:movie_app/models/PopularResponse/Popular_failed_Response.dart';
import 'package:movie_app/providers/Movies_Provider.dart';
import 'package:movie_app/providers/api_service.dart';
import 'package:movie_app/screens/OtherScreens/Detials.dart';
import 'package:movie_app/screens/Nav_Bar_Screens/HomePage.dart';
import 'package:provider/provider.dart';

import '../custem_Text.dart';

class SeaAllMovies extends StatelessWidget{
  var popularResponse;
  @override
  Widget build(BuildContext context) {
    Provider.of<Api_services>(context)
        .fetchPopular()
        .then((value) {
      popularResponse = value;
    });
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: accentColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: IconButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage())),
                icon: Icon(Icons.arrow_back_ios),
                color: primaryColor,
              ),
            ),
            title: Text(
              "AllMovies".tr,
              style: TextStyle(color: primaryColor,letterSpacing: 2,
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
            child: PopularResponseMethod(),
          )),
    );
  }

  Widget PopularResponseMethod() {
      if (popularResponse is PopularSuccessResponse) {
      var popular = popularResponse as PopularSuccessResponse;
      return Padding(
        padding: EdgeInsets.only(top: 20.0, left: 8, right: 8),
        child: Container(
          child: GridView.builder(

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3 / 5.5),
            itemBuilder: (BuildContext context, int index) {
              return SingleChildScrollView(
                child: InkWell(
                  onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Details(
                        popular.results![index],
                      ))),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 300,
                            height: 300,
                            imageUrl:
                            "$BaseImage_Url${popular.results![index].poster_path}",
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 190.0),
                            child: Container(
                                width: double.infinity,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.70),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5.0,
                                    top: 10,
                                  ),
                                  child: Wrap(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: CustemText(
                                          space: 1.5,
                                          text:
                                          "${popular.results![index].title}",
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3.0, top: 8, bottom: 15),
                                          child: Text(
                                            "${popular.results![index].release_date}",
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
                                            "🌟 ${popular.results![index].vote_average} ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            )),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          Positioned(
                            top: 220,
                            right: 10,
                            width: 50,
                            height: 70,
                            child:  Container(
                              child: IconButton(
                                icon: Container(
                                  width: 45,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  child: Icon(Icons.favorite,size: 25,),
                                ),
                                onPressed: () {
                                  Results  movie = Results(
                                    title: popular
                                        .results![index].title,
                                    id: popular
                                        .results![index].id,
                                    backdrop_path: popular
                                        .results![index]
                                        .backdrop_path,
                                    original_language: popular
                                        .results![index]
                                        .original_language,
                                    overview: popular
                                        .results![index].overview,
                                    popularity: popular
                                        .results![index]
                                        .popularity,
                                    poster_path: popular
                                        .results![index]
                                        .poster_path,
                                    release_date: popular
                                        .results![index]
                                        .release_date,
                                    vote_count: popular
                                        .results![index]
                                        .vote_count,
                                    original_title: popular
                                        .results![index]
                                        .original_title,
                                    vote_average: popular
                                        .results![index]
                                        .vote_average,
                                  );
                                  Provider.of<Movies_Providers>(
                                      context,
                                      listen: false)
                                      .insertFav(movie,context);
                                },
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
            itemCount: popular.results!.length,
          ),
        ),
      );
    } else if (popularResponse is PopularErrorResponse) {
       return Center(
        child: Text("Not Found"),
      );
    }
     return  Center(child: CircularProgressIndicator(color: primaryColor,backgroundColor: accentColor));
  }
}
