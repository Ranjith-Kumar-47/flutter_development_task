import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_development_task/screens/description_screen.dart';

class MeetupScreen extends StatefulWidget {
  @override
  _MeetupScreenState createState() => _MeetupScreenState();
}

class _MeetupScreenState extends State<MeetupScreen> {
  int _currentIndex = 0;
  final List<String> imgList = [
    'https://via.placeholder.com/400x200.png?text=Image+1',
    'https://via.placeholder.com/400x200.png?text=Image+2',
    'https://via.placeholder.com/400x200.png?text=Image+3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Individual Meetup'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider with 3 Images
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: imgList.map((item) => Image.network(item, fit: BoxFit.cover, width: double.infinity)).toList(),
              ),
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
                      color: _currentIndex == entry.key ? Colors.teal : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Trending Popular People (Horizontal Scrollable Cards)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Trending Popular People', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to description page (Screen3)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage()));
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 4)],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://via.placeholder.com/150.png?text=Avatar'),
                          ),
                          SizedBox(height: 10),
                          Text('Author', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('1,029 Meetups'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Top Trending Meetups (Scrollable Cards)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Top Trending Meetups', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to description page (Screen3)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage()));
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 4)],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://via.placeholder.com/150x100.png?text=Meetup',
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          const Text('Stanford Seed', style: TextStyle(fontWeight: FontWeight.bold)),
                          const Text('Meetup 01'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Meetup'),
          const BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          const BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}
