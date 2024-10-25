import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart'; // Add this package in pubspec.yaml
import 'package:flutter/material.dart';
import 'package:flutter_development_task/screens/full_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/string_constants.dart';
import '../model/media_query.dar.dart';
// import 'package:share/share.dart'; // Add the share package for sharing functionality

class DescriptionPage extends StatefulWidget {
  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  int _currentIndex = 0;
  bool isScrolling = false;
  double scrollValue = 1000;
  bool moreDetails = false;
  final List<String> imgList = [
    // 'https://images.pexels.com/photos/237272/pexels-photo-237272.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'assets/image_one.jpg',
    'assets/image_two.jpg',
    'assets/image_three.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          StringConstants.descriptionTitle,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                  color: /*isScrolling ? Colors.white : */ Color(0xffD3D3D3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CarouselSlider(
                          carouselController: CarouselSliderController(),
                          options: CarouselOptions(
                            height: ScreenSizeConfig.screenHeight * .35,
                            enableInfiniteScroll: true,
                            animateToClosest: true,
                            enlargeCenterPage: true,
                            pageSnapping: true,
                            reverse: false,
                            scrollPhysics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 4),
                            viewportFraction: 1.0,
                            // onScrolled: (value) {
                            // log('on scrolled $value');
                            //   isScrolling = true;
                            //   setState(() {});
                            // },
                            onPageChanged: (index, reason) {
                              log('index: $index and reason $reason');
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items: imgList
                              .map(
                                (item) => ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Center(
                                    child: Hero(
                                      tag: 'hero-image',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          item,
                                          width: ScreenSizeConfig.screenWidth,
                                          height: ScreenSizeConfig.screenHeight * .35,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        // Page indicator
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imgList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => setState(() {
                                  _currentIndex = entry.key;
                                }),
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // Change background color of active and inactive dots
                                    color: _currentIndex == entry.key
                                        ? Colors.white // Active dot color
                                        : Colors.white.withOpacity(.5), // Inactive dot color
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.file_download_outlined),
                          onPressed: () {
                            // Action for download button
                            log('Download pressed');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border_rounded),
                          onPressed: () {
                            // Action for bookmark button
                            log('Bookmark pressed');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border_rounded),
                          onPressed: () {
                            // Action for favorite button
                            log('Favorite pressed');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.fullscreen, size: 28),
                          onPressed: () {
                            // Action for fullscreen button
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreen(imagePath: 'assets/image_one.jpg'),
                              ),
                            );
                            log('Fullscreen pressed');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.star_border_purple500_sharp),
                          onPressed: () {
                            // Action for star button
                            log('Star pressed');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.share_outlined),
                          onPressed: () {
                            Share.share(
                              'Check out this share option',
                              subject: 'Flutter Development Task',
                            );
                            log('Share pressed');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Like, Comment, Star Rating and Share Button Row
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.bookmark_border_rounded),
                      SizedBox(width: 5),
                      Text('1034'),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Row(
                    children: [
                      Icon(Icons.favorite_border_rounded),
                      SizedBox(width: 5),
                      Text('1034'),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                        child: RatingBar.builder(
                          ignoreGestures: true,
                          itemSize: 16,
                          initialRating: 3.6,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.blue,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '3.2',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Actor details and content
              const Text(
                'Actor Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text('Indian Actress'),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text('Duration 20 Mins'),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text('Total Average Fees ₹9,999'),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'About',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'In the game\'s crucial moments, KD thrives. He takes over on both ends of the court, '
                          'making defenders fear his unstoppable moves. ${moreDetails ? 'He\'s a proven champion with multiple places with more option ' : ''}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          moreDetails = !moreDetails;
                          setState(() {});
                        },
                        child: Text(
                          moreDetails ? "Less" : 'More',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
