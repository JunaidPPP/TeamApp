// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:team_app/auth/enter_password.dart';
import 'package:team_app/tools.dart';

class CreatePassword extends StatefulWidget {
  final String memberId;
  const CreatePassword({Key? key, required this.memberId}) : super(key: key);

  @override
  _CreatePasswordState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  String newPasswordUrl =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/v2/new-password";

  final newPasswordController = TextEditingController();
  final confirmationPasswordController = TextEditingController();
  @override
  void dispose() {
    newPasswordController.dispose();
    confirmationPasswordController.dispose();
    super.dispose();
  }

  void resetPassword() async {
    try {
      Response responce = await post(Uri.parse(newPasswordUrl), headers: {
        "api_token": API_TOKEN,
      }, body: {
        'membership_id': widget.memberId,
        'password': newPasswordController.value.text,
        'password_confirmation': confirmationPasswordController.value.text,
        'device_token': "1231213", // widget.diviceTokeen,
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
        print(responseData);
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
              'Create a Password',
              style: TextStyle(
                  color: appblackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            uniqueTextField(newPasswordController, 'New-Password',
                TextInputType.streetAddress),
            uniqueTextField(confirmationPasswordController, 'Confirm-Password',
                TextInputType.streetAddress),
            SizedBox(
              height: 40,
            ),
            uniqueButton("Set Password", () {
              if (newPasswordController.value.text ==
                  confirmationPasswordController.value.text) {
                resetPassword();
              } else {
                uniqueAlert(
                    context: context,
                    heading: "ERROR",
                    details: "Please enter same Password");
              }
            }),
          ],
        ),
      ),
    );
  }
}
