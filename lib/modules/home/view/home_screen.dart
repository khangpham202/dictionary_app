import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:training/components/blur_image_container.dart';
import 'package:training/core/router/route_constants.dart';
import 'package:training/modules/wordDetail/view/word_detail_screen.dart';
import 'package:training/util/data_service.dart';
import 'package:video_player/video_player.dart';

import '../../../core/common/theme/theme.export.dart';

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
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    selectedItemColor = const Color.fromARGB(255, 19, 21, 123);
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        WordSuggestion().getEnglishWordSuggestion().then((suggestionsList) {
          setState(() {
            suggestions = suggestionsList;
          });
        });
      }
    });
    dictionaryType = "EV";
    _controller = VideoPlayerController.asset('assets/video/matgoc.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    void showDictionaryFlowOption() {
      showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 300),
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
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          "Dictionary Flow",
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
                                const Color.fromARGB(255, 19, 21, 123);
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 19, 21, 123),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Text(
                                'EV',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          const Gap(10),
                          const Text('English - Vietnamese')
                        ],
                      ),
                    ),
                    const Divider(color: Color.fromARGB(255, 118, 114, 114)),
                    GestureDetector(
                      onTap: () {
                        if (dictionaryType == "VE") {
                          Navigator.of(context).pop();
                          return;
                        } else {
                          setState(() {
                            dictionaryType = "VE";
                            selectedItemColor =
                                const Color.fromARGB(255, 182, 11, 11);
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 182, 11, 11),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Text(
                                'VE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          const Gap(10),
                          const Text('Vietnamese - English')
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            color: AppColors.kPrimary,
            height: MediaQuery.of(context).size.height / 11,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  dictionaryType == "EV"
                      ? SizedBox(
                          width: 340,
                          height: 35,
                          child: TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: searchController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search any words',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
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
                                    dictionaryType: dictionaryType,
                                  ));
                            },
                            suggestionsBoxDecoration:
                                const SuggestionsBoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 340,
                          height: 35,
                          child: TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: searchController,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search any words',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return await WordSuggestion()
                                  .getVietnameseWordSuggestion()
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
                                    dictionaryType: dictionaryType,
                                  ));
                            },
                            suggestionsBoxDecoration:
                                const SuggestionsBoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                        ),
                  const Gap(5),
                  SizedBox(
                    child: GestureDetector(
                      onTap: showDictionaryFlowOption,
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedItemColor,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dictionaryType,
                            style: const TextStyle(
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
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                BlurredImageContainer(
                  onTap: () => context.go('/home/essentialWord'),
                  imagePath: 'assets/image/homescreen/vocab.jpg',
                  text: 'Essential Word',
                ),
                const Gap(20),
                BlurredImageContainer(
                  onTap: () => context.go('/home/conversation'),
                  imagePath: 'assets/image/homescreen/conversation.jpg',
                  text: 'Conversation',
                ),
                const Gap(20),
                BlurredImageContainer(
                  onTap: () => context.go('/home/tipLearning'),
                  imagePath: 'assets/image/homescreen/motivation.png',
                  text: 'Leaning Tips',
                ),
                const Gap(10),
                _controller.value.isInitialized
                    ? Column(
                        children: [
                          const Center(
                            child: Text(
                              "Mất Gốc Tiếng Anh, video này dành cho bạn",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                              Positioned.fill(
                                bottom: 0,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AnimatedBuilder(
                                    animation: _controller,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              _controller.value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                            ),
                                            color: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                if (_controller
                                                    .value.isPlaying) {
                                                  _controller.pause();
                                                } else {
                                                  _controller.play();
                                                }
                                              });
                                            },
                                          ),
                                          Text(
                                            formatDuration(
                                                _controller.value.position),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Expanded(
                                            child: VideoProgressIndicator(
                                              _controller,
                                              allowScrubbing: true,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                            ),
                                          ),
                                          Text(
                                            formatDuration(
                                                _controller.value.duration),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
