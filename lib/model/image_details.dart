class ImageDetails {
  final String imageUrl;
  final bool isDownloaded;
  final bool isSaved;
  final bool isFavorite;
  final bool isStared;

  ImageDetails({
    required this.imageUrl,
    this.isDownloaded = false,
    this.isSaved = false,
    this.isFavorite = false,
    this.isStared = false,
  });

  // copyWith method
  ImageDetails copyWith({
    String? imageUrl,
    bool? isDownloaded,
    bool? isSaved,
    bool? isFavorite,
    bool? isStared,
  }) {
    return ImageDetails(
      imageUrl: imageUrl ?? this.imageUrl,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isSaved: isSaved ?? this.isSaved,
      isFavorite: isFavorite ?? this.isFavorite,
      isStared: isStared ?? this.isStared,
    );
  }

  @override
  String toString() {
    return 'ImageDetails(imageUrl: $imageUrl, isDownloaded: $isDownloaded, isSaved: $isSaved, isFavorite: $isFavorite, isStared: $isStared)';
  }
}
