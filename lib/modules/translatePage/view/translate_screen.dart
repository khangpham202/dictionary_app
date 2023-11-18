import 'package:flutter/material.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  String text1 = 'Vietnamese';
  String text2 = 'English';

  void swapLanguage() {
    setState(() {
      String temp = text1;
      text1 = text2;
      text2 = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(219, 39, 39, 221),
            height: MediaQuery.of(context).size.height / 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(text1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                GestureDetector(
                  onTap: swapLanguage,
                  child: Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  text2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Center Container',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Type text or phase',
              border: OutlineInputBorder(),
              suffixIcon: GestureDetector(
                onTap: () {
                  // Perform action when the button inside the TextFormField is pressed
                },
                child: Icon(
                  Icons.send,
                  color: Color.fromARGB(219, 39, 39, 221),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
