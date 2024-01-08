import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';

class SavedWordScreen extends StatefulWidget {
  const SavedWordScreen({Key? key}) : super(key: key);

  @override
  State<SavedWordScreen> createState() => _SavedWordScreenState();
}

class _SavedWordScreenState extends State<SavedWordScreen> {
  var favoriteList = [];

  void getFavoriteList(String uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite-word')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          favoriteList = querySnapshot.docs.map((doc) => doc['word']).toList();
        });
      } else {
        setState(() {
          favoriteList = [];
        });
      }
    }).catchError((error) {
      print('Error getting favorites: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        getFavoriteList(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved words'),
        centerTitle: true,
      ),
      body: favoriteList.isEmpty
          ? const Center(
              child: Text('No saved word'),
            )
          : ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'Are you sure to delete this saved word?'),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Approve'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        backgroundColor:
                            const Color.fromARGB(255, 219, 219, 219),
                        foregroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text('${index + 1}. ${favoriteList[index]}'),
                        const Gap(5),
                        GestureDetector(
                          onTap: () {
                            // TextToSpeechService().playTts('en', widget.word);
                          },
                          child: const Icon(
                            Icons.volume_up_outlined,
                            color: Color.fromRGBO(99, 115, 156, 0.914),
                          ),
                        ),
                      ],
                    ),
                    subtitle: const Row(
                      children: [
                        Icon(
                          Icons.arrow_right_outlined,
                        ),
                        SizedBox(
                          width: 300,
                          child: Text(
                            'data.description',
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
