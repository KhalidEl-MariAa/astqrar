import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late  SharedPreferences sharedpreferneces;
  static init()async{
    sharedpreferneces=await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key,required dynamic value})async{
    if(value is bool) {return await sharedpreferneces.setBool(key, value);}
    if(value is String) {return await sharedpreferneces.setString(key, value);}
    if(value is int) {
      return await sharedpreferneces.setInt(key, value);
    } else {
      return await sharedpreferneces.setDouble(key, value);
    }
  }

  static dynamic getData({required String key}){
    return sharedpreferneces.get(key);
  }
  static dynamic cleaData(){
    return sharedpreferneces.clear();
  }
}