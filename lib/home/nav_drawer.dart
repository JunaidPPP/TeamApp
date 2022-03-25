import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_app/auth/first_screen.dart';
import 'package:team_app/auth/login.dart';
import 'package:team_app/home/sideMenuOptions/e_polling.dart';
import 'package:team_app/home/sideMenuOptions/leadership.dart';
import 'package:team_app/home/sideMenuOptions/profile.dart';
import 'package:team_app/home/sideMenuOptions/volunteering.dart';
import 'package:team_app/home/tarany.dart';
import 'package:team_app/tools.dart';

import 'sideMenuOptions/events.dart';

var userName = "";
var jmembershipId = "";
var userImage = "";

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  void initState() {
    super.initState();
    initdata();
  }

  initdata() async {
    await getListOfStringFromPreferences();
  }

  Future getListOfStringFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('name').toString();
      jmembershipId = prefs.getString('membership_id').toString();
      userImage = prefs.getString('image').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: appblackColor,
              child: DrawerHeader(
                  child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(userImage),
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    userName.toString(),
                    style: TextStyle(
                        color: appWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    jmembershipId.toString(),
                    style: TextStyle(
                        color: appWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                ],
              )),
            ),
            ListTile(
              tileColor: Colors.transparent,
              // leading: Icon(Icons.supervised_user_circle_rounded),
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ProfileScreen()))
              },
            ),
            ListTile(
              // leading: Icon(Icons.verified_user),
              title: const Text(
                'Events',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => {
                // Navigator.of(context).pop(),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const EventScreen()))
              },
            ),
            ListTile(
              // leading: Icon(Icons.settings),
              title: const Text(
                'volunteering',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const VolunteerScreen()))
              },
            ),
            ListTile(
              // leading: Icon(Icons.border_color),
              title: const Text(
                'LeaderShip',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LeadershipScreen()))
              },
            ),
            ListTile(
              // leading: Icon(Icons.exit_to_app),
              title: const Text(
                'PPP Tarany',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const TaranyScreen()))
              },
            ),
            // ListTile(
            //   // leading: Icon(Icons.exit_to_app),
            //   title: const Text(
            //     'Complaints',
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            //   onTap: () => {Navigator.of(context).pop()},
            // ),
            ListTile(
              // leading: Icon(Icons.exit_to_app),
              title: const Text(
                'E Pollings',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const EPollingScreen()))
              },
            ),
            ListTile(
              // leading: Icon(Icons.exit_to_app),
              title: Text(
                'Logout',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: appRedColor),
              ),
              onTap: () => {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => const FirstScreen()))

                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LoginScreen(),
                  ),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
