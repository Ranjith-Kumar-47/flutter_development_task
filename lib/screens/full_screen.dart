import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../model/media_query.dar.dart';

class FullScreen extends StatelessWidget {
  final List<String> imagePaths; // Accepts multiple images

  FullScreen({required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fullscreen')),
      body: SafeArea(
        child: CarouselSlider.builder(
          itemCount: imagePaths.length,
          options: CarouselOptions(
            height: ScreenSizeConfig.screenHeight,
            viewportFraction: 1.0, // Makes each image take up the full screen width
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            autoPlay: false,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Hero(
              tag: 'hero-image-$index',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                  width: ScreenSizeConfig.screenWidth,
                  height: ScreenSizeConfig.screenHeight,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
