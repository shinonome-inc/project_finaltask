class Tag {
  final String iconUrl;
  final String id;
  final int follower;
  final int? articlecount;

  Tag(
      {required this.iconUrl,
        required this.id,
        required this.follower,
        required this.articlecount});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      iconUrl: json['icon_url'],
      id: json['id'],
      follower: json['followers_count'],
        articlecount: json['items_count']
    );
  }
}