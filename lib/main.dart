import 'package:employ_sample/emp_task.dart';
import 'package:employ_sample/login.dart';
import 'package:employ_sample/user_task_localstorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 await UserSharespreferences.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) 
         { 
           if(snapshot.connectionState==ConnectionState.active)
           {
             if(snapshot.hasData)
             {
               return EmpTask();
             }
             else if(snapshot.hasError)
             {
               return Center(child: Text("error"),);
             }
           }
           if(snapshot.connectionState==ConnectionState.waiting)
           {
             return Center(child: CircularProgressIndicator(color: Colors.amberAccent,),);
           }
           return LoginScreen();

          },)
    );
  }
}


