import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:team_app/auth/enter_password.dart';

import '../../tools.dart';

class ThirdForgotScreen extends StatefulWidget {
  final String diviceTokeen;
  final String memberId;

  const ThirdForgotScreen(
      {Key? key, required this.diviceTokeen, required this.memberId})
      : super(key: key);

  @override
  _ThirdForgotScreenState createState() => _ThirdForgotScreenState();
}

class _ThirdForgotScreenState extends State<ThirdForgotScreen> {
  final newPasswordController = TextEditingController();
  final confirmationPasswordController = TextEditingController();
  String url =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/reset-password";

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmationPasswordController.dispose();
    super.dispose();
  }

  void resetPassword() async {
    try {
      Response responce = await post(Uri.parse(url), headers: {
        "api_token": API_TOKEN,
      }, body: {
        'membership_id': widget.memberId,
        'password': newPasswordController.value.text,
        'password_confirmation': confirmationPasswordController.value.text,
        'device_token': widget.diviceTokeen,
        'device_os': Platform.isIOS ? "ios" : "Android",
      });
      print(confirmationPasswordController.value.text);
      if (responce.statusCode == 200) {
        setState(() {});
        var responseData = jsonDecode(responce.body.toString());
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                EnterPassword(memberId: widget.memberId),
          ),
        );
      } else {
        uniqueAlert(
            context: context,
            heading: "Can't Proceed",
            details: "Sorry try again");
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
              'reset-password',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appblackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            uniqueTextField(
                newPasswordController, "New Password", TextInputType.number),
            uniqueTextField(confirmationPasswordController,
                "Password Confirmation", TextInputType.number),
            const SizedBox(
              height: 80,
            ),
            uniqueButton("continue", () {
              resetPassword();
            }),
          ],
        ),
      ),
    );
  }
}
