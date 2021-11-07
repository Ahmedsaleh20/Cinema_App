import 'package:movie_app/models/PopularResponse/popularResponse.dart';

class PopularSuccessResponse extends PopularResponse {
  var page;
  var total_pages;
  var total_results;
  List<Results>? results;

  PopularSuccessResponse.fromJson(Map<String, dynamic> map) {
    page = map["page"];
    total_pages = map["total_pages"];
    total_results = map["total_results"];
    if (map['results'] != null) {
      results = <Results>[];
      map['results'].forEach((value) {
        results!.add(Results.fromJson(value));
      });
    }
  }
}

class Results {
   var backdrop_path;
  var id;
  var original_language;
  var overview;
  var popularity;
  var poster_path;
  var release_date;
  var title;
  var vote_count;
  var original_title;
  var vote_average;
  Results({this.id,this.vote_count,this.popularity,this.release_date,this.original_title,this.title,
  this.backdrop_path,this.poster_path,this.original_language,this.overview,this.vote_average,});
  Results.fromJson(Map<String, dynamic> map) {
     backdrop_path = map["backdrop_path"];
    id = map["id"];
    original_language = map["original_language"];
    overview = map["overview"];
    popularity = map["popularity"];
    poster_path = map["poster_path"];
    release_date = map["release_date"];
    title = map["title"];
    vote_count = map["vote_count"];
    original_title = map["original_title"];
    vote_average = map["vote_average"];
  }

  toJson() {
    return {
       "backdrop_path": backdrop_path,
      "id": id,
      "original_language": original_language,
      "overview": overview,
      "popularity": popularity,
      "title": title,
      "vote_count": vote_count,
      "release_date": release_date,
      "poster_path": poster_path,
      "original_title": original_title,
      "vote_average": vote_average
    };
  }
}
