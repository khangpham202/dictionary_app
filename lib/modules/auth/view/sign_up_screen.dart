import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training/modules/auth/view/login_screen.dart';
import 'package:training/widget/navigation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late Color myColor;
  late Size mediaSize;
  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
              "assets/image/intro/onboarding-screen-image1.jpg"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.7), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 70, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.g_translate,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "Khationary",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        Text(
          "If you don't have account, sign up below",
          style: TextStyle(color: Colors.grey),
        ),
        SignUpForm(),
        SignUpScreenFooter()
      ],
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final nameController = TextEditingController(text: '');

  final emailController = TextEditingController(text: '');

  final passwordController = TextEditingController(text: '');

  late bool _passwordInVisible;
  @override
  void initState() {
    super.initState();
    _passwordInVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter your name',
            ),
            controller: nameController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter your email address',
            ),
            controller: emailController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordInVisible = !_passwordInVisible;
                  });
                },
                icon: Icon(
                  _passwordInVisible ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            controller: passwordController,
            obscureText: _passwordInVisible,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordInVisible = !_passwordInVisible;
                  });
                },
                icon: Icon(
                  _passwordInVisible ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            controller: passwordController,
            obscureText: _passwordInVisible,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF272727),
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Text("SIGN-UP"),
            )),
      ],
    ));
  }
}

class SignUpScreenFooter extends StatelessWidget {
  const SignUpScreenFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Text(
        "OR",
        style: TextStyle(color: Color.fromARGB(255, 15, 15, 15)),
      ),
      const Gap(
        10,
      ),
      SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
            icon: const Image(
              image: AssetImage("assets/image/logo/google.png"),
              width: 20,
            ),
            onPressed: () {},
            label: const Text("Sign-Up with Google"),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF272727)),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)))),
      ),
      const Gap(
        10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an account? ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          const Icon(Icons.arrow_right_alt),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: const Text("Login"))
        ],
      ),
      Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NavigationBottomBar(
                    indexScreen: 0,
                  ),
                ),
              );
            },
            child: Text(
              'SKIP',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 11, 5, 5),
              ),
            )),
      )
    ]);
  }
}
