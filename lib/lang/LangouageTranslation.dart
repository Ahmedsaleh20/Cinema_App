import 'package:get/get.dart';
import 'package:movie_app/lang/ar.dart';

import 'en.json.dart';

class Langouage_Translation extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
  {
    "en":en,
    "ar":ar
  };

}