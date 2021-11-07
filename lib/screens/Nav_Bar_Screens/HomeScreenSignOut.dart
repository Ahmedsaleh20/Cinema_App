import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/providers/AuthProvider.dart';
import 'package:provider/provider.dart';
import '../OtherScreens/Constants.dart';
import '../AuthScreens/LoginScreen.dart';

class HomeScreenSignOut extends StatefulWidget {
  const HomeScreenSignOut({Key? key}) : super(key: key);

  @override
  _HomeScreenSignOutState createState() => _HomeScreenSignOutState();
}

class _HomeScreenSignOutState extends State<HomeScreenSignOut> with TickerProviderStateMixin {
  var isSwitchOn1=false;
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
      upperBound: 0.7)
    ..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child: Container(width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF181818),
                const Color(0xFFC69634),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.15, 0.6],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 150),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.0),
                child: Lottie.asset("assets/images/goodbye.json",
                  width: 250, height: 300, reverse: false,repeat: isSwitchOn1 ),
              ),
              isSwitchOn1==true ? Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Hope U Back Soon..,".tr,style: TextStyle(
                  fontSize: 25,letterSpacing: 2,
                    color: Colors.white
                ),),
              ):SizedBox(),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 20),
                child: FlutterSwitch(
                  toggleSize: 50,
                  height: 70,
                  width: 180,
                  value: isSwitchOn1,
                  inactiveIcon: Image.asset("assets/images/vertical-lines.png",),
                  toggleColor: Colors.black.withOpacity(0),
                  activeColor: accentColor,
                  inactiveColor: accentColor,
                   inactiveText: "SignOut".tr,
                   showOnOff: true,
                   valueFontSize: 20,
                   activeText: " Bye",
                   disabled: isSwitchOn1==true ? true:false,
                  activeIcon: Image.asset("assets/images/vertical-lines.png",),
                  onToggle: (value) {
                    setState(() {
                      isSwitchOn1 = value;
                    });
                    Timer(Duration(seconds: 2), ()=>Provider.of<AuthProvider>(context,listen: false).logout().then((value) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>LoginScreen()));
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
