import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/providers/Movies_Provider.dart';
import 'package:movie_app/providers/api_service.dart';
import 'package:movie_app/models/PopularResponse/PopularSuccessResponse.dart';
import 'package:movie_app/models/PopularResponse/Popular_failed_Response.dart';
import 'package:movie_app/screens/OtherScreens/Detials.dart';
import 'package:provider/provider.dart';


import '../../screens/OtherScreens/Constants.dart';
import '../custem_Text.dart';

class CursoulTv extends StatelessWidget{
  Results? movie;
  var popularResponse;
  @override
  Widget build(BuildContext context) {
    Provider.of<Api_services>(context)
        .fetchPopular()
        .then((value) {
      popularResponse = value;
    });
    return PopularResponseMethod();
  }
  Widget PopularResponseMethod() {

      if (popularResponse is PopularSuccessResponse) {
        var popular = popularResponse as PopularSuccessResponse;
        return CarouselSlider.builder(
          itemCount: 20,
          itemBuilder: (context, index, _) {
            return InkWell(
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Details(
                        popular.results![index],
                      ))),
              child: Container(
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 300,
                          height: 300,
                          imageUrl:
                          "$BaseImage_Url${popular.results![index].poster_path}",
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),

                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.70),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  top: 10,
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: CustemText(
                                        space: 1.5,
                                        text: "${popular.results![index].title}",
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),

                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0, top: 12),
                                            child: Text(
                                              "${popular.results![index].release_date}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  letterSpacing: 1.5),
                                            ),
                                          ),
                                        ),

                                    SizedBox(
                                      height: 15,
                                    ),

                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                              "🌟 ${popular.results![index].vote_average}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                              )),
                                        ),


                                  ],
                                )),
                          ),
                        ),
                        Positioned(
                          top: 185,
                          right: 15,
                          width: 65,
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
                                movie = Results(
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
                                    .insertFav(movie!,context);
                              },
                            ),

                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },
          options: CarouselOptions(
              autoPlay: false,
              initialPage: 14,
              height: double.infinity,
              enlargeCenterPage: true),
        );
      } else if (popularResponse is PopularErrorResponse) {
         return Center(
          child: Text("Not Found",style: TextStyle(color: Colors.white,fontSize: 20),),
        );
      }
      return Center(
          child: CircularProgressIndicator(
            color: primaryColor,
            backgroundColor: accentColor,
          ));

  }
}
