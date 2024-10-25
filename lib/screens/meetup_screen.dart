import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_development_task/model/individual_meetup_model.dart';
import 'package:intl/intl.dart';

import '../constants/string_constants.dart';
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
  late final IndividualMeetup individualMeetup;
  final List<String> imgList = [
    'assets/image_one.jpg',
    'assets/image_two.jpg',
    'assets/image_three.jpg',
    'assets/image_one.jpg',
    'assets/image_two.jpg',
    'assets/image_three.jpg',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> slideListImage = [
      'assets/meetup_one.jpg',
      'assets/meetup_two.jpg',
      'assets/member_one.jpg',
    ];
    List<TrendingPopularPeople> trendingPopularPeople = [
      TrendingPopularPeople(
          title: 'Author',
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
          membersCount: 124242,
          memberListAvatar: [
            'assets/member_one.jpg',
            'assets/member_two.jpg',
            'assets/member_three.jpg',
            'assets/member_four.jpg',
          ],
          memberAvatar: 'assets/member_six.jpg'),
    ];

    List<TopTrendingMeetup> topTrendingMeetup = [
      TopTrendingMeetup(imageUrl: 'assets/member_three.jpg', title: 'Stanford See', subTitle: 'Meetup 01'),
      TopTrendingMeetup(imageUrl: 'assets/member_three.jpg', title: 'Stanford See', subTitle: 'Meetup 01'),
      TopTrendingMeetup(imageUrl: 'assets/member_three.jpg', title: 'Stanford See', subTitle: 'Meetup 01'),
      TopTrendingMeetup(imageUrl: 'assets/member_three.jpg', title: 'Stanford See', subTitle: 'Meetup 01'),
      TopTrendingMeetup(imageUrl: 'assets/member_three.jpg', title: 'Stanford See', subTitle: 'Meetup 01'),
    ];
    individualMeetup = IndividualMeetup(slideList: slideListImage, trendingPopularPeople: trendingPopularPeople, topTrendingMeetup: topTrendingMeetup);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = _buildMeetupContent(context);
            break;
          case '/description':
            page = DescriptionPage(); // Your description page
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }

  // Original Meetup Content
  Widget _buildMeetupContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                  suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.keyboard_voice_outlined)),
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: 'Search',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                carouselController: CarouselSliderController(),
                options: CarouselOptions(
                  height: MediaQuery.sizeOf(context).height * .25,
                  enableInfiniteScroll: true,
                  animateToClosest: true,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  reverse: false,
                  scrollPhysics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
                  autoPlay: true,
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
                items: individualMeetup.slideList
                    .map(
                      (item) => ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Center(
                          child: Image.asset(
                            item,
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height * .25,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      _currentIndex = entry.key;
                    }),
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
                height: MediaQuery.sizeOf(context).height * .25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: individualMeetup.trendingPopularPeople.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1, strokeAlign: BorderSide.strokeAlignInside), borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.sizeOf(context).width * .8,
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
                                  Text(individualMeetup.trendingPopularPeople.elementAt(index).title),
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
                              onPressed: () {},
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: individualMeetup.topTrendingMeetup.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/description'); // Navigate to description
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * .6,
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
                                Text(individualMeetup.topTrendingMeetup.elementAt(index).title, style: TextStyle(fontWeight: FontWeight.bold)),
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
}

