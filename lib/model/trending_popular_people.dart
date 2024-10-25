class TrendingPopularPeople {
  String title;
  int membersCount;
  List<String> memberListAvatar;
  String memberAvatar;

  TrendingPopularPeople({
    required this.title,
    required this.membersCount,
    required this.memberListAvatar,
    required this.memberAvatar,
  });

  // Factory constructor to create a Group object from JSON
  factory TrendingPopularPeople.fromJson(Map<String, dynamic> json) {
    return TrendingPopularPeople(
      title: json['title'],
      membersCount: json['membersCount'],
      memberListAvatar: List<String>.from(json['memberListAvatar']),
      memberAvatar: json['memberAvatar'],
    );
  }

  // Method to convert Group object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'membersCount': membersCount,
      'memberListAvatar': memberListAvatar,
      'memberAvatar': memberAvatar,
    };
  }

  // copyWith method
  TrendingPopularPeople copyWith({
    String? title,
    int? membersCount,
    List<String>? memberListAvatar,
    String? memberAvatar,
  }) {
    return TrendingPopularPeople(
      title: title ?? this.title,
      membersCount: membersCount ?? this.membersCount,
      memberListAvatar: memberListAvatar ?? List.from(this.memberListAvatar),
      memberAvatar: memberAvatar ?? this.memberAvatar,
    );
  }

  // Override toString for easy printing of object
  @override
  String toString() {
    return 'Group(title: $title, membersCount: $membersCount, memberListAvatar: $memberListAvatar, memberAvatar: $memberAvatar)';
  }
}
