import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
 import 'package:movie_app/screens/OtherScreens/Constants.dart';
import 'package:movie_app/lang/Controller.dart';
import 'package:movie_app/lang/LangouageTranslation.dart';
import 'package:movie_app/providers/AuthProvider.dart';
import 'package:movie_app/providers/Movies_Provider.dart';
import 'package:movie_app/screens/Nav_Bar_Screens/HomePage.dart';
import 'package:movie_app/screens/OtherScreens/SplachScreen.dart';
import 'package:movie_app/screens/AuthScreens/p_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
   SharedPreferences _prefs= await SharedPreferences.getInstance();
   bool? decision= _prefs.getBool("value");
  await GetStorage.init();
  print("decision $decision");
   var Screen = (decision==null ||decision==false)? MultiPageView():MyApp();
  runApp(GetBuilder(init: AppLangouage(),builder:(controller)=> Screen));
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => Api_services()),
        ChangeNotifierProvider(create: (ctx) => Movies_Providers()),
      ],
      child: Consumer<AuthProvider>(
          builder: (context, auth, _){
            return  GetMaterialApp(
              locale: Locale("en"),
                fallbackLocale: Locale("en"),
                 translations:Langouage_Translation(),
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home:auth.isAuth
                    ?  HomePage()
                    : FutureBuilder(
                      future: auth.tryAutoLog(),
                        builder: (ctx, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        color: primaryColor,
                        height: double.infinity,
                        width: double.infinity,
                      );
                    } else {
                      return SplachScreen();
                    }
                  },
                ),

            );
          }),
    );
  }
}
