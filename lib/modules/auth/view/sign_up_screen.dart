// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training/modules/auth/view/login_screen.dart';
import 'package:training/widget/navigation.dart';
// import 'package:firebase_database/firebase_database.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  'Create \nyour account',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SignUpForm(),
                const SignUpScreenFooter()
              ],
            ),
          ),
        ),
      ),
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
          const Text("Already have account? ",
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

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final fullName = TextEditingController(text: '');

  final emailController = TextEditingController(text: '');

  final passwordController = TextEditingController(text: '');

  // final ref = FirebaseDatabase.instance.ref().child("Users");
  late bool _passwordInVisible;
  @override
  void initState() {
    super.initState();
    _passwordInVisible = true;
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextFormField(
          //   style: const TextStyle(
          //     color: Colors.black, // set the color of the text
          //   ),
          //   controller: fullName,
          //   decoration: const InputDecoration(
          //       prefixIcon: Icon(Icons.person_outline_outlined),
          //       labelText: "FullName",
          //       hintText: "FullName",
          //       border: OutlineInputBorder()),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // TextFormField(
          //   style: const TextStyle(
          //     color: Colors.black, // set the color of the text
          //   ),
          //   controller: emailController,
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
          //   style: const TextStyle(
          //     color: Colors.black, // set the color of the text
          //   ),
          //   controller: passwordController,
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
          // obscureText: _passwordInVisible,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your email address',
              ),
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
                    _passwordInVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
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
      ),
    ));
  }

  // Future signUp() async {
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  //     final Map<String, dynamic> userData = {
  //       'name': fullName.text.trim(),
  //       'email': emailController.text.trim(),
  //     };

  //     scaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(
  //         content: Text("Sign-up successfully"),
  //         backgroundColor: Colors.green));
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     await firestore
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .set(userData);
  //   } on FirebaseAuthException catch (e) {
  //     scaffoldMessengerKey.currentState?.showSnackBar(
  //         SnackBar(content: Text("${e.message}"), backgroundColor: Colors.red));
  //   }
  // }
}
