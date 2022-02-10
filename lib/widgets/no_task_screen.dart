import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NoTaskScreen extends StatefulWidget {
  const NoTaskScreen({Key? key}) : super(key: key);

  @override
  _NoTaskScreenState createState() => _NoTaskScreenState();
}

class _NoTaskScreenState extends State<NoTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("no task scree"),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
