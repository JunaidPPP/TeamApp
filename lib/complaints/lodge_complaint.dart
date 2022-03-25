// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_app/complaints/drop_down_model.dart';
import 'package:team_app/tools.dart';
import 'package:location/location.dart';

class LodgeComplaintScreen extends StatefulWidget {
  const LodgeComplaintScreen({Key? key}) : super(key: key);

  @override
  _LodgeComplaintScreenState createState() => _LodgeComplaintScreenState();
}

class _LodgeComplaintScreenState extends State<LodgeComplaintScreen> {
  var token;
  var data = <dynamic>[];

  var complaintsType = <dynamic>[];
  var complainTypesNumber = <int>[];
  var typesItems = <DropDownModel>[];

  var complainIds = <dynamic>[];
  var complainIdsNumber = <int>[];
  var items = <DropDownModel>[];
  // String dropdownValue = 'General';
  DropDownModel? dropdownValue2;
  DropDownModel? dropdownValue;
  var lat, long;
  final complaintController = TextEditingController();

  String urlComplaintsSomtype =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/complaints/complaints-issue-by-comtype";
  String urlComplaintsSubmit =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/complaints/add-complaint";
  String urlComplaintsHeading =
      "http://starscream-env.pazxmnj4vk.ap-southeast-1.elasticbeanstalk.com/api/complaints/get-complaint-types";

  @override
  void initState() {
    super.initState();
    initdata();
  }

  initdata() async {
    getPosition();
    await getComplaintsStatus();
    await getComplaintsTypes();
  }

