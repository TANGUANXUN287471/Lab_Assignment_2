import 'package:flutter/material.dart';
import 'package:barterit/screens/registrationscreen.dart';
import 'package:barterit/models/user.dart';
import 'package:barterit/screens/loginscreen.dart';

class ProfileTabScreen extends StatefulWidget {
  final User user;
  const ProfileTabScreen({super.key, required this.user});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Profile";
  late double screenHeight, screenWidth, cardwitdh;

  @override
  void initState() {
    super.initState();
    //print("Profile");
  }

  @override
  void dispose() {
    super.dispose();
    //print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: Center(
          child: Column(
        children: [
          Flexible(
              flex: 6,
              child: Card(
                elevation: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  width: screenWidth * 0.6,
                  child: Image.asset(
                    "assets/images/barter.jpg",
                  ),
                ),
                
              ]),
              )),
          Flexible(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(height:50),
                  Container(
                    child: const Center(
                      child: Text("PROFILE SETTINGS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  Expanded(
                      child: ListView(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          shrinkWrap: true,
                          children: const [])),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const LoginScreen()));
                    },
                    child: const Text("LOGIN"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>
                                  const RegistrationScreen()));
                    },
                    child: const Text("REGISTRATION"),
                  ),
                ],
              )),
        ],
      )
          /* Container(
            padding: const EdgeInsets.all(8),
            height: screenHeight * 0.25,
            width: screenWidth,
            child: Card(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  width: screenWidth * 0.4,
                  child: Image.asset(
                    "assets/images/profile.jpg",
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Text(
                          widget.user.name.toString(),
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(widget.user.email.toString()),
                        Text(widget.user.phone.toString()),
                        Text(widget.user.datereg.toString()),
                      ],
                    )),
              ]),
            ),
          ),
          Container(
            width: screenWidth,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.background,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: Text("PROFILE SETTINGS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const LoginScreen()));
                },
                child: const Text("LOGIN"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const RegistrationScreen()));
                },
                child: const Text("REGISTRATION"),
              ),
            ],
          ))
        ]),*/
          ),
    );
  }
}
