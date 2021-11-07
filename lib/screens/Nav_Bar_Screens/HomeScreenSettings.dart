import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:movie_app/lang/Controller.dart';
import 'package:movie_app/widgets/custem_Text.dart';
import '../OtherScreens/Constants.dart';
import 'HomePage.dart';

class HomeScreenSettings extends StatefulWidget {
  const HomeScreenSettings({Key? key}) : super(key: key);

  @override
  State<HomeScreenSettings> createState() => _HomeScreenSettingsState();
}

class _HomeScreenSettingsState extends State<HomeScreenSettings> {

  var isSwitchOn = false;
  var isSwitchOn1 = false;
   @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: accentColor,
          leading: IconButton(
            onPressed: () =>
                Navigator.of(context)
                    .pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage(),)
                ),
            icon: Icon(Icons.arrow_back_ios),
            color: primaryColor,
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
                stops: [0.3, 0.6],
                tileMode: TileMode.clamp),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 30, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                         Align(
                        alignment: Alignment.topLeft,
                        child: CustemText(
                          text: "Settings".tr,
                          fontSize:  23,
                          color: primaryColor,
                          fontWidget: FontWeight.bold,
                          space: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    width: 320,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         Icon(
                            Icons.language_outlined,
                            color: accentColor,
                            size: 25,
                          ),

                        CustemText(
                            text: "Language".tr,
                            color: accentColor,
                            fontSize: 18,
                          fontWidget: FontWeight.bold,
                          ),
                        GetBuilder<AppLangouage>(
                          init: AppLangouage(),
                          builder: (controller){
                            return  DropdownButton(
                              value: controller.appLocal,
                              items: [
                                DropdownMenuItem(child: Text("English",style: TextStyle(
                                    color: Colors.white
                                ),),value: "en",),
                                DropdownMenuItem(child: Text("العربية",style: TextStyle(
                                    color: Colors.white)),value: "ar",),
                              ],
                              onChanged: (newValue) {
                                 controller.changeLang(newValue as String) ;

                                Get.updateLocale(Locale(newValue));
                              },

                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: accentColor, fontSize: 16),
                              icon: Icon(Icons.arrow_drop_down_circle,color: Colors.white,size: 30,),
                              dropdownColor: accentColor,
                            );
                          },

                        ),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30, top: 30),
                  child:  Divider(
                    height: 2,
                    color: primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 30, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustemText(
                          text: "Notification".tr,
                          fontSize:  23,
                          color: primaryColor,
                          fontWidget: FontWeight.bold,
                          space: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    width: 320,
                    height: 130,
                    decoration: BoxDecoration(
                      color:accentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                  Icons.notifications_none,
                                  color: primaryColor,
                                  size: 25,
                                ),

                            Column(
                                  children: [
                                    Text(
                                      "PushNotification".tr,style: TextStyle(
                                      fontSize: 17,
                                      color: primaryColor,
                                      fontWeight:  FontWeight.bold,
                                      letterSpacing: 1,
                                    )),
                                  ],
                                ),

                               FlutterSwitch(
                                 borderRadius: 9,
                                 showOnOff: true,
                                  toggleSize: 20,
                                  height: 24,
                                  width: 50,
                                  value: isSwitchOn1,
                                  toggleColor: Colors.grey.shade400,
                                  activeColor: primaryColor,
                                  inactiveColor: Colors.yellow,
                                  onToggle: (value) {
                                    setState(() {
                                      isSwitchOn1 = value;
                                    });
                                  },
                                ),

                            ],
                          ),
                        ),
                        Padding(
                          padding:const  EdgeInsets.only(top: 15.0,),
                          child: const Divider(height: 2, color: primaryColor,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                             Icon(
                                  Icons.email_outlined,
                                  color: primaryColor,
                                  size: 25,
                                ),
                             Column(
                                  children: [
                                    Text(
                                        "EmailNotification".tr,style: TextStyle(
                                      fontSize: 17,
                                      color: primaryColor,
                                      fontWeight:  FontWeight.bold,
                                      letterSpacing: 1,
                                    )),
                                  ],
                                ),
                               FlutterSwitch(
                                 showOnOff: true,
                                 borderRadius: 9,
                                  toggleSize: 20,
                                  height: 25,
                                  width: 50,
                                  value: isSwitchOn,
                                  toggleColor: Colors.grey.shade400,
                                  activeColor: primaryColor,
                                  inactiveColor: Colors.yellow,
                                  onToggle: (value) {
                                    setState(() {
                                      isSwitchOn = value;
                                    });
                                  },
                                ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
