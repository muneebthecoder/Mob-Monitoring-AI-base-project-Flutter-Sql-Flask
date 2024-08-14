import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Screens/Home.dart';
import 'package:mob_monitoring/Screens/Signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscureText = true;

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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        //    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                //              fontWeight: FontWeight.bold,
                                fontSize: 34),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          MyTextFormWithIcon(
                              controller: email,
                              hintText: "Email id or phone no",
                              labelText: "Email id or phone no",
                              icon: Icon(Icons.email_outlined)),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 55.0,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 235, 238, 239),
                              borderRadius: BorderRadius.circular(10),
                              //     border: Border.all(color: Colors.black)
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(child: Icon(Icons.lock_outline)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 240,
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 14),
                                      controller: password,
                                      cursorColor:
                                          Color.fromARGB(255, 60, 59, 59),
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(_obscureText
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          ),
                                          hintText: "Password",
                                          labelText: "Password",
                                          border: InputBorder.none,
                                          focusColor:
                                              Color.fromARGB(255, 60, 59, 59),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 10.0),
                                          labelStyle:
                                              TextStyle(color: Colors.black)),
                                      obscuringCharacter: '*',
                                      obscureText: _obscureText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10.0,
                          ),
                          MyLinklabel(
                              text: "    Forgotten password",
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return ForgottenPassword();
                                }));
                              }),
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
                                    child: Text("Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          //     fontWeight: FontWeight.bold
                                        )))),
                            onTap: () async {
                              if (password.text == "" || email.text == "") {
                               showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      'Email or password \nnot matched ',
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
                                Response response = await APIHandler().SignIn(
                                  email.text,
                                  password.text,
                                );
                                userInfo = jsonDecode(response.body);
                                if (userInfo[1] == 200) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return HomeScreen();
                                  }));
                                } else {
                                   showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      '${userInfo[0]['message']} ',
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
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return AlertDialog(
                                  //         title:
                                  //             Text('${userInfo[0]['message']}'),
                                  //       );
                                  //     });
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
                                  text: "Don't have an account? ",
                                  onTap: () {},
                                  color: Colors.black),
                              MyLinklabel(
                                  text: "Sign Up",
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return SignupScreen();
                                    }));
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Row(mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text("_________________",style: TextStyle(decoration: TextDecoration.underline,fontWeight:FontWeight.bold)),
                          //     Text("   OR   "),
                          //     Text("_________________",style: TextStyle(decoration: TextDecoration.underline,fontWeight:FontWeight.bold),)
                          //     ],
                          // ),
                          // SizedBox(height: 20,),
                          // Row(mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [

                          //     Container(child:Image.asset("assets/images/gmail.png",
                          //   height: 50,
                          //   width: 50,
                          // ),),
                          // SizedBox( width: 80,),
                          // Container(child:Image.asset("assets/images/apple.png",
                          //   height: 50,
                          //   width: 50,
                          // ),),
                          //   ],
                          // ),
                          SizedBox(
                            height: 30,
                          )
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

class ForgottenPassword extends StatefulWidget {
  const ForgottenPassword({super.key});

  @override
  State<ForgottenPassword> createState() => _ForgottenPasswordState();
}

class _ForgottenPasswordState extends State<ForgottenPassword> {
  TextEditingController passC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  late Response response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: const Color.fromARGB(255, 217, 222, 224),
      ),
      backgroundColor: const Color.fromARGB(255, 217, 222, 224),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
            
              Text(
                "Change your password...",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              MyTextForm(
                  controller: emailC,
                  hintText: "Enter You Email",
                  labelText: "Email"),
              SizedBox(
                height: 10,
              ),
              MyTextForm(
                  controller: passC,
                  hintText: "New Password",
                  labelText: "New Password"),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: Center(
                        child: Text("Change Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              //     fontWeight: FontWeight.bold
                            )))),
                onTap: () async {
                  int statuscode = await APIHandler()
                      .ChangePassword(emailC.text, passC.text);
                  print(statuscode);
                  if (statuscode == 404) {
                    showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      'Account Not Found ',
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
                  } else if (statuscode == 200) {  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                     showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    Text(
                                      'Password Update successfully ',
                                      style: TextStyle(fontSize: 12),
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
                            title: Text('Error....$statuscode'),
                          );
                        });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