  Future getComplaintsTypes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token').toString();
    });
    try {
      Response responce = await get(
        Uri.parse(urlComplaintsHeading),
        headers: {
          "api_token": API_TOKEN,
          "Authorization": "Bearer $token",
        },
      );
      if (responce.statusCode == 200) {
        var responseData = jsonDecode(responce.body.toString());

        complaintsType = responseData["data"];

        for (int i = 0; i < complaintsType.length; i++) {
          // print(complaintsType[i]["id"]);
          setState(() {
            DropDownModel complaint = DropDownModel(
                id: complaintsType[i]["id"], name: complaintsType[i]["title"]);

            typesItems.add(complaint);

            dropdownValue = complaint;
            // complainTypesNumber.add(complaintsType[i]["complaint_id"]);
          });
        }

        print(" suggtions recv");
        // print(data);
      } else {
        print(responce.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  Future getComplaintsStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token').toString();
    });
    try {
      Response responce = await post(Uri.parse(urlComplaintsSomtype), headers: {
        "api_token": API_TOKEN,
        "authorization": "Bearer $token",
      }, body: {
        "complaint_type":
            dropdownValue != null ? dropdownValue!.id.toString() : "1"
        // dropdownValue == "General"
        //     ? "1"
        //     : dropdownValue == "Party"
        //         ? "2"
        //         : dropdownValue == "Goverment"
        //             ? "3"
        //             : "4"
      });
      if (responce.statusCode == 200) {
        setState(() {
          // _isLoading = false;
        });
        var responseData = jsonDecode(responce.body.toString());

        data = responseData["data"];
        // complainIds = responseData["data"];
        // print(data);
        for (int i = 0; i < data.length; i++) {
          // items.clear();
          // print(data[i]["name"]);
          // print(data[i]["id"]);
          setState(() {
            DropDownModel complaint =
                DropDownModel(id: data[i]["id"], name: data[i]["name"]);

            items.add(complaint);

            dropdownValue2 = complaint;
            complainIdsNumber.add(data[i]["id"]);
          });
        }

        print(" suggtions recv");
        // print(data);
      } else {
        print(responce.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  getPosition() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // return;
        _permissionGranted = await location.requestPermission();
      }
    }

    _locationData = await location.getLocation();
    lat = _locationData.latitude;
    long = _locationData.longitude;
    print(_locationData.latitude.toString());
    print(_locationData.longitude);
  }

  submitComplaint() async {
    try {
      Response responce = await post(Uri.parse(urlComplaintsSubmit), headers: {
        "api_token": API_TOKEN,
        "authorization": "Bearer $token",
      }, body: {
        'complaint_type': dropdownValue!.id.toString(),
        //  dropdownValue == "General"
        //     ? "1"
        //     : dropdownValue == "Party"
        //         ? "2"
        //         : dropdownValue == "Goverment"
        //             ? "3"
        //             : "4",
        'complaint_issue': dropdownValue2!.id.toString(),
        'details': complaintController.value.text.toString(),
        'complaint_matter': "3",
        'complaint_latitude': lat.toString(),
        'complaint_longitude': long.toString(),
      });
      print(dropdownValue!.id.toString());
      print(dropdownValue2!.id.toString());

      if (responce.statusCode == 200) {
        var loginResponseData = jsonDecode(responce.body.toString());
        print(loginResponseData['message']);
        print("Submit Kamyab");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loginResponseData['message'])));

        Navigator.pop(context);
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appblackColor,
        title: Text(appName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                'Lodge a complaint'.toUpperCase(),
                style: TextStyle(
                    color: appblackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),

              //!
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  width: width - 20,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: appblackColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<DropDownModel>(
                    value: dropdownValue,
                    iconSize: 0,
                    // icon: const Icon(Icons.arrow_downward),
                    // elevation: 6,
                    style: TextStyle(color: appblackColor),
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (DropDownModel? newValue) {
                      setState(() async {
                        dropdownValue = newValue!;
                        await getComplaintsStatus();
                        print(newValue.id);
                        // items[]
                      });
                    },
                    items: typesItems
                        .map<DropdownMenuItem<DropDownModel>>((value) {
                      return DropdownMenuItem<DropDownModel>(
                        value: value,
                        child: Text(
                          value.name,
                          maxLines: 2,
                          style: TextStyle(
                              color: appblackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  width: width - 20,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: appblackColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<DropDownModel>(
                    value: dropdownValue2,
                    iconSize: 0,
                    // icon: const Icon(Icons.arrow_downward),
                    // elevation: 6,
                    style: TextStyle(color: appblackColor),
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (DropDownModel? newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;

                        // items[]
                      });
                    },
                    items: items.map<DropdownMenuItem<DropDownModel>>((value) {
                      return DropdownMenuItem<DropDownModel>(
                        value: value,
                        child: Text(
                          value.name,
                          maxLines: 2,
                          style: TextStyle(
                              color: appblackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: appblackColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: TextFormField(
                      controller: complaintController,
                      maxLines: 8,
                      maxLength: 3000,
                      // obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'enter your Message here',
                        labelStyle: TextStyle(
                          color: appblackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // const Spacer(),
              uniqueButton(
                'submit',
                () {
                  submitComplaint();
                  // getPosition();

                  // items.clear();
                  // initdata();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Padding uniqueDropDown(
  //   double width,
  //   totalItems,
  // ) {
  //   return

  //   Padding(
  //     padding: const EdgeInsets.only(top: 25.0),
  //     child: Container(
  //       width: width - 20,
  //       padding: const EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         color: appblackColor.withOpacity(0.2),
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       child: DropdownButton<DropDownModel>(
  //         value: dropdownValue,
  //         iconSize: 0,
  //         // icon: const Icon(Icons.arrow_downward),
  //         // elevation: 6,
  //         style: TextStyle(color: appblackColor),
  //         underline: Container(
  //           height: 0,
  //         ),
  //         onChanged: (DropDownModel? newValue) {
  //           items.clear();
  //           initdata();
  //           setState(() {
  //             dropdownValue = newValue!;
  //           });
  //         },
  //         items: totalItems
  //             .map<DropdownMenuItem<DropDownModel>>((DropDownModel value) {
  //           return DropdownMenuItem<DropDownModel>(
  //             value: value,
  //             child: Text(
  //               value.name,
  //               style: TextStyle(
  //                   color: appblackColor,
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 15),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }
}
