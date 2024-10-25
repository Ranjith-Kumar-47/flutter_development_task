import 'package:flutter/material.dart';

import '../model/media_query.dar.dart';

class FullScreen extends StatelessWidget {
  final String imagePath;

  FullScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context); // Initialize once

    return Scaffold(
      appBar: AppBar(title: const Text('Fullscreen')),
      body: SafeArea(
        child: Hero(
          tag: 'hero-image',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: ScreenSizeConfig.screenWidth,
              height: ScreenSizeConfig.screenHeight,
            ),
          ),
        ),
      ),
    );
  }
}
