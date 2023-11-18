import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training/widget/navigation.dart';

import 'sign_up_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:music_app/main.dart';
// import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  'Log into \nyour account',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const LoginScreenFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreenFooter extends StatelessWidget {
  const LoginScreenFooter({
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
            label: const Text("Login with Google"),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                // backgroundColor: const Color(0xFF272727),
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
          const Text("Don't have an Account? ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          const Icon(Icons.arrow_right_alt),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
              child: const Text("Sign-up"))
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

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late bool _passwordInVisible;
  @override
  void initState() {
    super.initState();
    _passwordInVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter email address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter password',
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
                  ),
                ),
                obscureText: _passwordInVisible,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {}, child: const Text("Forgot Password?")),
              ),
            ),
            // TextFormField(
            //   controller: widget.emailController,
            //   style: const TextStyle(
            //     color: Colors.black, // set the color of the text
            //   ),
            //   decoration: const InputDecoration(
            //       prefixIcon: Icon(Icons.email),
            //       labelText: "E-Mail",
            //       hintText: "E-mail",
            //       border: OutlineInputBorder()),
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   // validator: (email) =>
            //   //     email != null && !EmailValidator.validate(email)
            //   //         ? 'Enter a valid email'
            //   //         : null,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // TextFormField(
            //   controller: widget.passwordController,
            //   style: const TextStyle(
            //     color: Colors.black, // set the color of the text
            //   ),
            //   obscureText: _passwordInVisible,
            //   decoration: InputDecoration(
            //       prefixIcon: const Icon(Icons.lock),
            //       labelText: "Password",
            //       hintText: "Password",
            //       border: const OutlineInputBorder(),
            //       suffixIcon: IconButton(
            //         onPressed: () {
            //           setState(() {
            //             _passwordInVisible = !_passwordInVisible;
            //           });
            //         },
            //         icon: Icon(
            //           _passwordInVisible
            //               ? Icons.visibility_off
            //               : Icons.visibility,
            //         ),
            //       )),
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   validator: (value) => value != null && value.length < 6
            //       ? 'Enter.min 6 characters'
            //       : null,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //       onPressed: () {}, child: const Text("Forgot Password?")),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      // backgroundColor: Colors.white,
                      backgroundColor: const Color(0xFF272727),
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text("LOGIN"),
                ))
          ],
        ),
      ),
    );
  }

  // Future signIn() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: widget.emailController.text.trim(),
  //       password: widget.passwordController.text.trim(),
  //     );
  //     navigatorKey.currentState?.pushNamed('/');
  //   } on FirebaseAuthException catch (e) {
  //     scaffoldMessengerKey.currentState?.showSnackBar(
  //         SnackBar(content: Text("${e.message}"), backgroundColor: Colors.red));
  //   }
  // }
}
