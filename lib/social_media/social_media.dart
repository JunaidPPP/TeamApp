// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:team_app/tools.dart';

final twitterApi = TwitterApi(
  client: TwitterClient(
      consumerKey: 'D3lQyd0WxVXEJINxINFGLFiGe',
      consumerSecret: '1dvzgIZoVxbCUKObd7WmZKBX67hbFobz7IbRHNQ3izrVxbQyvO',
      secret: '',
      token: ''),
);

class SocialMedia extends StatefulWidget {
  const SocialMedia({
    Key? key,
  }) : super(key: key);
  @override
  _SocialMediaState createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  Tweet? responce;
  List<Tweet?> responce2 = [];
  @override
  void initState() {
    super.initState();
    initdata();
  }

  initdata() async {
    await tweet();
  }

  Future<void> tweet() async {
    try {
      final userTimeline = await twitterApi.timelineService.userTimeline(
        screenName: "BBhuttoZardari",
        count: 200,
      );

      responce2 = userTimeline;
      for (var tweet in userTimeline) {
        print(tweet.fullText);
        responce = await tweet;
        setState(() {});
      }
    } catch (error) {
      print('error while requesting home timeline: $error');
    }
    // print(responce2[1]!.user!.defaultProfileImage);
  }

  @override
  build(BuildContext context) {
    // return Container();

    return responce != null
        ? ListView.builder(
            itemCount: responce2.length,
            itemBuilder: (context, index) {
              return responce != null
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(responce2[index]!
                                    .user!
                                    .profileImageUrlHttps
                                    .toString()),
                                radius: 30.0,
                                backgroundColor: appGreenColor.withOpacity(0.3),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        responce2[index]!.user!.name.toString(),
                                        style: TextStyle(
                                            color: appblackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        "@" +
                                            responce2[index]!
                                                .user!
                                                .screenName
                                                .toString(),
                                        style: TextStyle(
                                            color: appblackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        responce2[index]!.fullText.toString(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(responce2[index]!
                                              .user!
                                              .profileBannerUrl
                                              .toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: appblackColor.withOpacity(0.3),
                        )
                      ],
                    )
                  : const Center(child: Text('No Record'));
            },
          )
        : Center(
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          );
  }
}
