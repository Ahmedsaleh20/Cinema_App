import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/PopularResponse/PopularSuccessResponse.dart';
import 'package:movie_app/models/PopularResponse/Popular_failed_Response.dart';
import 'package:movie_app/screens/OtherScreens/Constants.dart';
import 'package:movie_app/screens/OtherScreens/base_Exception.dart';
import 'package:movie_app/models/PopularResponse/popularResponse.dart';

class Api_services extends ChangeNotifier {


  Future<PopularResponse> fetchPopular() async {
    String url =
        "$Base_Url/3/movie/popular?api_key=$Api_Key";
     Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      try {
        notifyListeners();
        return PopularSuccessResponse.fromJson(jsonData);
      } catch (e) {
        notifyListeners();
        return PopularErrorResponse.fromJson(jsonData);
      }
    } else {
      notifyListeners();
      throw BaseException.checkCod(res.statusCode);
    }
  }
}
