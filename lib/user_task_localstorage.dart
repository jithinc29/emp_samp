import 'package:shared_preferences/shared_preferences.dart';

class UserSharespreferences
{
   static late SharedPreferences _preferences;

  static Future init()async=>_preferences=await SharedPreferences.getInstance();

  static Future setTaskname(String taskname)async=>await _preferences.setString("tname", taskname);
  static String? getTaskname()=>_preferences.getString("tname");
  static Future setTaskcategory(String taskcategory)async=>await _preferences.setString("tcategory", taskcategory);
  static String? getTaskcategory()=>_preferences.getString("tcategory");
  static Future setUID(String uid)async=>await _preferences.setString("uid", uid);
  static String? getUID()=>_preferences.getString("uid");
  static Future setName(String name)async=>await _preferences.setString("name", name);
  static String? getName()=>_preferences.getString("name");

  // static Future setTaskName(String taskname)async=>await _preferences.setString("taskname", taskname);
  // static String? getTaskName()=>_preferences.getString("taskname");

  // static Future setTaskCategory(String taskcategory)async=>await _preferences.setString("taskcategory", taskcategory);
  // static String? getTaskCategory()=>_preferences.getString("taskcategory");

}