// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:training/modules/auth/view/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // bool isBookmarked = false;
  // GestureDetector(
  //   onTap: () {
  //     setState(() {
  //       isBookmarked = !isBookmarked;
  //     });
  //   },
  //   child: Icon(
  //     isBookmarked
  //         ? FontAwesomeIcons.solidBookmark
  //         : FontAwesomeIcons.bookmark,
  //     color: isBookmarked ? Color.fromRGBO(18, 55, 149, 0.914) : null,
  //   ),
  // ),
  FirebaseAuth auth = FirebaseAuth.instance;
  late String? name, email, password;
  late bool isLogin;
  @override
  void initState() {
    super.initState();
    isLogin = false; // Initialize isLogin to false
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          isLogin = true;
        });
        getData(user.uid);
      } else {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  void getData(String userId) {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    docRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        if (mounted) {
          setState(() {
            email = data?['email'];
            name = data?['name'];
            password = data?['password'];
          });
        }
      } else {
        return;
      }
    });
  }

  Future signOut() async {
    await auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogin
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/image/profile/profile_image.png',
                          fit: BoxFit.cover,
                          width: 74,
                          height: 74,
                        ),
                        const Gap(10),
                        Text(
                          'Xin chào! \n$name',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  const Gap(10),
                  const ProfileComponent(
                      icon: FontAwesomeIcons.userLarge,
                      text: 'Account Information'),
                  const ProfileComponent(
                      icon: FontAwesomeIcons.solidBookmark,
                      text: 'Saved words'),
                  const ProfileComponent(
                      icon: FontAwesomeIcons.gear, text: 'Setting'),
                  const ProfileComponent(
                      icon: FontAwesomeIcons.shield, text: 'About us'),
                  const ProfileComponent(
                      icon: FontAwesomeIcons.bookOpen,
                      text: 'Policy and Securirt'),
                  const ProfileComponent(
                      icon: FontAwesomeIcons.rightFromBracket, text: 'Logout'),
                ],
              ),
            )
          : Container(
              color: Colors.blueGrey.shade300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.amber.shade600,
                      size: 100,
                    ),
                    Text(
                      'You are not logged in',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 30,
                      ),
                    ),
                    Gap(10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(219, 39, 39, 221),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.login,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Login',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ProfileComponent extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileComponent({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(1, 5),
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 22,
                    ),
                    const Gap(10),
                    Text(
                      text,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  size: 35,
                )
              ],
            ),
          ),
        ),
        const Gap(15)
      ],
    );
  }
}
