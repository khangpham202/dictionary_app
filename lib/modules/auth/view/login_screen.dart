import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:training/components/toast.dart';
import 'package:training/modules/auth/bloc/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

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
          "Please login with your account",
          style: TextStyle(color: Colors.grey),
        ),
        const LoginForm(),
        const Gap(
          10,
        ),
        const LoginScreenFooter()
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
              controller: emailController,
              style: const TextStyle(
                color: Colors.black,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: const Text("Forgot Password?")),
            ),
          ),
          BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: ((context, state) {
              if (state is AuthenticationSuccessState) {
                fToast.showToast(
                  gravity: ToastGravity.CENTER,
                  child: CustomToast(
                    msg: state.message,
                    icon: const Icon(FontAwesomeIcons.check),
                    bgColor: Colors.green,
                  ),
                  toastDuration: const Duration(seconds: 3),
                );
                context.go('/home');
              } else if (state is AuthenticationFailureState) {
                fToast.showToast(
                  gravity: ToastGravity.CENTER,
                  child: CustomToast(
                    msg: state.errorMessage,
                    icon: const Icon(FontAwesomeIcons.exclamation),
                    bgColor: Colors.red,
                  ),
                  toastDuration: const Duration(seconds: 3),
                );
              }
            }),
            builder: ((context, state) {
              return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        Login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF272727),
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: const Text("LOGIN"),
                  ));
            }),
          )
        ],
      ),
    );
  }

  // Future signIn() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );

  //     if (!context.mounted) return;

  //     context.go('/home');
  //   } on FirebaseAuthException catch (e) {
  //     if (emailController.text.trim() == '' ||
  //         passwordController.text.trim() == '') {
  //       fToast.showToast(
  //         gravity: ToastGravity.CENTER,
  //         child: Container(
  //           constraints: const BoxConstraints(maxWidth: 250),
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(25.0),
  //             color: Colors.red,
  //           ),
  //           child: const Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Icon(FontAwesomeIcons.exclamation),
  //               SizedBox(
  //                 width: 12.0,
  //               ),
  //               Flexible(
  //                 child: Text(
  //                   'Field cannot be empty!!',
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 1,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         toastDuration: const Duration(seconds: 3),
  //       );
  //     } else {
  //       fToast.showToast(
  //         gravity: ToastGravity.CENTER,
  //         child: Container(
  //           constraints: const BoxConstraints(maxWidth: 250),
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(25.0),
  //             color: Colors.red,
  //           ),
  //           child: SizedBox(
  //             width: double.infinity,
  //             child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 const Icon(FontAwesomeIcons.exclamation),
  //                 const SizedBox(
  //                   width: 12.0,
  //                 ),
  //                 Flexible(
  //                   child: Text(
  //                     e.message!,
  //                     overflow: TextOverflow.visible,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         toastDuration: const Duration(seconds: 3),
  //       );
  //     }
  //   }
  // }
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
          const Text("Don't have an account?",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          const Icon(Icons.arrow_right_alt),
          TextButton(
              onPressed: () => context.go('/signUp'),
              child: const Text("Sign-up"))
        ],
      ),
      Center(
        child: TextButton(
            onPressed: () => context.go('/home'),
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
