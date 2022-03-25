// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_app/tools.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userName = "";
  var fatherName = "";
  var userImage = "";
  var email = "";
  var cellNumber = "";
  var cnic = "";
  var blockcode = "";
  var dob = "";
  var gender = "";
  var currentAddress = "";
  var partyPosition = "";
  var memberSince = "";
  var lastActive = "";
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
      fatherName = prefs.getString('father_name').toString();
      userImage = prefs.getString('image').toString();
      email = prefs.getString('email').toString();
      cellNumber = prefs.getString('cell_number').toString();
      cnic = prefs.getString('cnic').toString();
      blockcode = prefs.getInt('blockcode').toString();
      dob = prefs.getString('dob').toString();
      gender = prefs.getString('gender').toString();
      currentAddress = prefs.getString('current_address').toString();
      partyPosition = prefs.getString('complete_designation').toString();
      memberSince = prefs.getString('created_at').toString();
      lastActive = prefs.getString('last_login_time').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appblackColor,
        title: Text(appName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          // padding: const EdgeInsets.only(left: 10.0, top: 10),
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(userImage),
                backgroundColor: Colors.transparent,
              ),
              Text(
                userName.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: appblackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                email.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: appblackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              ListTile(
                leading: Icon(Icons.contact_mail_outlined),
                title: Text("Father Name"),
                subtitle: Text(fatherName),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text("Phone Number"),
                subtitle: Text(cellNumber),
              ),
              ListTile(
                leading: Icon(Icons.web_rounded),
                title: Text("CNIC"),
                subtitle: Text(cnic),
              ),
              ListTile(
                leading: Icon(Icons.track_changes),
                title: Text("Blockcode"),
                subtitle: Text(blockcode),
              ),
              ListTile(
                leading: Icon(Icons.border_right_sharp),
                title: Text("D.O.B"),
                subtitle: Text(dob),
              ),
              ListTile(
                leading: Icon(Icons.safety_divider),
                title: Text("Gender"),
                subtitle: Text(gender),
              ),
              ListTile(
                leading: Icon(Icons.place),
                title: Text("Address"),
                subtitle: Text(currentAddress),
              ),
              ListTile(
                leading: Icon(Icons.contact_mail_outlined),
                title: Text("Member Since"),
                subtitle: Text(memberSince),
              ),
              ListTile(
                leading: Icon(Icons.wb_iridescent),
                title: Text("Party Position"),
                subtitle: Text(partyPosition),
              ),
              ListTile(
                leading: Icon(Icons.travel_explore_outlined),
                title: Text("Last active"),
                subtitle: Text(lastActive),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
