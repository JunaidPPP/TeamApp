// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_app/tools.dart';

var token = "";

class NotificationsFeedsScreen extends StatefulWidget {
  const NotificationsFeedsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsFeedsScreenState createState() =>
      _NotificationsFeedsScreenState();
}

class _NotificationsFeedsScreenState extends State<NotificationsFeedsScreen> {
  List<dynamic>? data;
  String url =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/news-feeds/get-all";

  @override
  void initState() {
    super.initState();
    initdata();
  }

  initdata() async {
    await getNotificatios();
  }

  Future getNotificatios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token').toString();
    });
    try {
      Response responce = await post(
        Uri.parse(url),
        headers: {
          "api_token": API_TOKEN,
          "authorization": "Bearer $token",
        },
      );
      if (responce.statusCode == 200) {
        setState(() {});
        var responseData = jsonDecode(responce.body.toString());

        data = responseData["data"];
        print("Notificatios recv");

        // prefs.setString("created_at",
        //     loginResponseData["data"]['user_details']["created_at"]);

        print(data);
      } else {
        print(responce.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return data != null
        ? ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  margin: EdgeInsets.only(left: 5, top: 5, right: 5),
                  // width: 20,
                  decoration: BoxDecoration(
                    color: appWhiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: appblackColor.withOpacity(0.2),
                        spreadRadius: 0.1,
                        blurRadius: 4,
                        offset: Offset(
                          0,
                          -3,
                        ), // changes position of shadow
                      ),
                    ],
                  ),

                  // color: appGreenColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data![index]['title'].toString(),
                          style: TextStyle(
                              color: appblackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          data![index]['created_at'].toString(),
                          style: TextStyle(
                              color: appblackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(data![index]['description'].toString()),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                                data![index]['images'][0].toString()),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          );
  }
}
