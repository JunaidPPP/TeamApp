import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_app/auth/forgot_password/third_forgot_screen.dart';

import '../../tools.dart';

class SeconForgotScreen extends StatefulWidget {
  final String memberId;

  const SeconForgotScreen({Key? key, required this.memberId}) : super(key: key);

  @override
  _SeconForgotScreenState createState() => _SeconForgotScreenState();
}

class _SeconForgotScreenState extends State<SeconForgotScreen> {
  final fourDigitCodeController = TextEditingController();
  String url =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/verify-forgot-token";

  @override
  void dispose() {
    fourDigitCodeController.dispose();
    super.dispose();
  }

  void sendMemberIdAndToken() async {
    var lastSevenDigets = widget.memberId.lastChars(7);
    print(lastSevenDigets);
    try {
      Response responce = await post(Uri.parse(url), headers: {
        "api_token": API_TOKEN,
      }, body: {
        'membership_id': lastSevenDigets,
        'token': fourDigitCodeController.value.text,
      });
      print(fourDigitCodeController.value.text);
      if (responce.statusCode == 200) {
        setState(() {});
        var responseData = jsonDecode(responce.body.toString());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ThirdForgotScreen(
                      diviceTokeen: fourDigitCodeController.value.text,
                      memberId: lastSevenDigets,
                    )));
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
              'Enter 4-Digit Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: appblackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            uniqueTextField(
                fourDigitCodeController, "4-Digit Code", TextInputType.number),
            const SizedBox(
              height: 100,
            ),
            uniqueButton("continue", () {
              if (fourDigitCodeController.value.text.length < 3) {
                print("object");
                uniqueAlert(
                    context: context,
                    heading: "Can't Proceed",
                    details: "Please add a valid Code");
              } else {
                sendMemberIdAndToken();
              }
            }),
          ],
        ),
      ),
    );
  }
}
