import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:training/components/blur_image_container.dart';
import 'package:training/modules/home/view/conversation_screen.dart';
import 'package:training/modules/home/view/essential_word_screen.dart';
import 'package:training/modules/home/view/tip_screen.dart';
import 'package:training/modules/wordDetail/view/word_detail_screen.dart';
import 'package:training/util/data_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Color selectedItemColor;
  late String dictionaryType;
  List<String> suggestions = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItemColor = Color.fromARGB(255, 19, 21, 123);
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        WordSuggestion().getEnglishWord().then((suggestionsList) {
          setState(() {
            suggestions = suggestionsList;
          });
        });
      }
    });
    dictionaryType = "EV";
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
                        if (dictionaryType == "EV") {
                          Navigator.of(context).pop();
                          return;
                        } else {
                          setState(() {
                            dictionaryType = "EV";
                            selectedItemColor =
                                Color.fromARGB(255, 19, 21, 123);
                          });
                        }
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
                                dictionaryType,
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
                        if (dictionaryType == "VE") {
                          Navigator.of(context).pop();
                          return;
                        } else {
                          setState(() {
                            dictionaryType = "VE";
                            selectedItemColor =
                                Color.fromARGB(255, 182, 11, 11);
                          });
                        }
                        Navigator.of(context).pop();
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
                    width: 340,
                    height: 35,
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: searchController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search any words',
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await WordSuggestion()
                            .getEnglishWord()
                            .then((List<String> suggestions) {
                          return suggestions
                              .where((suggestion) =>
                                  suggestion.startsWith(pattern))
                              .toList();
                        });
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WordDetailScreen(word: suggestion)),
                        );
                      },
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
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
                            dictionaryType,
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
              child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                BlurredImageContainer(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EssentialWordScreen()),
                    );
                  },
                  imagePath: 'assets/image/homescreen/vocab.jpg',
                  text: 'Essential Word',
                ),
                Gap(20),
                BlurredImageContainer(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConversationScreen()),
                    );
                  },
                  imagePath: 'assets/image/homescreen/conversation.jpg',
                  text: 'Conversation',
                ),
                Gap(20),
                BlurredImageContainer(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TipLeaningScreen()),
                    );
                  },
                  imagePath: 'assets/image/homescreen/motivation.png',
                  text: 'Leaning Tips and Motivation',
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
