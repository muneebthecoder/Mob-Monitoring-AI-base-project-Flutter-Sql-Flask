import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_monitoring/Api/ApiHandler.dart';
import 'package:mob_monitoring/CustomWidget.dart';
import 'package:mob_monitoring/Screens/Home.dart';
import 'package:mob_monitoring/Screens/Login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? pickimage;

  Future<void> _getImage(BuildContext context, ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      pickimage = File(pickedFile.path);
      await APIHandler()
          .uploadProfilePic(userInfo[0]['user']['id'], pickimage!);
    } else {
      print('No image selected.');
    }
    Response res = await APIHandler().searchById(userInfo[0]['user']['id']);
    userInfo = jsonDecode(res.body);

    setState(() {});

    Navigator.pop(context); // Close the bottom sheet
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library_outlined),
                  title: Text('Gallery'),
                  onTap: () => _getImage(context, ImageSource.gallery),
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt_outlined),
                  title: Text('Camera'),
                  onTap: () => _getImage(context, ImageSource.camera),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Setting",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          },
        ),
        //     actions: [Icon(Icons.settings)],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 115,
                      backgroundColor: Color.fromARGB(255, 218, 218, 217),
                      child: userInfo[0]['user']['img'] == ""
                          ? Icon(
                              Iconsax.user,
                              color: Colors.black,
                            )
                          : null,
                      backgroundImage: NetworkImage(
                          APIHandler.Userimgr_url + userInfo[0]['user']['img']),
                    ),
                    Positioned(
                        right: -16,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: Colors.white),
                              ),
                              backgroundColor: const Color(0xFFF5F6F9),
                            ),
                            onPressed: () {},
                            child: GestureDetector(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                              ),
                              onTap: () async {
                                _showOptions(context);
                                setState(() {});
                              },
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              MyMenuButton(
                text: "My Account",
                icon: Icon(Icons.person_2_outlined),
                press: () async {
                  Response res =
                      await APIHandler().searchById(userInfo[0]['user']['id']);
                  userInfo = jsonDecode(res.body);
                  setState(() {});
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return UserProfileScreen();
                  }));
                },
              ),
              MyMenuButton(
                text: "Change Password",
                icon: Icon(Icons.person_2_outlined),
                press: () async {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ForgottenPassword();
                  }));
                },
              ),
              MyMenuButton(
                text: "Logout",
                icon: Icon(Icons.logout_rounded),
                press: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  File? pickimage;
  List<String> rlist = ["Operator", "Officer"];
  String selectedRole = "Operator";

  @override
  void initState() {
    super.initState();

    name.text = userInfo[0]['user']['name'];
    email.text = userInfo[0]['user']['email'];
    phone.text = userInfo[0]['user']['phone'];
    password.text = userInfo[0]['user']['password'];
    selectedRole = "${userInfo[0]['user']['role']}";
    setState(() {});
  }

  Future<void> _getImage(BuildContext context, ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        pickimage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    Navigator.pop(context); // Close the bottom sheet
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library_outlined),
                  title: Text('Gallery'),
                  onTap: () => _getImage(context, ImageSource.gallery),
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt_outlined),
                  title: Text('Camera'),
                  onTap: () => _getImage(context, ImageSource.camera),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 115,
                    backgroundColor: Color.fromARGB(255, 218, 218, 217),
                    child: userInfo[0]['user']['img'] == ""
                        ? Icon(
                            Iconsax.user,
                            color: Colors.black,
                          )
                        : null,
                    backgroundImage: NetworkImage(
                        APIHandler.Userimgr_url + userInfo[0]['user']['img']),
                  ),
                  // Positioned(
                  //     right: -16,
                  //     bottom: 0,
                  //     child: SizedBox(
                  //       height: 46,
                  //       width: 46,
                  //       child: TextButton(
                  //         style: TextButton.styleFrom(
                  //           foregroundColor: Colors.white,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(50),
                  //             side: const BorderSide(color: Colors.white),
                  //           ),
                  //           backgroundColor: const Color(0xFFF5F6F9),
                  //         ),
                  //         onPressed: () async {
                  //           _showOptions(context);

                  //           setState(() {});
                  //         },
                  //         child: Icon(
                  //           Icons.camera_alt_outlined,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ))
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
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
            Padding(
              padding: EdgeInsets.only(left: 45),
              child: Row(
                children: [
                  Text("  Role       ", style: TextStyle(fontSize: 18)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 235, 238, 239),
                    ),
                    height: 35,
                    width: 120,
                    child: Center(
                      child: DropdownButton(
                          underline: Container(),
                          dropdownColor: Color.fromARGB(255, 235, 238, 239),
                          iconDisabledColor: Colors.black,
                          iconEnabledColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          value: selectedRole,
                          items: rlist
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(fontSize: 17),
                                  )))
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
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: Center(
                      child: Text("Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )))),
              onTap: () async {
                await APIHandler().updateAccount(
                  name.text,
                  email.text,
                  phone.text,
                  selectedRole,
                  userInfo[0]['user']['id'],
                  password.text,
                );

                Response res =
                    await APIHandler().searchById(userInfo[0]['user']['id']);
                userInfo = jsonDecode(res.body);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Row(
                          children: [
                            Text(
                              'Profile update successfully ',
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
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
