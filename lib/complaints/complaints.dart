// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_app/complaints/lodge_complaint.dart';
import 'package:team_app/tools.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({Key? key}) : super(key: key);

  @override
  _ComplaintsScreenState createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  var token = "";
  Map<String, dynamic>? data;
  List<dynamic>? listingData;
  int? comlpaintColor;
  int? all;
  int? pending;
  int? completed;
  int? inprogress;
  String urlComplaintsStatus =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/complaints/complaints-status";
  String urlGetAllComplaints =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/complaints/get-all";

  @override
  void initState() {
    super.initState();
    initdata();
  }

  initdata() async {
    await getComplaintsStatus();
    await getComplaintsList();
  }

  Future getComplaintsStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token').toString();
    });
    try {
      Response responce = await post(
        Uri.parse(urlComplaintsStatus),
        headers: {
          "api_token": API_TOKEN,
          "authorization": "Bearer $token",
        },
      );
      if (responce.statusCode == 200) {
        setState(() {
          // _isLoading = false;
        });
        var responseData = jsonDecode(responce.body.toString());

        data = responseData["data"];
        all = responseData["data"]["all"];
        pending = responseData["data"]["pending"];
        completed = responseData["data"]["completed"];
        inprogress = responseData["data"]["inprogress"];
        print(" Complaints recv");
      } else {
        print(responce.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  Future getComplaintsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token').toString();
    });
    try {
      Response responce = await post(
        Uri.parse(urlGetAllComplaints),
        headers: {
          "api_token": API_TOKEN,
          "authorization": "Bearer $token",
        },
      );
      if (responce.statusCode == 200) {
        setState(() {
          // _isLoading = false;
        });
        var responseData = jsonDecode(responce.body.toString());

        listingData = responseData["data"]["complaints"]["data"];
        // all = responseData["data"]["all"];

        // pending = responseData["data"]["pending"];
        // completed = responseData["data"]["completed"];
        // inprogress = responseData["data"]["inprogress"];
        print(" Complaints recv");
        print(listingData);

        // prefs.setString("created_at",
        //     loginResponseData["data"]['user_details']["created_at"]);

        // print(data);
        // print(all);
        // print(pending);
        // print(completed);
        // print(inprogress);
      } else {
        print(responce.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      // shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: appblackColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            height: 140,
            width: width - 20,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Column(
                    children: [
                      Text(
                        'Your Complaints',
                        style: TextStyle(
                            color: appblackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        all.toString(),
                        style: TextStyle(
                            color: appRedColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Completed',
                          style: TextStyle(
                              color: appblackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          completed.toString(),
                          style: TextStyle(
                              color: appRedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        children: [
                          Text(
                            'In progress',
                            style: TextStyle(
                                color: appblackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            inprogress.toString(),
                            style: TextStyle(
                                color: appRedColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'Pending',
                          style: TextStyle(
                              color: appblackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          pending.toString(),
                          style: TextStyle(
                              color: appRedColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 160.0),
          child: listingData != null
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: listingData!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 5, top: 5, right: 5),
                        // width: 20,
                        decoration: BoxDecoration(
                          color: appWhiteColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: appblackColor.withOpacity(0.2),
                              spreadRadius: 0.1,
                              blurRadius: 4,
                              offset: const Offset(
                                0,
                                -3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listingData![index]['complaint_type']
                                        .toString(),
                                    style: TextStyle(
                                        color: appblackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        " ${listingData![index]['complaint_status'].toString()} ",
                                        style: TextStyle(
                                            color: appWhiteColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(int.parse(
                                            '0xFF${listingData![index]['status_color']}'
                                                .replaceFirst(
                                                    RegExp(r"#"), ""))),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                ],
                              ),
                              Text(
                                listingData![index]['complain_issues']
                                    .toString(),
                                style: TextStyle(
                                    color: appblackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Date: ",
                                      style: TextStyle(
                                          color: appblackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      listingData![index]['complain_date']
                                          .toString(),
                                      style: TextStyle(
                                          color: appblackColor, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              Row(
                                children: [
                                  Text(
                                    "Discription: ",
                                    style: TextStyle(
                                        color: appblackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  Text(listingData![index]['details']
                                      .toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
        ),
        Positioned.fill(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: uniqueButton("Lodge a complaint", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LodgeComplaintScreen()));
              })),
        )
      ],
    );
  }
}
