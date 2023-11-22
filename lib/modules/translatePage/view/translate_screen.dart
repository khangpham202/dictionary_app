import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(18, 55, 149, 0.914),
              height: MediaQuery.of(context).size.height / 12,
              child: Center(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(text1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                      Text(text2,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  GestureDetector(
                    onTap: swapLanguage,
                    child: Icon(
                      Icons.sync,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              )),
            ),
            Expanded(
              child: Column(children: [
                Gap(30),
                Text(
                  'Vietnamese to English',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/image/logo/vn_logo.png',
                        width: 25,
                        height: 25,
                      ),
                      Gap(10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text('Làm ơn',
                            style: TextStyle(
                              color: Color.fromRGBO(18, 55, 149, 0.914),
                              fontSize: 16,
                            )),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: null,
                        child: Icon(
                          Icons.volume_up_outlined,
                          color: Colors.grey.shade400,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/image/logo/uk_logo.png',
                        // fit: BoxFit.cover,
                        width: 25,
                        height: 25,
                      ),
                      Gap(10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(18, 55, 149, 0.914),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text('Please',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            )),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: null,
                        child: Icon(
                          Icons.volume_up_outlined,
                          color: Colors.grey.shade400,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Type text or phase',
                border: OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: () {
                    print(text1);
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
      ),
    );
  }
}
