

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employ_sample/emp_task.dart';

import 'package:employ_sample/register.dart';
import 'package:employ_sample/user_task_localstorage.dart';
import 'package:employ_sample/widgets/error_dialog.dart';
import 'package:employ_sample/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController=TextEditingController();

    final _passController=TextEditingController();
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }
     final  FirebaseAuth _auth=FirebaseAuth.instance;
    

   Future formvalidation()
   async {
      if(_emailController.text.isNotEmpty&&_passController.text.isNotEmpty)
      {
        showDialog(context: context, builder: (c){
          return LoadingDialog(message: "Logging now",);
        });
        loginUser();
      }
      else
      {
        showDialog(context: context, builder: (c){
          return ErrorDialog(message: "Incorrect credentials",);
        });
      }
    }

   Future loginUser()
    async{

      User? currentuser;

      await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passController.text).then((auth){

        currentuser=auth.user;

      }).catchError((error){

        Navigator.pop(context);
        return showDialog(context: context, builder: (c){
          return ErrorDialog(message:error.message.toString() ,);
        });
      });

      if(currentuser!=null)
      {
        readAndSetDataLocally(currentuser!).then((value){
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>EmpTask()));
          
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (c)=>EmpTask()));


      }


    }

    Future readAndSetDataLocally(User currentuser)
    async{
     

      await FirebaseFirestore.instance.collection("employee").doc(currentuser.uid).get().then((snapshot)async{
        // await sharedPreferences!.setString("uid", currentuser.uid);
        // await sharedPreferences!.setString("name",snapshot.data()!["name"]);
        // await sharedPreferences!.setString("email",snapshot.data()!["email"]);

        await UserSharespreferences.setUID(currentuser.uid);
        await UserSharespreferences.setName(snapshot.data()!["name"]);

        


        

      });

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amberAccent,
              Colors.tealAccent,
            ]
          )
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text("EMPLOYEE APP"),

          
           

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(left: 10),
              height: 50,
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              child: TextField(
                controller: _emailController,

                decoration: InputDecoration(
                  
              
                  border: InputBorder.none,
                  hintText: "email"),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(left: 10),
              height: 50,
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              child: TextField(
                controller: _passController,

                decoration: InputDecoration(
                  
              
                  border: InputBorder.none,
                  hintText: "password"),
              ),
            ),
            SizedBox(height: 20,),

            InkWell(
              onTap: (){

             formvalidation();

                

              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Center(child: Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            
              ),
            ),
             SizedBox(height: 50,),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=>RegisterScreen()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Text(
                "GO TO REGISTER",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ),
          )

        ],
      ),
      )
      
    );
  }
}