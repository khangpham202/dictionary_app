import 'package:flutter/material.dart';
import 'package:training/widget/navigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NavigationBottomBar(
                  indexScreen: 1,
                ),
              ),
            );
          },
          child: Text('Translate')),
    );
  }
}
