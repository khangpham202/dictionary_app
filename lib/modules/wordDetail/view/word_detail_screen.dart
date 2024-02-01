import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:training/components/tarbar_view.dart';
import 'package:training/core/router/route_constants.dart';
import 'package:training/util/data_service.dart';

import '../../../core/common/theme/theme.export.dart';

class WordDetailScreen extends StatefulWidget {
  final String word;
  final String dictionaryType;
  const WordDetailScreen(
      {super.key, required this.word, required this.dictionaryType});
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
    _tabController = TabController(length: 2, vsync: this);
    searchController.text = widget.word;
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
            color: AppColors.kPrimary,
            height: MediaQuery.of(context).size.height / 11,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_sharp),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                  SizedBox(
                    width: 320,
                    height: 35,
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: searchController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await WordSuggestion()
                            .getEnglishWordSuggestion()
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
                        context.pushNamed(RouterConstants.wordDetail,
                            extra: WordDetailScreen(
                              word: suggestion,
                              dictionaryType: widget.dictionaryType,
                            ));
                      },
                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  const Gap(5),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.kPrimary,
              labelColor: AppColors.kPrimary,
              unselectedLabelColor: Colors.grey.shade400,
              isScrollable: true,
              tabs: [
                SizedBox(
                  width: 140,
                  child: Tab(
                    child: Text(
                      widget.dictionaryType == "EV"
                          ? 'English - Vietnamese'
                          : 'Vietnamese - English',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    widget.dictionaryType == "EV" ? 'WordNet' : '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                WordMeaningWidget(
                  word: widget.word,
                  dictionaryType: widget.dictionaryType,
                ),
                WordNetWidget(word: widget.word),
              ],
            ),
          )
        ],
      )),
    );
  }
}
