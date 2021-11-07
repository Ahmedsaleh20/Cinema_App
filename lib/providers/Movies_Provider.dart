import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lottie/lottie.dart';
  import 'package:movie_app/models/PopularResponse/PopularSuccessResponse.dart';
import 'package:sqflite/sqflite.dart';
import '../screens/OtherScreens/Constants.dart';

class Movies_Providers extends ChangeNotifier{

  Future<String> getDbPath() async {
    var dbPath = await getDatabasesPath();
    var favoriteDbPath = dbPath + "/" + Constants.DB_NAME;
    notifyListeners();
    return favoriteDbPath;
  }
  Future<Database> geFavoriteDb() async {
    String path = await getDbPath();
    notifyListeners();
    return openDatabase(
      path,
      version: Constants.DB_VERSION,
      onCreate: (db, version) => createDb(db),
      onUpgrade: (db, oldVersion, newVersion) => upgradeDb(db),
    );
  }
  createDb(Database db) {

    String sql ='create table ${Constants.TABLE_NAME} ( ${Constants.Data_ID} integer primary key autoincrement, ${Constants.COL_ID} text, ${Constants.COL_TITLE} text, ${Constants.COL_backdrop_path} text, ${Constants.COL_original_language} text, ${Constants.COL_original_title} text, ${Constants.COL_overview} text, ${Constants.COL_popularity} text, ${Constants.COL_poster_path} text, ${Constants.COL_release_date} text, ${Constants.COL_vote_average} text, ${Constants.COL_vote_count} text )';
    print(sql);
    db.execute(sql);
    notifyListeners();
  }
   upgradeDb(Database db) {
    createDb(db);
    notifyListeners();

  }


  Future<int> insertFavorite(Results movie,context)async{
    Database db = await geFavoriteDb();
    notifyListeners();
    try{
    var queryResult = await db.rawQuery('SELECT * FROM ${Constants.TABLE_NAME} WHERE ${Constants.COL_ID}="${movie.id}"');
    if(queryResult==null || queryResult.length==0) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Lottie.asset("assets/images/done.json",
                  width: 35, height:35, reverse: false,repeat: false ),
              SizedBox(width: 20,),
              Text("Movie Is Added To Favorites".tr,style:TextStyle(
                  color: primaryColor,
                  fontSize: 15
              ) ,
              )],
          ),
          backgroundColor: accentColor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 5,right:10,left: 10,bottom: 10),
          elevation: 30,
          duration: Duration(milliseconds: 1500),
        ),

      );
      return db.insert(Constants.TABLE_NAME, movie.toJson());
    }
    else{
    Fluttertoast.showToast(
    msg: "Movie Is Already Added".tr,
    textColor:Colors.black ,
    backgroundColor:Color.fromRGBO(245, 153, 36, 0.9519607843137254) ,
    fontSize: 16,
    toastLength: Toast.LENGTH_SHORT,
    );
    print("false");

    }  }
    catch(e){
      print(e.toString());
    }
    return 0;
  }

  Future<List<Results>> viewData() async {
    List<Results> movie=[];
    Database db = await geFavoriteDb();
    List<Map<String,dynamic>> list= await db.query(Constants.TABLE_NAME,);
    list.forEach((element) {
      movie.add(Results.fromJson(element));
    });
    notifyListeners();
    return movie;
  }
  void insertFav(Results movie,context){
    try {
      insertFavorite(movie, context).then((value) {
        value != null ?
        print("insertFav Done") : print("insertFav error");
        notifyListeners();
      });
    }catch(e){
      print(e.toString());
    }

  }
  Future<int> delete(Results movie) async {
    Database db = await geFavoriteDb();
    var delete=db.delete(Constants.TABLE_NAME,where:"${Constants.COL_ID}=?",whereArgs:[movie.id]);
     notifyListeners();
    return delete;

  }

}