import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training/modules/auth/view/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
