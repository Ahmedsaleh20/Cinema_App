import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFE7AD3A);
const Color accentColor = Color(0xFF181818);
Color greyColor = Colors.grey.shade800;
const String Api_Key = "837aa67b269303622a476bbe24283a57";
const String Base_Url = "https://api.themoviedb.org";
const String BaseImage_Url = "http://image.tmdb.org/t/p/w500";

class Constants {
  static final String DB_NAME = "favorite.db";
  static final String TABLE_NAME = "favorite";
  static final String Data_ID = "DataId";
  static final String COL_ID = "id";
  static final String COL_TITLE = "title";
  static final String COL_adult = "adult";
  static final String COL_backdrop_path = "backdrop_path";
  static final String COL_original_language = "original_language";
  static final String COL_popularity = "popularity";
  static final String COL_poster_path = "poster_path";
  static final String COL_release_date = "release_date";
  static final String COL_vote_count = "vote_count";
  static final String COL_original_title = "original_title";
  static final String COL_vote_average = "vote_average";
  static final String COL_overview = "overview";
  static final int DB_VERSION =1;
}
