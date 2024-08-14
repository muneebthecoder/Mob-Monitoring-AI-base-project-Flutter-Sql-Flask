import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Screens/Login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  File? pickimage;
  List<String> rlist = ["Operator", "Officer"];
  String selectedRole = "Operator";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blueGrey,
                  Colors.grey,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    SizedBox(
                    height: 80.0,
                  ),
                  Text("Mob Monitoring",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.white),),
                   SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    height: 540.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              //               fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                       
                          SizedBox(
                            height: 15,
                          ),
                          MyTextFormWithIcon(
                              controller: name,
                              hintText: "Name",
                              labelText: "Name",
                              icon: Icon(Icons.person_outline_outlined)),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextFormWithIcon(
                              controller: email,
                              hintText: "Emial",
                              labelText: "Email",
                              icon: Icon(Icons.email_outlined)),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextFormWithIcon(
                              controller: phone,
                              hintText: "Phone no",
                              labelText: "Phone no",
                              icon: Icon(Icons.phone_outlined)),
                          SizedBox(
                            height: 10,
                          ),
                          MyTextFormWithIcon(
                              controller: password,
                              hintText: "Password",
                              labelText: "Password",
                              icon: Icon(Icons.lock_outline_rounded)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("  Role       ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 235, 238, 239),
                                ),
                                height: 30,
                                width: 100,
                                child: Center(
                                  child: DropdownButton(
                                      underline: Container(),
                                      dropdownColor:
                                          Color.fromARGB(255, 235, 238, 239),
                                      iconDisabledColor: Colors.black,
                                      iconEnabledColor: Colors.black,
                                      style: TextStyle(color: Colors.black),
                                      value: selectedRole,
                                      items: rlist
                                          .map((e) => DropdownMenuItem(
                                              value: e, child: Text(e)))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedRole = value!;
                                        });
                                      }),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black),
                                child: Center(
                                    child: Text("Sign Up",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          //  fontWeight: FontWeight.bold
                                        )))),
                            onTap: () async {
                              if (password.text == "" || email.text=="" || phone.text=="" || name.text=="") {
                                 showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      'Please enter all information ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              );
                            });
                              } else {
                                int statuscode = await APIHandler().SignUp(
                                  name.text,
                                  password.text,
                                  phone.text,
                                  email.text,
                                  selectedRole,
                                );
                                print(statuscode);
                                if (statuscode == 200) {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                  }));
                                   showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      'Account create successfully ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Icon(
                                      Icons.check_box,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                              );
                            });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Error $statuscode'),
                                        );
                                      });
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyLinklabel(
                                  text: "Already have an account?   ",
                                  onTap: () {},
                                  color: Colors.black),
                              MyLinklabel(
                                  text: "Login",
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                    }));
                                  }),
                            ],
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
