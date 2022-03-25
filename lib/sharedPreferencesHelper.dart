// ignore_for_file: camel_case_types, file_names, avoid_print

import 'package:shared_preferences/shared_preferences.dart';

//
//
//
//
//
//
//
//
//
class sharedPreferencesHelper {
  //!To Save DATA
  void setStringInPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("string", "This is String").then((value) => print(value));
  }

  void setIntInPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("int", 1).then((value) => print(value));
  }

  void setDoubleInPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setDouble("double", 1.1).then((value) => print(value));
  }

  void setBoolInPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("bool", true).then((value) => print(value));
  }

  void setStringListInPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(
        "list", <String>["StringList1", "StringList2", "StringList3"]);
  }

  //!To get DATA
  void getStringFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('String');
    print(stringValue);
  }

  void getIntFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt('int');
    print(intValue);
  }

  void getDoubleFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? doubleValue = prefs.getDouble('double');
    print(doubleValue);
  }

  void getBoolFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('bool');
    print(boolValue);
  }

  void getListOfStringFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? listValue = prefs.getStringList('list');
    print(listValue);
  }

  void removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(key);
  }
}
