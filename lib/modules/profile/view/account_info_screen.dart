import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:training/components/toast.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final List<String> _gender = ['Male', 'Female', 'Other'];
  String _selectedGender = '', emailValue = '';
  late FToast fToast;
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  late bool _passwordInVisible = true;
  final user = FirebaseAuth.instance.currentUser;

  void getData(String userId) {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    docRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        if (mounted) {
          setState(() {
            nameController.text = data?['name'];
            emailValue = data?['email'];
            passwordController.text = data?['password'];
            if (data != null && data.containsKey('gender')) {
              _selectedGender = data['gender'];
            } else {
              _selectedGender = '';
            }
            if (data != null && data.containsKey('phoneNumber')) {
              phoneNumberController.text = data['phoneNumber'];
            } else {
              phoneNumberController.text = '';
            }
          });
        }
      } else {
        return;
      }
    });
  }

  bool isPhoneNoValid(String? phoneNo) {
    if (phoneNo == null) return false;
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
    return regExp.hasMatch(phoneNo);
  }

  Future changeUserInfo(BuildContext context, String fullName, newPassword,
      gender, phoneNumber) async {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(user!.uid);
    DocumentSnapshot userSnapshot = await userRef.get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    userData['name'] = fullName;
    userData['password'] = newPassword;
    userData['gender'] = gender;
    userData['phoneNumber'] = phoneNumber;
    await userRef.set(userData);
    await user!.updatePassword(newPassword);
  }

  @override
  void initState() {
    super.initState();
    getData(user!.uid);
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Account Information'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                            'assets/image/profile/profile_image.png'),
                      ),
                      Positioned(
                          bottom: -15,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: const Color(0xFFF5F6F9),
                            padding: const EdgeInsets.all(5),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const Gap(15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(fontSize: 18),
                ),
                controller: nameController,
              ),
              const Gap(10),
              TextFormField(
                enabled: false,
                controller: TextEditingController(text: emailValue),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 18),
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  const Text(
                    'Gender: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Gap(10),
                  DropdownButton<String>(
                      items: _gender.map((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      hint: Text(_selectedGender),
                      onChanged: (newVal) {
                        setState(() {
                          _selectedGender = newVal!;
                        });
                      })
                ],
              ),
              const Gap(10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 18),
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
                obscureText: _passwordInVisible,
                controller: passwordController,
              ),
              const Gap(10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  labelStyle: TextStyle(fontSize: 18),
                ),
                controller: phoneNumberController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (phoneNumber) =>
                    phoneNumber != null && !isPhoneNoValid(phoneNumber)
                        ? 'Enter a valid phone number'
                        : null,
              ),
              const Gap(30),
              Builder(builder: (context) {
                return SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        changeUserInfo(
                            context,
                            nameController.text,
                            passwordController.text,
                            _selectedGender,
                            phoneNumberController.text);
                        fToast.showToast(
                          gravity: ToastGravity.CENTER,
                          child: const CustomToast(
                            msg: 'Save changes successfully!!',
                            icon: Icon(FontAwesomeIcons.check),
                            bgColor: Colors.green,
                          ),
                          toastDuration: const Duration(seconds: 3),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              const Color.fromARGB(255, 84, 205, 88),
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 20),
                      ),
                    ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
