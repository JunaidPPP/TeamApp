import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_app/models.dart';
import 'package:team_app/notifications/notificationsFeeds.dart';
import 'package:team_app/tools.dart';

class EPollingScreen extends StatefulWidget {
  const EPollingScreen({Key? key}) : super(key: key);

  @override
  _EPollingScreenState createState() => _EPollingScreenState();
}

class _EPollingScreenState extends State<EPollingScreen> {
  List<dynamic>? data = [];
  var leadershipList = <EventsModel>[];

  String url =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/leadership/get-all";

  @override
  void initState() {
    super.initState();
    initdata();
  }

  initdata() async {
    // await getEvents();
  }

  Future getEvents() async {
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
        for (int index = 0; index < data!.length; index++) {
          setState(() {
            EventsModel leadershipResponce = EventsModel(
              id: data![index]['id'],
              name: data![index]['name'],
              startDate: data![index]['start_date'],
              contactNumber: data![index]['contact_number'],
              designation: data![index]['designation'],
              province: data![index]['province'],
              division: data![index]['division'],
              district: data![index]['district'],
            );
            leadershipList.add(leadershipResponce);
            print(leadershipResponce.name);
          });
        }

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
        body: const Center(child: Text("No record found"))

        //  Stack(
        //   children: [
        //     leadershipList != null
        //         ? ListView.builder(
        //             itemCount: data!.length,
        //             itemBuilder: (context, index) {
        //               return data != null
        //                   ? Padding(
        //                       padding: const EdgeInsets.all(5.0),
        //                       child: Container(
        //                         margin: const EdgeInsets.only(
        //                             left: 5, top: 5, right: 5),
        //                         // width: 20,
        //                         decoration: BoxDecoration(
        //                           color: appWhiteColor,
        //                           borderRadius: BorderRadius.circular(15),
        //                           boxShadow: [
        //                             BoxShadow(
        //                               color: appblackColor.withOpacity(0.2),
        //                               spreadRadius: 0.1,
        //                               blurRadius: 4,
        //                               offset: const Offset(
        //                                 0,
        //                                 -3,
        //                               ), // changes position of shadow
        //                             ),
        //                           ],
        //                         ),

        //                         child: Padding(
        //                           padding: const EdgeInsets.all(10.0),
        //                           child: ListTile(
        //                             title: Text(
        //                               leadershipList[index].name,
        //                               style: TextStyle(
        //                                   color: appblackColor,
        //                                   fontWeight: FontWeight.bold,
        //                                   fontSize: 20),
        //                             ),
        //                             subtitle: Column(
        //                               crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                               children: [
        //                                 Text(
        //                                   leadershipList[index]
        //                                       .contactNumber
        //                                       .toUpperCase(),
        //                                   style: TextStyle(
        //                                       color: appblackColor, fontSize: 15),
        //                                 ),
        //                                 Text(
        //                                   leadershipList[index]
        //                                       .designation
        //                                       .toUpperCase(),
        //                                   style: TextStyle(
        //                                       color: appblackColor, fontSize: 15),
        //                                 ),
        //                               ],
        //                             ),
        //                             trailing: Icon(
        //                               Icons.phone,
        //                               color: appRedColor,
        //                               size: 25,
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     )
        //                   : const Center(child: CircularProgressIndicator());
        //             },
        //           )
        //         : const Center(child: CircularProgressIndicator()),
        //   ],
        // ),

        );
  }
}
