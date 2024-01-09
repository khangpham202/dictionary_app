import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:training/components/toast.dart';
import 'package:training/core/router/route_constants.dart';
import 'package:training/modules/wordDetail/view/word_detail_screen.dart';
import 'package:training/util/speech.dart';

class SavedWordScreen extends StatefulWidget {
  const SavedWordScreen({Key? key}) : super(key: key);

  @override
  State<SavedWordScreen> createState() => _SavedWordScreenState();
}

class _SavedWordScreenState extends State<SavedWordScreen> {
  var favoriteList = [];
  late FToast fToast;
  void getFavoriteList(String uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('saved-word')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          favoriteList = querySnapshot.docs
              .map((doc) => {
                    'word': doc['word'],
                    'pronunciation': doc['pronunciation'],
                    'meaning': doc['meaning'],
                  })
              .toList();
        });
      } else {
        setState(() {
          favoriteList = [];
        });
      }
    }).catchError((error) {
      print('Error getting saved word list: $error');
    });
  }

  void removeSavedWord(String word) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference favoriteRef = FirebaseFirestore.instance
        .collection('users')
        .doc('$uid/saved-word/$word');
    favoriteRef.delete().then((_) {
      setState(() {
        getFavoriteList(uid);
      });
    }).catchError((error) {
      print('Error removing saved word: $error');
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
    fToast = FToast();
    fToast.init(context);
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
                          context.pushNamed(RouterConstants.wordDetail,
                              extra: WordDetailScreen(
                                word: favoriteList[index]['word'],
                                dictionaryType: 'EV',
                              ));
                        },
                        backgroundColor:
                            const Color.fromARGB(255, 184, 167, 167),
                        foregroundColor: Colors.green,
                        icon: Icons.details,
                        label: 'Detail',
                      ),
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
                                      removeSavedWord(
                                          favoriteList[index]['word']);
                                      Navigator.of(context).pop();
                                      fToast.showToast(
                                        child: const CustomToast(
                                          msg: 'Removed from favorites',
                                          icon: Icon(FontAwesomeIcons.check),
                                          bgColor:
                                              Color.fromARGB(255, 97, 93, 93),
                                        ),
                                        toastDuration:
                                            const Duration(seconds: 3),
                                      );
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
                        Text(
                          '${index + 1}. ${favoriteList[index]['word']}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Gap(5),
                        favoriteList[index]['pronunciation'] != ''
                            ? Text(
                                '/${favoriteList[index]['pronunciation']}/',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 111, 104, 104),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              )
                            : const Gap(1),
                        const Gap(5),
                        GestureDetector(
                          onTap: () {
                            TextToSpeechService().playTts(
                                'en', favoriteList[index]['pronunciation']);
                          },
                          child: const Icon(
                            Icons.volume_up_outlined,
                            color: Color.fromRGBO(99, 115, 156, 0.914),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Icons.arrow_right_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 300,
                          child: Text(
                            '${favoriteList[index]['meaning']}',
                            overflow: TextOverflow.visible,
                            style: const TextStyle(fontSize: 18),
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
