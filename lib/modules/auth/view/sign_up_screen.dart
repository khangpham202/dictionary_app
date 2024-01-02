import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:training/modules/auth/view/login_screen.dart';
import 'package:training/components/navigation.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            )),
        child: Padding(
          padding: const EdgeInsets.all(25),
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
        const Text(
          "If you don't have account, sign-up below",
          style: TextStyle(color: Colors.grey),
        ),
        const SignUpForm(),
        const Gap(
          10,
        ),
        const SignUpScreenFooter()
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
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  late bool _passwordInVisible;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    _passwordInVisible = true;
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: TextFormField(
            controller: nameController,
            style: const TextStyle(
              color: Colors.black, // set the color of the text
            ),
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Enter your name",
                hintText: "Enter your name",
                border: OutlineInputBorder()),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: emailController,
            style: const TextStyle(
              color: Colors.black, // set the color of the text
            ),
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: "Email address",
                hintText: "Enter email address",
                border: OutlineInputBorder()),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: passwordController,
            style: const TextStyle(
              color: Colors.black,
            ),
            obscureText: _passwordInVisible,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                labelText: "Password",
                hintText: "Enter your password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordInVisible = !_passwordInVisible;
                    });
                  },
                  icon: Icon(
                    _passwordInVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                )),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 6
                ? 'Enter min 6 characters'
                : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: confirmPasswordController,
            style: const TextStyle(
              color: Colors.black,
            ),
            obscureText: _passwordInVisible,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                labelText: "Confirm password",
                hintText: "Enter confirm password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordInVisible = !_passwordInVisible;
                    });
                  },
                  icon: Icon(
                    _passwordInVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                )),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != passwordController.text
                ? '2 passwords do not match'
                : null,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: signUp,
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

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: emailController.text.trim(),
      );
      final Map<String, dynamic> userData = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };
      showCustomToast('Sign up successfully',
          const Icon(FontAwesomeIcons.check), Colors.green);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userData);
    } on FirebaseAuthException catch (e) {
      if (emailController.text.trim() == '' &&
          passwordController.text.trim() == '') {
        showCustomToast('Field cannot be empty!!',
            const Icon(FontAwesomeIcons.exclamation), Colors.red);
      } else {
        showCustomToast(
            e.message!, const Icon(FontAwesomeIcons.exclamation), Colors.red);
      }
    }
  }

  showCustomToast(String msg, Icon icon, Color bgColor) {
    Widget toast = Container(
      constraints: const BoxConstraints(maxWidth: 250),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: bgColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(
            width: 12.0,
          ),
          Flexible(
            child: Text(
              msg,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
    );
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
                    builder: (context) => const LoginScreen(),
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
                  builder: (context) => const NavigationBottomBar(
                    indexScreen: 0,
                  ),
                ),
              );
            },
            child: const Text(
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
