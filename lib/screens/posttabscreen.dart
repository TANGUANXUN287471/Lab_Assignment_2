import 'package:flutter/material.dart';
import 'package:barterit/models/user.dart';


class PostTabScreen extends StatefulWidget {
  final User user;
  const PostTabScreen({super.key, required this.user});

  @override
  State<PostTabScreen> createState() => _PostTabScreenState();
}

class _PostTabScreenState extends State<PostTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Post";

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            
          },
          child: const Text(
            "+",
            style: TextStyle(fontSize: 32),
          )),
    );
  }
}