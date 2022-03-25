// import 'package:flutter/material.dart';
// import 'package:team_app/auth/enter_password.dart';
// import 'package:team_app/auth/login.dart';

// import '../tools.dart';

// class FirstScreen extends StatefulWidget {
//   const FirstScreen({Key? key}) : super(key: key);

//   @override
//   _FirstScreenState createState() => _FirstScreenState();
// }

// class _FirstScreenState extends State<FirstScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // var hight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Text(
//             //   'Welcome',
//             //   style: TextStyle(
//             //       color: appblackColor,
//             //       fontWeight: FontWeight.bold,
//             //       fontSize: 40),
//             // ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 30),
//               child: Image.asset(
//                 'assets/images/logo.png',
//                 height: 390,
//               ),
//             ),
//             // SizedBox(
//             //   height: hight - 380,
//             // ),
//             uniqueButton(" Sign-In ", () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext context) =>
//                           const EnterPassword()));
//             }),
//             uniqueButton("Sign-Up", () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext context) => const LoginScreen()));
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
