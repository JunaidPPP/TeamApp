// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:team_app/auth/enter_password.dart';
import 'package:team_app/auth/verify.dart';
import 'package:team_app/tools.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final memberIDController = TextEditingController();
  String url =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/v2/check-membership";
  @override
  void dispose() {
    memberIDController.dispose();
    super.dispose();
  }

  void checkMembership() async {
    Map<String, String>? headermap = Map();
    headermap['api_token'] = API_TOKEN;

    try {
      Response responce = await post(Uri.parse(url), headers: headermap, body: {
        'membership_id': memberIDController.value.text,
      });
      if (responce.statusCode == 200) {
        setState(() {});
        var responseData = jsonDecode(responce.body.toString());
        print("${responseData['status']}  Kamyab");

        if (responseData['status'] == 2) {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             EnterPassword(memberId: memberIDController.value.text)));
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  EnterPassword(memberId: memberIDController.value.text),
            ),
          );
        } else if (responseData['status'] == 1) {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  VerifyScreen(memberId: memberIDController.value.text),
            ),
          );

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => VerifyScreen(
          //               memberId: memberIDController.value.text,
          //             )));
        }
      } else {
        print(responce.statusCode);
        uniqueAlert(
            context: context,
            heading: "Error",
            details: "Please enter Valid ID");
      }
    } catch (error) {
      print(error);
      uniqueAlert(
          context: context, heading: "Error", details: "Please enter Valid ID");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              'Welcome',
              style: TextStyle(
                  color: appblackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            uniqueTextField(
                memberIDController, 'Menber-ID', TextInputType.number),
            uniqueButton("Connect", () {
              checkMembership();
            }),
          ],
        ),
      ),
    );
  }
}
