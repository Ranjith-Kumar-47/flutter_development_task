class TopTrendingMeetup {
  String imageUrl;
  String title;
  String subTitle;

  TopTrendingMeetup({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  });

  // Factory constructor to create a TopTrendingMeetup object from JSON
  factory TopTrendingMeetup.fromJson(Map<String, dynamic> json) {
    return TopTrendingMeetup(
      imageUrl: json['imageUrl'],
      title: json['title'],
      subTitle: json['subTitle'],
    );
  }

  // Method to convert TopTrendingMeetup object to JSON
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'subTitle': subTitle,
    };
  }

  // copyWith method
  TopTrendingMeetup copyWith({
    String? imageUrl,
    String? title,
    String? subTitle,
  }) {
    return TopTrendingMeetup(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
    );
  }

  // Override toString for easy printing of object
  @override
  String toString() {
    return 'TopTrendingMeetup(imageUrl: $imageUrl, title: $title, subTitle: $subTitle)';
  }
}
