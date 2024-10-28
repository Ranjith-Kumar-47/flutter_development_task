import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_development_task/global_fun.dart';
import 'package:flutter_development_task/model/description.dart';
import 'package:flutter_development_task/model/individual_meetup_model.dart';
import 'package:intl/intl.dart';

import '../constants/string_constants.dart';
import '../model/media_query.dar.dart';
import '../model/top_trending_meetup.dart';
import '../model/trending_popular_people.dart';
import 'description_screen.dart';

class MeetupScreen extends StatefulWidget {
  const MeetupScreen({super.key});

  @override
  MeetupScreenState createState() => MeetupScreenState();
}

class MeetupScreenState extends State<MeetupScreen> {
  int _currentIndex = 0;
  int _currentIndex1 = 0;
  late Description description;

  // Initialize CarouselController at the class level
  final CarouselSliderController? _carouselController = CarouselSliderController();
  late final IndividualMeetup individualMeetup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          StringConstants.individualMeetupTitle,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        ToastMessage.showToastMessage(StringConstants.voiceSearch);
                      },
                      icon: const Icon(Icons.keyboard_voice_outlined)),
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: 'Search',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CarouselSlider(
                  carouselController: _carouselController, // Use the controller here
                  options: CarouselOptions(
                    height: ScreenSizeConfig.screenHeight * .25,
                    enableInfiniteScroll: true,
                    animateToClosest: true,
                    enlargeCenterPage: true,
                    pageSnapping: true,
                    reverse: false,
                    scrollPhysics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    viewportFraction: 1.0,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    onPageChanged: (index, reason) {
                      log('index: $index and reason $reason');
                      setState(() {
                        _currentIndex = index;
                        log('current index changed: $_currentIndex');
                      });
                    },
                  ),
                  items: individualMeetup.slideList
                      .map(
                        (item) => ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Center(
                            child: Image.asset(
                              item,
                              width: ScreenSizeConfig.screenWidth,
                              height: ScreenSizeConfig.screenHeight * .25,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: individualMeetup.slideList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = entry.key;
                      });
                      // Use the controller to jump to tapped indicator
                      _carouselController?.animateToPage(entry.key);
                    },
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Text('Trending Popular People', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                height: ScreenSizeConfig.screenHeight * .25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: individualMeetup.trendingPopularPeople.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1, strokeAlign: BorderSide.strokeAlignInside), borderRadius: BorderRadius.circular(10)),
                      width: ScreenSizeConfig.screenWidth * .8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(backgroundImage: AssetImage(individualMeetup.trendingPopularPeople.elementAt(index).memberAvatar)),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    individualMeetup.trendingPopularPeople.elementAt(index).title,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Text('${getFormat(individualMeetup.trendingPopularPeople.elementAt(index).membersCount)} Meetups'),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          SizedBox(
                            height: 50,
                            child: Stack(
                              children: individualMeetup.trendingPopularPeople.elementAt(index).memberListAvatar.asMap().entries.map((entry) {
                                int index = entry.key;
                                String imageUrl = entry.value;
                                return Positioned(
                                  left: index * 40.0, // Adjust spacing as needed
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(imageUrl), // For assets
                                    // Use `NetworkImage(imageUrl)` instead if the images are from the internet
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {
                                ToastMessage.showToastMessage(StringConstants.seeMore);
                              },
                              child: const Text('See More', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text('Top Trending Meetups', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                height: 280,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: individualMeetup.topTrendingMeetup.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed('/description');

                          getDescriptionData(index, context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: ScreenSizeConfig.screenWidth * .6,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      individualMeetup.topTrendingMeetup.elementAt(index).imageUrl,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(individualMeetup.topTrendingMeetup.elementAt(index).title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(individualMeetup.topTrendingMeetup.elementAt(index).subTitle),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFormat(int number) {
    String format = NumberFormat.currency(
      locale: 'en_IN', // Indian Locale
      decimalDigits: 0,
      symbol: '', // No currency symbol
    ).format(number);
    return format;
  }

  void fetchData() {
    List<String> slideListImage = [
      'assets/member_one.jpg',
      'assets/member_two.jpg',
      'assets/member_three.jpg',
    ];
    List<TrendingPopularPeople> trendingPopularPeople = [
      TrendingPopularPeople(
          title: 'Customer',
          membersCount: 124242,
          memberListAvatar: [
            'assets/member_one.jpg',
            'assets/member_two.jpg',
            'assets/member_three.jpg',
            'assets/member_four.jpg',
          ],
          memberAvatar: 'assets/member_six.jpg'),
      TrendingPopularPeople(
          title: 'Author',
          membersCount: 1243535242,
          memberListAvatar: [
            'assets/image_one.jpg',
            'assets/image_two.jpg',
            'assets/image_three.jpg',
            'assets/member_four.jpg',
            'assets/member_one.jpg',
            'assets/member_two.jpg',
          ],
          memberAvatar: 'assets/member_two.jpg'),
      TrendingPopularPeople(
          title: 'Member',
          membersCount: 2525,
          memberListAvatar: [
            'assets/member_four.jpg',
            'assets/member_one.jpg',
            'assets/member_two.jpg',
            'assets/image_two.jpg',
            'assets/image_three.jpg',
          ],
          memberAvatar: 'assets/member_four.jpg'),
    ];

    List<TopTrendingMeetup> topTrendingMeetup = [
      TopTrendingMeetup(imageUrl: 'assets/member_three.jpg', title: 'Stanford Seed', subTitle: 'Meetup 01'),
      TopTrendingMeetup(imageUrl: 'assets/member_one.jpg', title: 'Stanford Seed', subTitle: 'Meetup 02'),
      TopTrendingMeetup(imageUrl: 'assets/member_two.jpg', title: 'Stanford Seed', subTitle: 'Meetup 03'),
      TopTrendingMeetup(imageUrl: 'assets/member_six.jpg', title: 'Stanford Seed', subTitle: 'Meetup 04'),
      TopTrendingMeetup(imageUrl: 'assets/image_two.jpg', title: 'Stanford Seed', subTitle: 'Meetup 05'),
    ];
    individualMeetup = IndividualMeetup(slideList: slideListImage, trendingPopularPeople: trendingPopularPeople, topTrendingMeetup: topTrendingMeetup);
  }

  void getDescriptionData(int index, BuildContext context) {
    switch (index) {
      case 0:
        description = Description(
          imageList: [
            'assets/member_one.jpg',
            'assets/member_two.jpg',
            'assets/member_three.jpg',
            'assets/member_four.jpg',
          ],
          saveCount: 1000,
          isDownloaded: false,
          isFavorite: false,
          isSaved: false,
          isStared: false,
          favoriteCount: 1234,
          rating: 3.8,
          actorName: 'Indian Actor',
          durationTime: '2 Hr',
          totalAvgFees: '4353',
          about: "Lorem  it to make a type specimen book. It has survived traset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
        );
        Navigator.of(context).pushNamed('/description');
        break;
      case 3:
        description = Description(
          imageList: [
            'assets/member_one.jpg',
            'assets/member_two.jpg',
            'assets/member_three.jpg',
            'assets/member_four.jpg',
          ],
          saveCount: 1000,
          isDownloaded: false,
          isFavorite: false,
          isSaved: false,
          isStared: false,
          favoriteCount: 1234,
          rating: 3.8,
          actorName: 'Indian Actor',
          durationTime: '2 Hr',
          totalAvgFees: '4353',
          about: "Lorem  it to make a type specimen book. It has survived traset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
        );
        Navigator.of(context).pushNamed('/description');
        break;
      case 1:
        description = Description(
            imageList: [
              'assets/member_six.jpg',
              'assets/member_three.jpg',
              'assets/member_four.jpg',
              'assets/member_one.jpg',
              'assets/member_two.jpg',
            ],
            saveCount: 200,
            isDownloaded: false,
            isFavorite: false,
            isSaved: false,
            isStared: false,
            favoriteCount: 12344,
            rating: 3.5,
            actorName: 'American Actor',
            durationTime: '21 Hr',
            totalAvgFees: '444353',
            about:
                "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc");
        Navigator.of(context).pushNamed('/description');
        break;
      case 2:
        description = Description(
            imageList: [
              'assets/image_one.jpg',
              'assets/image_two.jpg',
              'assets/image_three.jpg',
              'assets/member_four.jpg',
              'assets/member_one.jpg',
              'assets/member_two.jpg',
            ],
            saveCount: 200,
            isDownloaded: false,
            isFavorite: false,
            isSaved: false,
            isStared: false,
            favoriteCount: 2344,
            rating: 2,
            actorName: 'USA Actor',
            durationTime: '30 Hr',
            totalAvgFees: '353',
            about:
                "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum,");

        break;
      case 4:
        description = Description(
            imageList: [
              'assets/image_one.jpg',
              'assets/image_two.jpg',
              'assets/image_three.jpg',
              'assets/member_four.jpg',
              'assets/member_one.jpg',
              'assets/member_two.jpg',
            ],
            saveCount: 200,
            isDownloaded: false,
            isFavorite: false,
            isSaved: false,
            isStared: false,
            favoriteCount: 2344,
            rating: 2,
            actorName: 'USA Actor',
            durationTime: '30 Hr',
            totalAvgFees: '353',
            about:
                "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum,");

        break;
      default:
        ToastMessage.showToastMessage('Invalid Index');
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return DescriptionPage(description: description);
      },
    ));
  }
}
