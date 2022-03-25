import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tools.dart';
import 'second_forgot_screen.dart';

class FirstForgotScreen extends StatefulWidget {
  const FirstForgotScreen({Key? key}) : super(key: key);

  @override
  _FirstForgotScreenState createState() => _FirstForgotScreenState();
}

class _FirstForgotScreenState extends State<FirstForgotScreen> {
  final memberIDController = TextEditingController();
  String url =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/forgot-password";

  @override
  void dispose() {
    memberIDController.dispose();
    super.dispose();
  }

  void sendMemberId() async {
    try {
      Response responce = await post(Uri.parse(url), headers: {
        "api_token": API_TOKEN,
      }, body: {
        'membership_id': memberIDController.value.text,
      });
      print(memberIDController.value.text);
      if (responce.statusCode == 200) {
        setState(() {});
        var responseData = jsonDecode(responce.body.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("memberFullId", responseData["data"]['membership_id']);
        print(responseData["data"]['membership_id']);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SeconForgotScreen(
                      memberId: responseData["data"]['membership_id'],
                    )));
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
      appBar: AppBar(
        backgroundColor: appblackColor,
        title: Text(appName),
      ),
      body: SingleChildScrollView(
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
              'Forgot Password',
              style: TextStyle(
                  color: appblackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            uniqueTextField(
                memberIDController, "Member-ID", TextInputType.number),
            const SizedBox(
              height: 100,
            ),
            uniqueButton("continue", () {
              if (memberIDController.value.text.length < 3) {
                print("object");
                uniqueAlert(
                    context: context,
                    heading: "Can't Proceed",
                    details: "Please add a valid Member-ID");
              } else {
                sendMemberId();
              }
            }),
          ],
        ),
      ),
    );
  }
}
