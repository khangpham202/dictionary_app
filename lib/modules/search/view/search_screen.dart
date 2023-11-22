import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        onTap: () {
                          print(123);
                          Scaffold.of(context).openDrawer();
                        },
                        child: Container(
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Sidebar Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Handle item 1 tap
                },
              ),

              // Add more list items as needed
            ],
          ),
        ));
  }
}
