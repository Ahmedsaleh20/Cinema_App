import 'package:get_storage/get_storage.dart';

class LocalStorage {
  void saveLang(String Language)async{
    await GetStorage().write("Language",Language);
  }
  Future<String> ? get  getLangSelected async {
    return await GetStorage().read("Language");
  }

}