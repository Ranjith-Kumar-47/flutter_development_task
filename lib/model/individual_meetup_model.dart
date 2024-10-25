import 'package:flutter_development_task/model/top_trending_meetup.dart';
import 'package:flutter_development_task/model/trending_popular_people.dart';

class IndividualMeetup {
  final List<String> slideList;
  final List<TrendingPopularPeople> trendingPopularPeople;
  final List<TopTrendingMeetup> topTrendingMeetup;

  IndividualMeetup({
    required this.slideList,
    required this.trendingPopularPeople,
    required this.topTrendingMeetup,
  });

  // Factory constructor to create an IndividualMeetup object from JSON
  factory IndividualMeetup.fromJson(Map<String, dynamic> json) {
    return IndividualMeetup(
      slideList: List<String>.from(json['slideList']),
      trendingPopularPeople: (json['trendingPopularPeople'] as List).map((item) => TrendingPopularPeople.fromJson(item)).toList(),
      topTrendingMeetup: (json['topTrendingMeetup'] as List).map((item) => TopTrendingMeetup.fromJson(item)).toList(),
    );
  }

  // Method to convert IndividualMeetup object to JSON
  Map<String, dynamic> toJson() {
    return {
      'slideList': slideList,
      'trendingPopularPeople': trendingPopularPeople.map((item) => item.toJson()).toList(),
      'topTrendingMeetup': topTrendingMeetup.map((item) => item.toJson()).toList(),
    };
  }

  // copyWith method
  IndividualMeetup copyWith({
    List<String>? slideList,
    List<TrendingPopularPeople>? trendingPopularPeople,
    List<TopTrendingMeetup>? topTrendingMeetup,
  }) {
    return IndividualMeetup(
      slideList: slideList ?? List.from(this.slideList),
      trendingPopularPeople: trendingPopularPeople ?? List.from(this.trendingPopularPeople),
      topTrendingMeetup: topTrendingMeetup ?? List.from(this.topTrendingMeetup),
    );
  }

  // Override toString for easy printing of object
  @override
  String toString() {
    return 'IndividualMeetup(slideList: $slideList, trendingPopularPeople: $trendingPopularPeople, topTrendingMeetup: $topTrendingMeetup)';
  }
}
