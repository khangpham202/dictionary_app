import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';

import '../../core/common/theme/theme.export.dart';

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slidable Example',
      home: Scaffold(
        body: ListView(
          children: [
            Slidable(
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
                    backgroundColor: const Color.fromARGB(255, 219, 219, 219),
                    foregroundColor: AppColors.kRed,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                title: Row(
                  children: [
                    const Text('1. Slide me'),
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
            ),
          ],
        ),
      ),
    );
  }
}

