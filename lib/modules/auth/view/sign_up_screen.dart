import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:training/components/toast.dart';
import 'package:training/modules/auth/bloc/authentication_bloc.dart';

import '../../../core/common/theme/theme.export.dart';

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
              color: Colors.black,
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
        BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: ((context, state) {
            if (state is AuthenticationSuccessState) {
              fToast.showToast(
                gravity: ToastGravity.BOTTOM,
                child: CustomToast(
                  msg: state.message,
                  icon: const Icon(FontAwesomeIcons.check),
                  bgColor: AppColors.kGreen,
                ),
                toastDuration: const Duration(seconds: 3),
              );
              FocusManager.instance.primaryFocus?.unfocus();
            } else if (state is AuthenticationFailureState) {
              fToast.showToast(
                gravity: ToastGravity.CENTER,
                child: CustomToast(
                  msg: state.errorMessage,
                  icon: const Icon(FontAwesomeIcons.exclamation),
                  bgColor: AppColors.kRed,
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
                      SignUp(
                        nameController.text.trim(),
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
                  child: const Text("SIGN-UP"),
                ));
          }),
        )
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
              onPressed: () => context.go('/signIn'),
              child: const Text("Login"))
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
