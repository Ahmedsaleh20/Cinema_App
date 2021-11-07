import 'package:flutter/cupertino.dart';
 import 'package:get/get.dart';
import 'package:movie_app/lang/localStorage.dart';

class AppLangouage extends GetxController{
  String appLocal= "en";
 @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    try{
    LocalStorage localStorage=LocalStorage();
  appLocal=  await localStorage.getLangSelected!=null?
  await localStorage.getLangSelected!:"en" ;
  Get.updateLocale(Locale(appLocal));
  update();
  }catch(e){}}
  void changeLang(String type)async{
    LocalStorage localStorage=LocalStorage();
    if(appLocal==type){
      return;
    }else if (type== "ar"){
      appLocal="ar";
      localStorage.saveLang("ar");
    }else {
      appLocal="en";
      localStorage.saveLang("en");
    }
    update();
  }
}