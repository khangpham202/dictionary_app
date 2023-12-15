import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
import 'package:training/util/api_service.dart';
// import 'package:training/components/language_selector.dart';
// import 'package:training/core/enum/country.dart';
// import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';
// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:training/util/database_service.dart';
import 'package:training/util/speech.dart';

class DropdownMenuApp extends StatefulWidget {
  const DropdownMenuApp({super.key});

  @override
  State<DropdownMenuApp> createState() => _DropdownMenuAppState();
}

class _DropdownMenuAppState extends State<DropdownMenuApp> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    List<Map<String, dynamic>> result = await databaseHelper.getData();

    print(result);
    setState(() {
      _data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Example'),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_data[index]['word']),
          );
        },
      ),
    );
  }
}
