import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_app/home/tarany_play.dart';
import 'package:team_app/models.dart';
import 'package:team_app/notifications/notificationsFeeds.dart';
import 'package:team_app/tools.dart';

class TaranyScreen extends StatefulWidget {
  const TaranyScreen({Key? key}) : super(key: key);

  @override
  _TaranyScreenState createState() => _TaranyScreenState();
}

class _TaranyScreenState extends State<TaranyScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  // bool playing = false;

  List<dynamic>? data = [];
  var taranyList = <TaranyModel>[];

  String url =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/songs/get-all";

  @override
  void initState() {
    super.initState();
    initdata();
  }

  initdata() async {
    await getTarany();
  }

  Future getTarany() async {
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
        var responseData = jsonDecode(responce.body.toString());

        data = responseData["data"];
        // print(data);
        print(" recv");
        for (int index = 0; index < data!.length; index++) {
          setState(() {
            TaranyModel taranyResponce = TaranyModel(
              id: data![index]['id'],
              name: data![index]['name'],
              song: data![index]['song'],
              thumbnail: data![index]['thumbnail'],
              artist: data![index]['artist'],
            );
            taranyList.add(taranyResponce);
            print(taranyResponce.name);
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
      body:
          // const Center(child: Text("No record found"))

          Stack(
        children: [
          taranyList != null
              ? ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return data != null
                        ? InkWell(
                            onTap: () async {
                              openAlertBox(
                                taranyList[index].name,
                                taranyList[index].song,
                                taranyList[index].artist,
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         TaranaPlayingScreen(
                              //       song: taranyList[index].song,
                              //       image: taranyList[index].thumbnail,
                              //       name: taranyList[index].name,
                              //       artist: taranyList[index].artist,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 5, top: 5, right: 5),
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
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    title: Text(
                                      taranyList[index].name,
                                      style: TextStyle(
                                          color: appblackColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20),
                                    ),
                                    trailing: Icon(
                                      Icons.play_arrow_rounded,
                                      color: appRedColor,
                                      size: 45,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator());
                  },
                )
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  openAlertBox(
    String name,
    String song,
    String artist,
  ) {
    var playing = false;
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
                          name,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   Icons.fast_rewind_rounded,
                        //   size: 100,
                        //   color: appRedColor,
                        // ),
                        InkWell(
                            child: Icon(
                              playing == false
                                  ? Icons.play_arrow_rounded
                                  : Icons.pause,
                              color: appblackColor,
                              size: 100,
                            ),
                            onTap: () {
                              if (playing == false) {
                                audio.play(song);
                                setState(() {
                                  playing = true;
                                });
                              } else if (playing == true) {
                                audio.pause();
                                setState(() {
                                  playing = false;
                                });
                              }
                            }),
                        // Icon(
                        //   Icons.fast_forward_rounded,
                        //   size: 100,
                        //   color: appRedColor,
                        // ),
                      ],
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: appGreenColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Artist Name: $artist",
                          style: const TextStyle(color: Colors.white),
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
}
