import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:barterit/screens/profiletabscreen.dart';
import 'package:barterit/screens/mainscreen.dart';
import 'package:barterit/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/libra.jpg'),
                  fit: BoxFit.cover)),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("BARTER IT",
                    style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink)),
                CircularProgressIndicator(),
                Text(
                  "Version 0.1",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ))
      ],
    ));
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    bool ischeck = (prefs.getBool('checkbox')) ?? false;
    late User user;
    if (ischeck) {
      try {
        http.post(Uri.parse("http://10.144.178.53/barterit/php/login_user.php"),
            body: {"email": email, "password": password}).then((response) {
          if (response.statusCode == 200) {
            var jsondata = jsonDecode(response.body);
            user = User.fromJson(jsondata['data']);
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(user: user))));
          } else {
            user = User(
                id: "N/A",
                name: "N/A",
                email: "N/A",
                phone: "N/A",
                datereg: "N/A",
                password: "N/A",
                otp: "N/A");
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(user: user))));
          }
        }).timeout(const Duration(seconds: 5), onTimeout: () {
          // Time has run out, do what you wanted to do.
        });
      } on TimeoutException catch (_) {
        print("Time out");
      }
    } else {
      user = User(
          id: "N/A",
          name: "N/A",
          email: "N/A",
          phone: "N/A",
          datereg: "N/A",
          password: "N/A",
          otp: "N/A");
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => MainScreen(user: user))));
    }
  }
}
