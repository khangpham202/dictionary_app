import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredImageContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String text;

  const BlurredImageContainer({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(imagePath, fit: BoxFit.cover),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color:
                        const Color.fromARGB(255, 98, 88, 204).withOpacity(0.1),
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 248, 248, 248),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.7),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
