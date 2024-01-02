import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:training/core/common/model/essentialword.dart';
import 'package:training/core/common/model/word.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:training/util/api_service.dart';
import 'package:training/util/data_service.dart';
// import 'package:training/components/language_selector.dart';
// import 'package:training/core/enum/country.dart';
// import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';
// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:training/util/speech.dart';
import 'dart:math';

class DropdownMenuApp extends StatefulWidget {
  const DropdownMenuApp({super.key});

  @override
  State<DropdownMenuApp> createState() => _DropdownMenuAppState();
}

class _DropdownMenuAppState extends State<DropdownMenuApp> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Toast"),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              ElevatedButton(
                child: Text("Display Custom Toast"),
                onPressed: () {
                  showCustomToast();
                },
              ),
            ],
          ),
        ));
  }

  showCustomToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 3),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Color borderColor;
  final String title;

  const CustomContainer({
    super.key,
    required this.borderColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.green,
        ),
        height: 70,
        width: 350,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
