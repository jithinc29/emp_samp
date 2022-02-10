import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employ_sample/login.dart';
import 'package:employ_sample/user_task_localstorage.dart';
import 'package:employ_sample/widgets/model_task.dart';
import 'package:employ_sample/models/task_model.dart';

import 'package:employ_sample/widgets/task_card.dart';
import 'package:employ_sample/widgets/team_member.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color? activeCardColor = Colors.grey[400];
Color? selectedCardColor = Colors.grey[100];

class EmpTask extends StatefulWidget {
  const EmpTask({Key? key}) : super(key: key);

  @override
  State<EmpTask> createState() => _EmpTaskState();
}

class _EmpTaskState extends State<EmpTask> {
  List<TaskModel> taskModels = [];
  Future<List<TaskModel>> getdata() async {
    final data = await FirebaseFirestore.instance
        .collection("employee")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final data1 = data.data() as Map<String, dynamic>;
    print('user data $data1');
    UserModel userModel = UserModel.fromjson(data1);
    final taskData = await FirebaseFirestore.instance
        .collection("admintask")
        .doc(userModel.department)
        .collection("usertask")
        .get();

    // List<TaskModel> taskModels = [];
    taskData.docs.forEach((element) {
      taskModels
          .add(TaskModel.fromjson(element.data() as Map<String, dynamic>));
    });

    print('task data $taskData');
    print('task data ${taskModels.length}');
    return taskModels;
  }

  bool isapplied = true;

  @override
  Widget build(BuildContext context) {
    print("build calls");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
          title: Text(
            "${UserSharespreferences.getName()}",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                  });
                 
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 25,
                ))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                FutureBuilder<List<TaskModel>>(
                  future: getdata(),
                  builder: (
                    context,
                    snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        print("snap has error");
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        if (taskModels.length == 0) {
                          print("no task");
                          return Container(
                              width: 500,
                              height: 500,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No task available",
                                    style: TextStyle(fontSize: 30),
                                  )
                                ],
                              ));
                        }

                        print("snap has data");
                        print("snapshot data:$snapshot");

                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TaskCard(
                                      title: snapshot.data![index].name,

                                      category: snapshot.data![index].category,
                                      // "${snapshot.requireData.docs[index]["taskcatgory"]}",
                                      color: activeCardColor,
                                      ontap: () {
                                        setState(() {
                                          activeCardColor = selectedCardColor;
                                        });
                                      },
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Container(
                                          width: 330,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 12),
                                            child: Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Text(
                                                      "Create a payment with enables fast, simple checkout within your app, and gives you convenient access to hundreds of millions of cards",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  "Deadline",
                                                  style: GoogleFonts.martel(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(1, 1),
                                                          )
                                                        ],
                                                      ),
                                                      height: 40,
                                                      width: 140,
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(Icons
                                                                .calendar_today),
                                                            Text(
                                                              "12/1/2021",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(1, 1),
                                                          )
                                                        ],
                                                      ),
                                                      height: 40,
                                                      width: 140,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(Icons.timer),
                                                          Text("9:00 AM",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  "Team",
                                                  style: GoogleFonts.martel(
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TeamMember(
                                                      name: 'jithin',
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    TeamMember(
                                                      name: 'visal ',
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    TeamMember(
                                                      name: 'belwin',
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    TeamMember(
                                                      name: 'ashok',
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[400],
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.black,
                                                            blurRadius: 1,
                                                            offset:
                                                                Offset(0, 0))
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: isapplied
                                                        ? SizedBox(
                                                            height: 40,
                                                            child: TextButton(
                                                              child: const Text(
                                                                "Task Completed",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  isapplied =
                                                                      false;
                                                                });
                                                              },
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            height: 40,
                                                            child: const Icon(
                                                              Icons
                                                                  .task_alt_sharp,
                                                              color:
                                                                  Colors.white,
                                                              size: 30,
                                                            )))
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                );
                              }),
                        );
                      }
                    } else {
                      print("snap connectionstate");
                      return Text('State: ${snapshot.connectionState}');
                    }
                    return Text("taskk");
                  },
                ),


              ],
            )));
  }
}
