// ignore_for_file: prefer_const_constructors, avoid_print, prefer_collection_literals

import 'dart:convert';
// import 'dart:html';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_app/auth/forgot_password/first_forgot_screen.dart';
import 'package:team_app/home/home.dart';
import 'package:team_app/tools.dart';
import 'package:http/http.dart';

class EnterPassword extends StatefulWidget {
  final String memberId;
  const EnterPassword({Key? key, required this.memberId}) : super(key: key);

  @override
  _EnterPasswordState createState() => _EnterPasswordState();
}

class _EnterPasswordState extends State<EnterPassword> {
  // final memberIDController = TextEditingController();
  final passwordController = TextEditingController();
  String url =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/v2/login";
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    // memberIDController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(String id, password) async {
    // sharedPreferencesHelper sharedPreferencesOwn = sharedPreferencesHelper();

    //!one why to send headers
    Map<String, String>? headermap = Map();
    headermap['api_token'] = API_TOKEN;
    headermap['login_token'] = LOGIN_TOKEN;

    try {
      Response responce = await post(

          //
          Uri.parse(url),
          // !one why to send headers
          // headers: headermap,
          // !second why to send headers
          headers: {
            "api_token": API_TOKEN,
            "login_token": LOGIN_TOKEN,
          },

          //
          body: {
            'membership_id': id,
            'password': password,
            'device_os': Platform.isIOS ? "ios" : "Android",
            'device_token': "asd",
          });
      if (responce.statusCode == 200) {
        setState(() {});
        var loginResponseData = jsonDecode(responce.body.toString());
        print("login Kamyab");
        SharedPreferences prefs = await SharedPreferences.getInstance();
//!Saving Data in  SharedPreferences
        prefs.setString(
            "name", loginResponseData["data"]['user_details']["name"]);
        prefs.setString("father_name",
            loginResponseData["data"]['user_details']["father_name"]);
        prefs.setString("membership_id",
            loginResponseData["data"]['user_details']["membership_id"]);
        prefs.setString(
            "email", loginResponseData["data"]['user_details']["email"]);
        prefs.setString(
            "cnic", loginResponseData["data"]['user_details']["cnic"]);
        prefs.setString("cell_number",
            loginResponseData["data"]['user_details']["cell_number"]);
        prefs.setString(
            "dob", loginResponseData["data"]['user_details']["dob"]);
        prefs.setString(
            "gender", loginResponseData["data"]['user_details']["gender"]);
        prefs.setString("current_address",
            loginResponseData["data"]['user_details']["current_address"]);
        prefs.setInt("blockcode",
            loginResponseData["data"]['user_details']["blockcode"]);
        prefs.setString(
            "image", loginResponseData["data"]['user_details']["image"]);
        prefs.setInt("any_party_position",
            loginResponseData["data"]['user_details']["any_party_position"]);
        prefs.setString("complete_designation",
            loginResponseData["data"]['user_details']["complete_designation"]);
        prefs.setString("last_login_time",
            loginResponseData["data"]['user_details']["last_login_time"]);
        prefs.setString("created_at",
            loginResponseData["data"]['user_details']["created_at"]);
        prefs.setString("token", loginResponseData["data"]['token']);

        // print(loginResponseData["data"]['token']);

        // print("jzk" + listValue.toString());

        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => HomeScreen(),
          ),
        );

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      } else {
        print(responce.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // _isLoading
          //     ? Center(child: CircularProgressIndicator())
          //     :
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
            ),
            Text(
              'Enter Password',
              style: TextStyle(
                  color: appblackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            // uniqueTextField(
            //     memberIDController, "Member-ID", TextInputType.number),
            uniqueTextField(passwordController, 'Enter-Password',
                TextInputType.emailAddress),
            SizedBox(
              height: 100,
            ),
            uniqueButton("Login", () {
              setState(() {});
              login(widget.memberId, passwordController.value.text.toString());
              print(widget.memberId + passwordController.value.text);
            }),
            TextButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 58.0),
                  child: Text('Forgot Password'.toUpperCase(),
                      style: TextStyle(
                        color: appRedColor,
                        fontSize: 14,
                      )),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              FirstForgotScreen()));
                })
          ],
        ),
      ),
    );
  }
}
