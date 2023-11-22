import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color selectedItemColor = Color.fromARGB(255, 19, 21, 123);
  String language = "en";
  void changeColor() {
    setState(() {
      selectedItemColor = Colors.yellow;
    });
  }

  @override
  Widget build(BuildContext context) {
    void scaleDialog() {
      showGeneralDialog(
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (ctx, a1, a2, child) {
          var curve = Curves.easeInOut.transform(a1.value);
          return Transform.scale(
              scale: curve,
              child: AlertDialog(
                title: Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          "Dictionaries",
                          style: TextStyle(
                            color: Color.fromARGB(255, 44, 46, 153),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 19, 21, 123),
                              ),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'EV',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Gap(10),
                          Text('English - Vietnamese')
                        ],
                      ),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        changeColor();
                      },
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 182, 11, 11),
                              ),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'VE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Gap(10),
                          Text('Vietnamese - English')
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
        transitionDuration: const Duration(milliseconds: 300),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            color: Color.fromRGBO(18, 55, 149, 0.914),
            height: MediaQuery.of(context).size.height / 11,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  SizedBox(
                    width: 450,
                    height: 35,
                    child: TextField(
                        decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search any words',
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(),
                    )),
                  ),
                  Gap(5),
                  SizedBox(
                    child: GestureDetector(
                      onTap: scaleDialog,
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedItemColor,
                          ),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'EV',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.red,
          ))
        ]),
      ),
    );
  }
}
