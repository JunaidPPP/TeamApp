// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart';

//AppName
String appName = "TeamApp";
//AppColors
Color get appblackColor => const Color(0xFF000000);
Color get appRedColor => const Color(0xFF910101);
Color get appGreenColor => const Color(0xFF0aa308);
Color get appGreyColor => const Color(0xFF7c7b7b);
Color get appWhiteColor => const Color(0xFFffffff);
Color get appTransparentColor => Colors.transparent;
//AppKeys
final formKey = GlobalKey<FormState>();
// AppStaticToken
const String LOGIN_TOKEN =
    '\$2y\$10\$a3EbZh9TV8h9swvZBEtcj.GL99OLqQhYLOqEt/qYYnJ5EV6SQpIG';
const String API_TOKEN = 'd53gef4hy754y5yte7t7it7yecryhtesu4d7irg';
//AppBbuttons
TextButton uniqueButton(String title, press) {
  return TextButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 58.0),
        child: Text(title.toUpperCase(),
            style: const TextStyle(
              fontSize: 14,
            )),
      ),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(appWhiteColor),
          backgroundColor: MaterialStateProperty.all<Color>(appRedColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: appRedColor)))),
      onPressed: press);
}

//App Textfield
Padding uniqueTextField(TextEditingController controller, String labelText,
    TextInputType keyboardType) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(width: 2, color: appGreenColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(width: 2, color: appRedColor),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 2,
            )),
        labelText: labelText,
        labelStyle: TextStyle(color: appblackColor),
      ),
    ),
  );
}

//AppAlert
uniqueAlert(
    {@required context, required String heading, required String details}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        heading,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Text(
                    details,
                    style: TextStyle(color: appblackColor, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: appGreenColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}

//AppSpecialFunctions
extension E on String {
  String lastChars(int n) => substring(length - n);
}

void postApi({
  required String url,
  required Map<String, String> header,
  required Object? body,
  required Function? work,
}) async {
  try {
    Response responce = await post(Uri.parse(url), headers: header, body: body);
    work;
  } catch (error) {
    print(error);
  }
}
