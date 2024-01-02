// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:training/modules/auth/view/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  String _username = 'Khang';

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  Gap(10),
                  Text(
                    'Xin chào! \n$_username',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Gap(10),
            ProfileComponent(
                icon: FontAwesomeIcons.userLarge, text: 'Account Information'),
            ProfileComponent(
                icon: FontAwesomeIcons.solidBookmark, text: 'Saved words'),
            ProfileComponent(icon: FontAwesomeIcons.gear, text: 'Setting'),
            ProfileComponent(icon: FontAwesomeIcons.shield, text: 'About us'),
            ProfileComponent(
                icon: FontAwesomeIcons.bookOpen, text: 'Policy and Securirt'),
            ProfileComponent(
                icon: FontAwesomeIcons.rightFromBracket, text: 'Logout'),
          ],
        ),
      ),
      // Container(
      //   color: Colors.blueGrey.shade300,
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Icon(
      //           Icons.warning,
      //           color: Colors.amber.shade600,
      //           size: 100,
      //         ),
      //         Text(
      //           'You are not logged in',
      //           style: TextStyle(
      //             color: Colors.grey.shade800,
      //             fontSize: 30,
      //           ),
      //         ),
      //         Gap(10),
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.of(context).push(
      //               MaterialPageRoute(
      //                 builder: (context) => LoginScreen(),
      //               ),
      //             );
      //           },
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Color.fromARGB(219, 39, 39, 221),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(20),
      //             ),
      //           ),
      //           child: Padding(
      //             padding: const EdgeInsets.all(8),
      //             child: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: const [
      //                 Icon(
      //                   Icons.login,
      //                   size: 24,
      //                 ),
      //                 SizedBox(width: 8),
      //                 Text(
      //                   'Login',
      //                   style: TextStyle(fontSize: 25),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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
        Gap(15)
      ],
    );
  }
}
