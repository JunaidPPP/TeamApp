// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:team_app/complaints/complaints.dart';
import 'package:team_app/notifications/notificationsFeeds.dart';
import 'package:team_app/social_media/social_media.dart';
import 'package:team_app/tools.dart';

import 'nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: appblackColor,
          title: Text(appName),
          bottom: TabBar(
            // padding: EdgeInsets.only(left: 30, right: 30),
            isScrollable: true,
            unselectedLabelColor: appWhiteColor,
            labelColor: appRedColor,
            indicatorColor: appWhiteColor,
            tabs: [
              Tab(
                child: Text("notifications".toUpperCase(),
                    style: TextStyle(color: appWhiteColor, fontSize: 12)),
              ),
              Tab(
                child: Text("social media".toUpperCase(),
                    style: TextStyle(color: appWhiteColor, fontSize: 12)),
              ),
              Tab(
                child: Text("complaints".toUpperCase(),
                    style: TextStyle(color: appWhiteColor, fontSize: 12)),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NotificationsFeedsScreen(),
            SocialMedia(),
            ComplaintsScreen()
          ],
        ),
      ),
    );
  }
}
