import 'package:shared_preferences/shared_preferences.dart';



class DBHelper{
  static SharedPreferences _db;
  static const String TITLE_KEY = "contentsTitle";
  static const String CURRENTDATE_KEY = "contentsCURRENTDATE";
  static const String DATE_KEY = "contentsDATE";
  static const String COMPLETE_KEY = "contentsCOMPLETE";

  get db{
    if(_db != null) return _db;
    else{
      return initDB();
    }
  }

  initDB() async{
    _db = await SharedPreferences.getInstance();
    return _db;
  }

  get goalTitle async{
    SharedPreferences dbClient = await db;
    return dbClient.getString(TITLE_KEY);
  }
  set goalTitle(String value){
    SharedPreferences dbClient = db;
    dbClient.setString(TITLE_KEY, value);
  }

  get goalCurrentDate async{
    SharedPreferences dbClient = await db;
    return dbClient.getInt(CURRENTDATE_KEY);
  }
  set goalCurrentDate(int value){
    SharedPreferences dbClient = db;
    dbClient.setInt(CURRENTDATE_KEY, value);
  }

  get goalDate async{
    SharedPreferences dbClient = await db;
    return dbClient.getInt(DATE_KEY);
  }
  set goalDate(int value){
    SharedPreferences dbClient = db;
    dbClient.setInt(DATE_KEY, value);
  }

  get goalIsComplete async{
    SharedPreferences dbClient = await db;
    return dbClient.getBool(COMPLETE_KEY);
  }
  set goalIsComplete(bool value){
    SharedPreferences dbClient = db;
    dbClient.setBool(COMPLETE_KEY, value);
  }

  clearDB(){
    SharedPreferences dbClient = db;
    return dbClient.clear();
  }

}