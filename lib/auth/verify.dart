// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:team_app/auth/create_password.dart';
import 'package:team_app/auth/enter_password.dart';
import 'package:team_app/tools.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends StatefulWidget {
  final String memberId;

  const VerifyScreen({Key? key, required this.memberId}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController verificationCodeController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    verificationCodeController.dispose();
    super.dispose();
  }

  String resendCodeUrl =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/v2/resend-token";

  String url =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/v2/verify-token";
  void checkVerificationcode() async {
    Map<String, String>? headermap = Map();
    headermap['api_token'] = API_TOKEN;

    try {
      Response responce = await post(Uri.parse(url), headers: headermap, body: {
        'membership_id': widget.memberId,
        'verify_token': currentText,
      });
      if (responce.statusCode == 200) {
        setState(() {});
        var responseData = jsonDecode(responce.body.toString());
        print("${responseData['status']}  Kamyab");

        if (responseData['status'] == 1) {
          print("${responseData['status']}  asdasd");

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CreatePassword(memberId: widget.memberId)));
        }
      } else {
        print(responce.statusCode);
        uniqueAlert(
            context: context,
            heading: "Error",
            details: "Please enter Valid Code");
      }
    } catch (error) {
      print(error);
      uniqueAlert(
          context: context,
          heading: "Error",
          details: "Please enter Valid code");
    }
  }

  void resendVerificationcode() async {
    Map<String, String>? headermap = Map();
    headermap['api_token'] = API_TOKEN;

    try {
      Response responce =
          await post(Uri.parse(resendCodeUrl), headers: headermap, body: {
        'membership_id': widget.memberId,
      });
      if (responce.statusCode == 200) {
        setState(() {});
        var responseData = jsonDecode(responce.body.toString());
        print("${responseData['message']}  Kamyab");

        if (responseData['status'] == 1) {
          print("${responseData['status']}  asdasd");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData['message']),
            backgroundColor: appGreenColor,
          ));
        }
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
              'Verify',
              style: TextStyle(
                  color: appblackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please enter the verification code which you received on your registered mobile number',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appRedColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Verification Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appblackColor,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 90),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: appGreenColor,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: true,
                  obscuringCharacter: '*',
                  obscuringWidget:
                      Icon(Icons.lock_clock_sharp), //  FlutterLogo(
                  //   size: 24,
                  // ),
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                      errorBorderColor: appblackColor,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: appWhiteColor,
                      inactiveFillColor: appWhiteColor,
                      activeColor: appWhiteColor,
                      selectedFillColor: appGreenColor,
                      selectedColor: appblackColor,
                      disabledColor: appblackColor,
                      inactiveColor: appGreenColor),

                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: verificationCodeController,
                  keyboardType: TextInputType.number,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    print("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                resendVerificationcode();
              },
              child: Text(
                "Re-send Code",
                style: TextStyle(color: appRedColor),
              ),
              // style: ElevatedButton.styleFrom(primary: appRedColor),
            ),
            uniqueButton("Continue", () {
              checkVerificationcode();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => CreatePassword()));
            }),
          ],
        ),
      ),
    );
  }
}
