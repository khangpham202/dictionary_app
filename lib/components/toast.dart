import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomToast extends StatelessWidget {
  final String msg;
  final Icon icon;
  final Color bgColor;

  const CustomToast({
    super.key,
    required this.msg,
    required this.icon,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: bgColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FontAwesomeIcons.exclamation),
          const SizedBox(
            width: 12.0,
          ),
          Flexible(
            child: Text(
              msg,
              overflow: TextOverflow.visible,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
