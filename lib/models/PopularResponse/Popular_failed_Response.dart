import 'package:movie_app/models/PopularResponse/popularResponse.dart';

class PopularErrorResponse extends PopularResponse{
  var status_code;
  String ? status_message;
  bool ? success;
  PopularErrorResponse.fromJson(Map<String,dynamic> map) {
    status_code = map["status_code"];
    status_message = map["status_message"];
    success = map["success"];
  }
}