// import 'dart:developer';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_development_task/screens/description_screen.dart';
// import 'package:intl/intl.dart';
//
// class MeetupScreen extends StatefulWidget {
//   const MeetupScreen({super.key});
//
//   @override
//   MeetupScreenState createState() => MeetupScreenState();
// }
//
// class MeetupScreenState extends State<MeetupScreen> {
//   int _currentIndex = 0;
//   final List<String> imgList = [
//     'assets/image_one.jpg',
//     'assets/image_two.jpg',
//     'assets/image_three.jpg',
//     'assets/image_one.jpg',
//     'assets/image_two.jpg',
//   ];
//   final List<Color> colors = [
//     Colors.red,
//     Colors.pink,
//     Colors.blue,
//     Colors.orange,
//     Colors.purple,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               TextField(
//                 decoration: InputDecoration(
//                   suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.keyboard_voice_outlined)),
//                   prefixIcon: const Icon(Icons.search_rounded),
//                   hintText: 'Search',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               CarouselSlider(
//                 carouselController: CarouselSliderController(),
//                 options: CarouselOptions(
//                   height: MediaQuery.sizeOf(context).height * .25,
//                   enableInfiniteScroll: true,
//                   animateToClosest: true,
//                   enlargeCenterPage: true,
//                   pageSnapping: true,
//                   reverse: false,
//                   scrollPhysics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
//                   autoPlay: true,
//                   autoPlayInterval: const Duration(seconds: 4),
//                   viewportFraction: 1.0,
//                   // onScrolled: (value) {
//                   // log('on scrolled $value');
//                   //   isScrolling = true;
//                   //   setState(() {});
//                   // },
//                   onPageChanged: (index, reason) {
//                     log('index: $index and reason $reason');
//                     setState(() {
//                       _currentIndex = index;
//                     });
//                   },
//                 ),
//                 items: imgList
//                     .map(
//                       (item) => ClipRRect(
//                         borderRadius: BorderRadius.circular(14),
//                         child: Center(
//                           child: Image.asset(
//                             item,
//                             width: MediaQuery.sizeOf(context).width,
//                             height: MediaQuery.sizeOf(context).height * .25,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//               // Page Indicator
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: imgList.asMap().entries.map((entry) {
//                   return GestureDetector(
//                     onTap: () => setState(() {
//                       _currentIndex = entry.key;
//                     }),
//                     child: Container(
//                       width: 8.0,
//                       height: 8.0,
//                       margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: _currentIndex == entry.key ? Colors.blue : Colors.grey,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 10),
//               const Text('Trending Popular People', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * .25,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsets.only(right: 15),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                             width: 1,
//                             strokeAlign: BorderSide.strokeAlignInside,
//                           ),
//                           borderRadius: BorderRadius.circular(10)),
//                       width: MediaQuery.sizeOf(context).width * .8,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CircleAvatar(
//                                 backgroundImage: AssetImage(imgList.first),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   const Text("Author"),
//                                   Text('${getFormat(154234)} Meetups'),
//                                 ],
//                               )
//                             ],
//                           ),
//                           const Divider(),
//                           SizedBox(
//                             height: 50,
//                             child: Stack(
//                               children: imgList.asMap().entries.map((entry) {
//                                 int index = entry.key;
//                                 String imageUrl = entry.value;
//                                 return Positioned(
//                                   left: index * 40.0, // Adjust this value for overlap
//                                   child: CircleAvatar(
//                                     radius: 25,
//                                     backgroundImage: AssetImage(imageUrl),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: ElevatedButton(
//                               style: ButtonStyle(
//                                 backgroundColor: WidgetStateProperty.resolveWith(
//                                   (states) => Colors.blue,
//                                 ),
//                                 elevation: WidgetStateProperty.resolveWith(
//                                   (states) => 0,
//                                 ),
//                                 shape: WidgetStateProperty.resolveWith(
//                                   (states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                                 ),
//                               ),
//                               onPressed: () {},
//                               child: const Text(
//                                 'See More',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text('Top Trending Meetups', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 280,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         // Navigate to description page (Screen3)
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage()));
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 12),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: SizedBox(
//                             width: MediaQuery.sizeOf(context).width * .6,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.asset(
//                                     width: double.infinity,
//                                     height: 200,
//                                     imgList.first,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const Text('Stanford Seed', style: TextStyle(fontWeight: FontWeight.bold)),
//                                 const Text('Meetup 01'),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String getFormat(int number) {
//     String format = NumberFormat.currency(
//       locale: 'en_IN', // Indian Locale
//       decimalDigits: 0, // No decimal places
//       symbol: '', // Remove currency symbol
//     ).format(number);
//     return format;
//   }
// }
