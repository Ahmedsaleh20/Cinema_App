import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
 import '../screens/OtherScreens/http_exception.dart';
class AuthProvider extends ChangeNotifier {
  String? _token;
  DateTime? _expireTime;
  String? _userid;
  Timer? _authTimer;
  bool get isAuth {
    return token != null;
  }
  String? get token {

    if (_token != null) {
      return _token!;
    } else {
      return null;
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin=FacebookLogin();

  Future<void>  googleSignInMethod() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
       await _auth.signInWithCredential(credential);
       notifyListeners();
     } on FirebaseAuthException catch(e){
      throw e;
    }
  }
  Future<void> faceBookSignInMethod()async{
       FacebookLoginResult  result = await _facebookLogin.logIn(customPermissions: ["email"]);
    final accessToken= result.accessToken!.token;
    if(result.status==FacebookLoginStatus.success){
      final credential=FacebookAuthProvider.credential(accessToken);
       await _auth.signInWithCredential(credential);
     }

    }

  Future<void> _authinticate(String email, String password, String urlSegment) async {
    try {
      final res = await http.post(
          Uri.parse(
              "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key="
                  "AIzaSyCx5XPeGdYr1u978QLKaxu0sa5Fhy7rTHE"),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = json.decode(res.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      } else {
        _token = responseData["idToken"];
        _userid = responseData["localId"];
        _expireTime = DateTime.now().add(Duration(seconds: int.parse(responseData["expiresIn"])));
      }
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      String userData = json.encode({
        'token': _token,
        'userId': _userid,
        'expiresIn': _expireTime!.toIso8601String(),
      });
      prefs.setString("userData", userData);
    } catch (e) {
      throw e;
    }
  }
  Future<void> signup(String email, String password) async {
    return _authinticate(email, password,"signUp");
  }

  Future<void> login(String email, String password,) async {
    return _authinticate(email, password,"signInWithPassword");
  }
  Future<bool> tryAutoLog() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) return false;

    final Map<String, dynamic> extractedData =
    json.decode(prefs.getString("userData")!) as Map<String, dynamic>;
    final expire = DateTime.parse(extractedData["expiresIn"] as dynamic);
    if (expire.isBefore(DateTime.now())) return false;
    _token = extractedData["token"] as dynamic;
    _expireTime = expire;
    _userid = extractedData["userId"] as dynamic;
     notifyListeners();
    return true;

  }
   Future<void> logout() async {
    _token = null;
    _userid = null;
    _expireTime = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
     prefs.remove("userData");
   }

  void autoLogout() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    int timerTo_Exprey;
    timerTo_Exprey = _expireTime!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timerTo_Exprey), logout);
  }

}