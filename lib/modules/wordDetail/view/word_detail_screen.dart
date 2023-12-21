import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:training/components/tarbar_view.dart';
import 'package:training/util/data_service.dart';

class WordDetailScreen extends StatefulWidget {
  final String word;
  const WordDetailScreen({super.key, required this.word});
  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen>
    with TickerProviderStateMixin {
  List<String> suggestions = [];
  TextEditingController searchController = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Color.fromRGBO(18, 55, 149, 0.914),
            height: MediaQuery.of(context).size.height / 11,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_sharp),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                  SizedBox(
                    width: 320,
                    height: 35,
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: searchController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          hintText: widget.word,
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
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
                ],
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Color.fromRGBO(18, 55, 149, 0.914),
            labelColor: Color.fromRGBO(18, 55, 149, 0.914),
            unselectedLabelColor: Colors.grey.shade400,
            isScrollable: true,
            tabs: const [
              SizedBox(
                width: 140,
                child: Tab(
                  child: Text(
                    'English - Vietnamese',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'WordNet',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Note',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                WordMeaningWidget(
                  word: widget.word,
                ),
                WordNetWidget(word: widget.word),
                NoteWidget()
              ],
            ),
          )
        ],
      )),
    );
  }
}
