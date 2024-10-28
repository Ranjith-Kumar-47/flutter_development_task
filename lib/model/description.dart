class Description {
  final List<String> imageList;
  final bool isDownloaded;
  final bool isSaved;
  final bool isFavorite;
  final bool isStared;
  final int saveCount;
  final int favoriteCount;
  final double rating;
  final String actorName;
  final String durationTime;
  final String totalAvgFees;
  final String about;

  Description({
    this.imageList = const [],
    this.isDownloaded = false,
    this.isSaved = false,
    this.isFavorite = false,
    this.isStared = false,
    this.saveCount = 0,
    this.favoriteCount = 0,
    this.rating = 0.0,
    this.actorName = '',
    this.durationTime = '',
    this.totalAvgFees = '',
    this.about = '',
  });

  // copyWith method
  Description copyWith({
    List<String>? imageList,
    bool? isDownloaded,
    bool? isSaved,
    bool? isFavorite,
    bool? isStared,
    int? saveCount,
    int? favoriteCount,
    double? rating,
    String? actorName,
    String? durationTime,
    String? totalAvgFees,
    String? about,
  }) {
    return Description(
      imageList: imageList ?? this.imageList,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isSaved: isSaved ?? this.isSaved,
      isFavorite: isFavorite ?? this.isFavorite,
      isStared: isStared ?? this.isStared,
      saveCount: saveCount ?? this.saveCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      rating: rating ?? this.rating,
      actorName: actorName ?? this.actorName,
      durationTime: durationTime ?? this.durationTime,
      totalAvgFees: totalAvgFees ?? this.totalAvgFees,
      about: about ?? this.about,
    );
  }

  @override
  String toString() {
    return 'Description(imageList: $imageList, isDownloaded: $isDownloaded, isSaved: $isSaved, isFavorite: $isFavorite, isStared: $isStared, saveCount: $saveCount, favoriteCount: $favoriteCount, rating: $rating, actorName: $actorName, durationTime: $durationTime, totalAvgFees: $totalAvgFees, about: $about)';
  }
}
